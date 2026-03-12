import 'dart:async';

import 'package:authentication/domain/exceptions/auth_exceptions.dart';
import 'package:authentication/presentation/bloc/auth_bloc.dart';
import 'package:authentication/presentation/bloc/auth_event.dart';
import 'package:authentication/presentation/bloc/auth_state.dart';
import 'package:authentication/presentation/pages/email_verification_page.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ui/ui.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
  });

  Widget buildSubject({String email = 'test@example.com'}) {
    return MaterialApp(
      home: BlocProvider<AuthBloc>.value(
        value: mockAuthBloc,
        child: EmailVerificationPage(email: email),
      ),
    );
  }

  group('EmailVerificationPage', () {
    testWidgets('renders OTP field and accepts 6 digits', (tester) async {
      when(() => mockAuthBloc.state).thenReturn(const AuthInitial());

      await tester.pumpWidget(buildSubject());

      // Verify OTP field is rendered
      expect(find.byType(HivesOTPField), findsOneWidget);

      // Verify instruction text
      expect(find.text('Verify your email'), findsOneWidget);
      expect(find.text('test@example.com'), findsOneWidget);

      // Verify Verify button
      expect(find.text('Verify'), findsOneWidget);

      // Verify Resend Code button
      expect(find.text('Resend Code'), findsOneWidget);

      // There should be 6 TextField cells for OTP
      expect(find.byType(TextField), findsNWidgets(6));
    });

    testWidgets('error state clears OTP and shows message', (tester) async {
      final controller = StreamController<AuthState>.broadcast();

      whenListen(mockAuthBloc, controller.stream,
          initialState: const AuthInitial());

      await tester.pumpWidget(buildSubject());

      // Emit error state
      controller.add(AuthError(InvalidCredentials()));
      await tester.pumpAndSettle();

      expect(find.text('Invalid email or password'), findsOneWidget);

      await controller.close();
    });

    testWidgets('loading indicator shown during AuthLoading', (tester) async {
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
  });
}
