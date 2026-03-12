import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

/// Sign-up screen allowing new users to create an account.
///
/// Uses [AuthBloc] for state management. Validates email and password
/// via domain value objects before dispatching [SignUpRequested].
/// On successful sign-up, navigates to the email verification page.
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;
  String _passwordText = '';
  bool _emailValid = false;
  bool _passwordValid = false;
  bool _signUpInProgress = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateEmail() {
    final result = Email.create(_emailController.text);
    setState(() {
      result.fold(
        (exception) {
          _emailError = 'Please enter a valid email';
          _emailValid = false;
        },
        (email) {
          _emailError = null;
          _emailValid = true;
        },
      );
    });
  }

  void _validatePassword() {
    final result = Password.create(_passwordController.text);
    setState(() {
      result.fold(
        (exception) {
          _passwordError = exception.message;
          _passwordValid = false;
        },
        (password) {
          _passwordError = null;
          _passwordValid = true;
        },
      );
    });
  }

  void _onPasswordChanged(String value) {
    setState(() {
      _passwordText = value;
    });
  }

  bool get _isFormValid => _emailValid && _passwordValid;

  void _onSignUp() {
    final emailResult = Email.create(_emailController.text);
    final passwordResult = Password.create(_passwordController.text);

    emailResult.fold(
      (_) => null,
      (email) {
        passwordResult.fold(
          (_) => null,
          (password) {
            _signUpInProgress = true;
            context.read<AuthBloc>().add(
                  SignUpRequested(email: email, password: password),
                );
          },
        );
      },
    );
  }

  void _onAuthStateChanged(BuildContext context, AuthState state) {
    switch (state) {
      case Authenticated(user: final user):
        // Only react to Authenticated from sign-up, not from CheckAuthStatus
        // (which fires on app start before the page is visible).
        if (_signUpInProgress) {
          _signUpInProgress = false;
          context.goNamed(
            'verifyEmail',
            queryParameters: {'email': user.email.value},
          );
        }
      case AuthError(exception: final exception):
        _signUpInProgress = false;
        final message = switch (exception) {
          EmailAlreadyExists() => 'Email already in use',
          _ => exception.message,
        };
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text(message)),
          );
      case AuthInitial():
      case AuthLoading():
      case Unauthenticated():
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const SizedBox(height: AppSpacing.sectionGap),
                  const HivesAuthHeader(
                    variant: HivesAuthHeaderVariant.signUp,
                  ),
                  const SizedBox(height: AppSpacing.sectionGap),
                  _buildEmailField(),
                  const SizedBox(height: AppSpacing.lg),
                  _buildPasswordField(),
                  const SizedBox(height: AppSpacing.md),
                  HivesPasswordStrengthIndicator(password: _passwordText),
                  const SizedBox(height: AppSpacing.sectionGap),
                  _buildSignUpButton(),
                  const SizedBox(height: AppSpacing.xl),
                  _buildSignInLink(),
                  const SizedBox(height: AppSpacing.sectionGap),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Focus(
      onFocusChange: (hasFocus) {
        if (!hasFocus && _emailController.text.isNotEmpty) {
          _validateEmail();
        }
      },
      child: HivesTextField(
        controller: _emailController,
        label: 'Email',
        hint: 'you@example.com',
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        errorText: _emailError,
        onChanged: (_) {
          if (_emailError != null) {
            setState(() => _emailError = null);
          }
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return Focus(
      onFocusChange: (hasFocus) {
        if (!hasFocus && _passwordController.text.isNotEmpty) {
          _validatePassword();
        }
      },
      child: HivesTextField(
        controller: _passwordController,
        label: 'Password',
        hint: 'Create a strong password',
        isPassword: true,
        textInputAction: TextInputAction.done,
        errorText: _passwordError,
        onChanged: _onPasswordChanged,
      ),
    );
  }

  Widget _buildSignUpButton() {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) =>
          current is AuthLoading || previous is AuthLoading,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: AppSpacing.buttonHeight,
          child: PrimaryButton(
            label: 'Sign Up',
            isLoading: state is AuthLoading,
            isEnabled: _isFormValid,
            onPressed: _onSignUp,
          ),
        );
      },
    );
  }

  Widget _buildSignInLink() {
    return TextButton(
      onPressed: () {
        // Navigation placeholder for Story 2.6 (Sign In screen)
      },
      child: Text.rich(
        TextSpan(
          text: 'Already have an account? ',
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: 'Sign In',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
