import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

/// Email verification screen accepting a 6-digit OTP code.
///
/// Displayed after successful sign-up. The user enters the confirmation
/// code sent to their email. On successful verification, navigates to
/// sign-in (Cognito requires separate sign-in after confirmation).
class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key, required this.email});

  /// The email address that the OTP was sent to.
  final String email;

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final _otpKey = GlobalKey<HivesOTPFieldState>();
  String _otpCode = '';
  bool _hasOtpError = false;
  bool _resendInProgress = false;

  void _onOtpComplete(String code) {
    setState(() {
      _otpCode = code;
    });
  }

  void _onVerify() {
    if (_otpCode.length != 6) return;

    final emailResult = Email.create(widget.email);
    emailResult.fold(
      (_) => null,
      (email) {
        context.read<AuthBloc>().add(
              ConfirmSignUpRequested(
                email: email,
                confirmationCode: _otpCode,
              ),
            );
      },
    );
  }

  void _onResendCode() {
    final emailResult = Email.create(widget.email);
    emailResult.fold(
      (_) => null,
      (email) {
        _resendInProgress = true;
        context.read<AuthBloc>().add(
              ResendConfirmationCodeRequested(email: email),
            );
      },
    );
  }

  void _onAuthStateChanged(BuildContext context, AuthState state) {
    switch (state) {
      case Unauthenticated():
        if (_resendInProgress) {
          // Code resent successfully — stay on page, confirm to user.
          _resendInProgress = false;
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Verification code resent')),
            );
        } else {
          // Successful OTP confirmation — navigate to main app (AC 2).
          context.go('/home');
        }
      case AuthError(exception: final exception):
        _resendInProgress = false;
        setState(() {
          _hasOtpError = true;
          _otpCode = '';
        });
        _otpKey.currentState?.clear();
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text(exception.message)),
          );
        // Reset error state after shake animation
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            setState(() => _hasOtpError = false);
          }
        });
      case Authenticated():
        break;
      case AuthInitial():
      case AuthLoading():
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: _onAuthStateChanged,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenMargin,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.mark_email_read_outlined,
                    size: 64,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    'Verify your email',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'We sent a 6-digit code to',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    widget.email,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.sectionGap),
                  HivesOTPField(
                    key: _otpKey,
                    hasError: _hasOtpError,
                    onComplete: _onOtpComplete,
                  ),
                  const SizedBox(height: AppSpacing.sectionGap),
                  _buildVerifyButton(),
                  const SizedBox(height: AppSpacing.lg),
                  TextButton(
                    onPressed: _onResendCode,
                    child: Text(
                      'Resend Code',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVerifyButton() {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) =>
          current is AuthLoading || previous is AuthLoading,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: AppSpacing.buttonHeight,
          child: PrimaryButton(
            label: 'Verify',
            isLoading: state is AuthLoading,
            isEnabled: _otpCode.length == 6,
            onPressed: _onVerify,
          ),
        );
      },
    );
  }
}
