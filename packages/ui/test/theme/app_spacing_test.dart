import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui/src/theme/app_spacing.dart';

void main() {
  group('AppSpacing', () {
    group('Base spacing scale (4px grid)', () {
      test('xs is 4', () => expect(AppSpacing.xs, 4.0));
      test('sm is 8', () => expect(AppSpacing.sm, 8.0));
      test('md is 12', () => expect(AppSpacing.md, 12.0));
      test('lg is 16', () => expect(AppSpacing.lg, 16.0));
      test('xl is 20', () => expect(AppSpacing.xl, 20.0));
      test('xxl is 24', () => expect(AppSpacing.xxl, 24.0));
      test('xxxl is 32', () => expect(AppSpacing.xxxl, 32.0));
    });

    group('Semantic spacing aliases', () {
      test('cardPadding is 20', () => expect(AppSpacing.cardPadding, 20.0));
      test('sectionGap is 28', () => expect(AppSpacing.sectionGap, 28.0));
      test('screenMargin is 20', () => expect(AppSpacing.screenMargin, 20.0));
      test('touchTargetMin is 48', () {
        expect(AppSpacing.touchTargetMin, 48.0);
      });
      test('buttonHeight is 54', () => expect(AppSpacing.buttonHeight, 54.0));
      test('fabDiameter is 64', () => expect(AppSpacing.fabDiameter, 64.0));
    });

    group('BorderRadius constants', () {
      test('buttonRadius is 16px circular', () {
        expect(AppSpacing.buttonRadius, BorderRadius.circular(16));
      });

      test('cardRadius is 24px circular', () {
        expect(AppSpacing.cardRadius, BorderRadius.circular(24));
      });

      test('chipRadius is 12px circular', () {
        expect(AppSpacing.chipRadius, BorderRadius.circular(12));
      });

      test('inputRadius is 14px circular', () {
        expect(AppSpacing.inputRadius, BorderRadius.circular(14));
      });

      test('modalTopRadius is 28px top vertical', () {
        expect(
          AppSpacing.modalTopRadius,
          const BorderRadius.vertical(top: Radius.circular(28)),
        );
      });
    });
  });
}
