import 'dart:async';

import 'package:authentication/domain/aggregates/user_aggregate.dart';

abstract class AuthenticationRepository {
  FutureOr<UserAggregate> login(String username, String password);

  FutureOr<void> logout();
}
