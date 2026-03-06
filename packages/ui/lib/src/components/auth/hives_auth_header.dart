import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Variants for the [HivesAuthHeader] widget.
///
/// Each variant provides a contextual tagline for the authentication screen.
enum HivesAuthHeaderVariant {
  /// Sign-in screen variant.
  signIn,

  /// Sign-up screen variant.
  signUp,

  /// Forgot-password screen variant.
  forgotPassword,
}

/// Authentication header displaying a bee icon, wordmark, and contextual tagline.
///
/// Used at the top of authentication screens to provide branding and context.
/// The [variant] determines which tagline is displayed.
class HivesAuthHeader extends StatelessWidget {
  const HivesAuthHeader({super.key, required this.variant});

  /// The variant controlling the tagline text.
  final HivesAuthHeaderVariant variant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.hive,
          size: 72,
          color: theme.colorScheme.primary,
          semanticLabel: 'Hives bee icon',
        ),
        const SizedBox(height: 12),
        Text(
          'hives',
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _tagline,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  String get _tagline => switch (variant) {
    HivesAuthHeaderVariant.signIn => 'Welcome back to your hives',
    HivesAuthHeaderVariant.signUp => 'Start managing your hives today',
    HivesAuthHeaderVariant.forgotPassword => 'Reset your password',
  };
}
