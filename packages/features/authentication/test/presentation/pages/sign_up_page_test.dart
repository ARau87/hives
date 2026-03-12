import 'dart:async';

import 'package:authentication/domain/aggregates/user_aggregate.dart';
import 'package:authentication/domain/exceptions/auth_exceptions.dart';
import 'package:authentication/presentation/bloc/auth_bloc.dart';
import 'package:authentication/presentation/bloc/auth_event.dart';
import 'package:authentication/presentation/bloc/auth_state.dart';
import 'package:authentication/presentation/pages/email_verification_page.dart';
import 'package:authentication/presentation/pages/sign_up_page.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ui/ui.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUpAll(() {
    registerFallbackValue(const CheckAuthStatus());
  });

  setUp(() {
    mockAuthBloc = MockAuthBloc();
  });

  Widget buildSubject() {
    return MaterialApp(
      home: BlocProvider<AuthBloc>.value(
        value: mockAuthBloc,
        child: const SignUpPage(),
      ),
    );
  }

  group('SignUpPage', () {
    testWidgets('renders all required components', (tester) async {
      when(() => mockAuthBloc.state).thenReturn(const AuthInitial());

      await tester.pumpWidget(buildSubject());

      // HivesAuthHeader with signUp variant
      expect(find.text('Start managing your hives today'), findsOneWidget);

      // Email and Password fields
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);

      // Sign Up button
      expect(find.text('Sign Up'), findsOneWidget);

      // Sign In link text (inside Text.rich with TextSpan)
      expect(find.textContaining('Sign In'), findsOneWidget);

      // Password strength indicator
      expect(find.byType(HivesPasswordStrengthIndicator), findsOneWidget);

      // Auth header
      expect(find.byType(HivesAuthHeader), findsOneWidget);
    });

    testWidgets('email validation error appears on invalid input + focus loss',
        (tester) async {
      when(() => mockAuthBloc.state).thenReturn(const AuthInitial());

      await tester.pumpWidget(buildSubject());

      // Enter invalid email
      final emailField = find.byType(TextField).first;
      await tester.tap(emailField);
      await tester.enterText(emailField, 'invalid-email');

      // Move focus away (tap password field)
      final passwordField = find.byType(TextField).at(1);
      await tester.tap(passwordField);
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email'), findsOneWidget);
    });

    testWidgets(
        'password validation error appears on weak password + focus loss',
        (tester) async {
      when(() => mockAuthBloc.state).thenReturn(const AuthInitial());

      await tester.pumpWidget(buildSubject());

      // Enter weak password
      final passwordField = find.byType(TextField).at(1);
      await tester.tap(passwordField);
      await tester.enterText(passwordField, 'weak');

      // Move focus away
      final emailField = find.byType(TextField).first;
      await tester.tap(emailField);
      await tester.pumpAndSettle();

      // Password strength indicator should show rules
      expect(find.text('8+ characters'), findsOneWidget);
    });

    testWidgets('sign up button disabled when validation fails',
        (tester) async {
      when(() => mockAuthBloc.state).thenReturn(const AuthInitial());

      await tester.pumpWidget(buildSubject());

      // Find PrimaryButton — it should be disabled (not enabled) by default
      final primaryButton = tester.widget<PrimaryButton>(
        find.byType(PrimaryButton),
      );
      expect(primaryButton.isEnabled, isFalse);
    });

    testWidgets('sign up button enabled when both fields valid',
        (tester) async {
      when(() => mockAuthBloc.state).thenReturn(const AuthInitial());

      await tester.pumpWidget(buildSubject());

      // Enter valid email
      final emailField = find.byType(TextField).first;
      await tester.enterText(emailField, 'test@example.com');

      // Trigger email validation by losing focus
      final passwordField = find.byType(TextField).at(1);
      await tester.tap(passwordField);
      await tester.pumpAndSettle();

      // Enter valid password
      await tester.enterText(passwordField, 'StrongPass1');

      // Trigger password validation by losing focus
      await tester.tap(emailField);
      await tester.pumpAndSettle();

      // Button should be enabled
      final primaryButton = tester.widget<PrimaryButton>(
        find.byType(PrimaryButton),
      );
      expect(primaryButton.isEnabled, isTrue);
    });

    testWidgets('loading indicator shown during AuthLoading state',
        (tester) async {
      whenListen(
        mockAuthBloc,
        Stream<AuthState>.fromIterable([const AuthLoading()]),
        initialState: const AuthLoading(),
      );

      await tester.pumpWidget(buildSubject());
      await tester.pump();

      // PrimaryButton should be in loading state
      final primaryButton = tester.widget<PrimaryButton>(
        find.byType(PrimaryButton),
      );
      expect(primaryButton.isLoading, isTrue);
    });

    testWidgets('error snackbar shown on AuthError state', (tester) async {
      final controller = StreamController<AuthState>.broadcast();

      whenListen(mockAuthBloc, controller.stream,
          initialState: const AuthInitial());

      await tester.pumpWidget(buildSubject());

      // Emit error state
      controller.add(AuthError(EmailAlreadyExists()));
      await tester.pumpAndSettle();

      expect(find.text('Email already in use'), findsOneWidget);

      await controller.close();
    });

    testWidgets('dispatches SignUpRequested with validated value objects',
        (tester) async {
      when(() => mockAuthBloc.state).thenReturn(const AuthInitial());

      await tester.pumpWidget(buildSubject());

      // Enter valid email and password
      final emailField = find.byType(TextField).first;
      await tester.enterText(emailField, 'test@example.com');

      final passwordField = find.byType(TextField).at(1);
      await tester.tap(passwordField);
      await tester.pumpAndSettle();

      await tester.enterText(passwordField, 'StrongPass1');

      // Validate password by losing focus
      await tester.tap(emailField);
      await tester.pumpAndSettle();

      // Tap Sign Up button — find by text within the page
      await tester.tap(find.text('Sign Up'));
      await tester.pump();

      // Verify event dispatched
      verify(() => mockAuthBloc.add(any(that: isA<SignUpRequested>()))).called(1);
    });

    testWidgets('navigates to verify-email page on Authenticated state after sign up',
        (tester) async {
      final controller = StreamController<AuthState>.broadcast();
      whenListen(mockAuthBloc, controller.stream,
          initialState: const AuthInitial());

      final router = GoRouter(
        initialLocation: '/auth/sign-up',
        routes: [
          GoRoute(
            path: '/auth/sign-up',
            name: 'signUp',
            builder: (_, __) => BlocProvider<AuthBloc>.value(
              value: mockAuthBloc,
              child: const SignUpPage(),
            ),
          ),
          GoRoute(
            path: '/auth/verify-email',
            name: 'verifyEmail',
            builder: (_, state) => EmailVerificationPage(
              email: state.uri.queryParameters['email'] ?? '',
            ),
          ),
        ],
      );

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();

      // Enter valid email and trigger focus loss to validate
      final emailField = find.byType(TextField).first;
      await tester.enterText(emailField, 'test@example.com');
      final passwordField = find.byType(TextField).at(1);
      await tester.tap(passwordField);
      await tester.pumpAndSettle();

      // Enter valid password and trigger focus loss to validate
      await tester.enterText(passwordField, 'StrongPass1');
      await tester.tap(emailField);
      await tester.pumpAndSettle();

      // Tap Sign Up — sets _signUpInProgress = true
      await tester.tap(find.text('Sign Up'));
      await tester.pump();

      // Emit Authenticated state (sign-up success)
      final mockUser = UserAggregate.reconstitute(
        id: 'test-id',
        email: 'test@example.com',
        createdAt: DateTime(2026),
      );
      controller.add(const AuthLoading());
      await tester.pump();
      controller.add(Authenticated(mockUser));
      await tester.pumpAndSettle();

      // Verify navigation to email verification page
      expect(find.byType(EmailVerificationPage), findsOneWidget);
      expect(find.text('test@example.com'), findsOneWidget);

      await controller.close();
    });
  });
}
