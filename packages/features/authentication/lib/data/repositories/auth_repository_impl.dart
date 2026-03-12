import 'package:authentication/data/datasources/auth_local_datasource.dart';
import 'package:authentication/data/datasources/auth_remote_datasource.dart';
import 'package:authentication/domain/aggregates/user_aggregate.dart';
import 'package:authentication/domain/events/auth_events.dart';
import 'package:authentication/domain/exceptions/auth_exceptions.dart';
import 'package:authentication/domain/repositories/authentication_repository.dart';
import 'package:authentication/domain/value_objects/email.dart';
import 'package:authentication/domain/value_objects/password.dart';
import 'package:authentication/domain/value_objects/user_id.dart';
import 'package:core_infrastructure/core_infrastructure.dart';
import 'package:fpdart/fpdart.dart';

/// Concrete [AuthenticationRepository] connecting domain to Cognito data
/// source and local secure storage.
///
/// All methods return [Either] — exceptions from the data source are caught
/// and wrapped in [Left]. Side effects (token storage, domain events) are
/// managed atomically within each operation.
class AuthRepositoryImpl implements AuthenticationRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
    required EventBus eventBus,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _eventBus = eventBus;

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  final EventBus _eventBus;

  @override
  Future<Either<AuthException, UserAggregate>> signUp({
    required Email email,
    required Password password,
  }) async {
    try {
      final userSub = await _remoteDataSource.signUp(
        email: email.value,
        password: password.value,
      );
      final user = UserAggregate.reconstitute(
        id: userSub,
        email: email.value,
        createdAt: DateTime.now(),
      );
      return Right(user);
    } on AuthException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(NetworkError(e.toString()));
    }
  }

  @override
  Future<Either<AuthException, Unit>> confirmSignUp({
    required Email email,
    required String confirmationCode,
  }) async {
    try {
      await _remoteDataSource.confirmSignUp(
        email: email.value,
        confirmationCode: confirmationCode,
      );
      return const Right(unit);
    } on AuthException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(NetworkError(e.toString()));
    }
  }

  @override
  Future<Either<AuthException, UserAggregate>> signIn({
    required Email email,
    required Password password,
  }) async {
    try {
      final result = await _remoteDataSource.signIn(
        email: email.value,
        password: password.value,
      );
      await _localDataSource.saveTokens(result, email.value);
      final user = UserAggregate.reconstitute(
        id: result.userSub,
        email: email.value,
        createdAt: DateTime.now(),
      );
      _eventBus.publish(AuthUserLoggedIn(userId: user.id));
      return Right(user);
    } on AuthException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(NetworkError(e.toString()));
    }
  }

  @override
  Future<Either<AuthException, Unit>> signOut() async {
    try {
      // Read userId before clearing tokens so we can publish the event
      final userSub = await _localDataSource.getUserSub();
      await _remoteDataSource.signOut();
      await _localDataSource.clearTokens();
      if (userSub != null) {
        _eventBus.publish(
          AuthUserLoggedOut(userId: UserId.fromString(userSub)),
        );
      }
      return const Right(unit);
    } on AuthException catch (e) {
      // Clear local tokens even if remote sign-out fails to prevent stuck state
      await _localDataSource.clearTokens();
      return Left(e);
    } catch (e) {
      // Clear local tokens even if remote sign-out fails to prevent stuck state
      await _localDataSource.clearTokens();
      return Left(NetworkError(e.toString()));
    }
  }

  @override
  Future<Either<AuthException, Unit>> resendConfirmationCode({
    required Email email,
  }) async {
    try {
      await _remoteDataSource.resendConfirmationCode(email: email.value);
      return const Right(unit);
    } on AuthException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(NetworkError(e.toString()));
    }
  }

  @override
  Future<Either<AuthException, Unit>> resetPassword({
    required Email email,
  }) async {
    try {
      await _remoteDataSource.forgotPassword(email: email.value);
      return const Right(unit);
    } on AuthException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(NetworkError(e.toString()));
    }
  }

  @override
  Future<Either<AuthException, Unit>> confirmForgotPassword({
    required Email email,
    required String code,
    required Password newPassword,
  }) async {
    try {
      await _remoteDataSource.confirmForgotPassword(
        email: email.value,
        code: code,
        newPassword: newPassword.value,
      );
      return const Right(unit);
    } on AuthException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(NetworkError(e.toString()));
    }
  }

  @override
  Future<Either<AuthException, UserAggregate?>> getCurrentUser() async {
    try {
      final hasTokens = await _localDataSource.hasTokens();
      if (!hasTokens) {
        return const Right(null);
      }

      final result = await _remoteDataSource.getCurrentUser();
      if (result == null) {
        await _localDataSource.clearTokens();
        return const Right(null);
      }

      // Refresh stored tokens with latest from Cognito
      final email = await _localDataSource.getUserEmail();
      if (email == null) {
        await _localDataSource.clearTokens();
        return const Right(null);
      }

      await _localDataSource.saveTokens(result, email);
      final user = UserAggregate.reconstitute(
        id: result.userSub,
        email: email,
        createdAt: DateTime.now(),
      );
      return Right(user);
    } on AuthException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(NetworkError(e.toString()));
    }
  }
}
