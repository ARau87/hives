import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui/src/theme/app_colors.dart';

void main() {
  group('AppColors', () {
    group('Brand palette', () {
      test('primary is #F59E0A', () {
        expect(AppColors.primary, const Color(0xFFF59E0A));
      });

      test('primaryDark is #D97706', () {
        expect(AppColors.primaryDark, const Color(0xFFD97706));
      });

      test('primaryLight is #FEF3C7', () {
        expect(AppColors.primaryLight, const Color(0xFFFEF3C7));
      });

      test('secondary is #8B5CF6', () {
        expect(AppColors.secondary, const Color(0xFF8B5CF6));
      });

      test('secondaryLight is #EDE9FE', () {
        expect(AppColors.secondaryLight, const Color(0xFFEDE9FE));
      });

      test('background is #FAFAF8', () {
        expect(AppColors.background, const Color(0xFFFAFAF8));
      });

      test('surface is #FFFFFF', () {
        expect(AppColors.surface, const Color(0xFFFFFFFF));
      });

      test('onSurface is #1C1917', () {
        expect(AppColors.onSurface, const Color(0xFF1C1917));
      });

      test('onSurfaceVariant is #A8A29E', () {
        expect(AppColors.onSurfaceVariant, const Color(0xFFA8A29E));
      });

      test('outline is #E7E5E4', () {
        expect(AppColors.outline, const Color(0xFFE7E5E4));
      });
    });

    group('Status colors', () {
      test('healthyStatus is #22C55E', () {
        expect(AppColors.healthyStatus, const Color(0xFF22C55E));
      });

      test('healthyFill is #DCFCE7', () {
        expect(AppColors.healthyFill, const Color(0xFFDCFCE7));
      });

      test('attentionStatus is #F59E0B', () {
        expect(AppColors.attentionStatus, const Color(0xFFF59E0B));
      });

      test('attentionFill is #FEF3C7', () {
        expect(AppColors.attentionFill, const Color(0xFFFEF3C7));
      });

      test('urgentStatus is #EF4444', () {
        expect(AppColors.urgentStatus, const Color(0xFFEF4444));
      });

      test('urgentFill is #FEE2E2', () {
        expect(AppColors.urgentFill, const Color(0xFFFEE2E2));
      });

      test('unknownStatus is #94A3B8', () {
        expect(AppColors.unknownStatus, const Color(0xFF94A3B8));
      });

      test('unknownFill is #F1F5F9', () {
        expect(AppColors.unknownFill, const Color(0xFFF1F5F9));
      });
    });

    group('Accent palette', () {
      test('teal is #14B8A6', () {
        expect(AppColors.teal, const Color(0xFF14B8A6));
      });

      test('tealLight is #CCFBF1', () {
        expect(AppColors.tealLight, const Color(0xFFCCFBF1));
      });

      test('blue is #3B82F6', () {
        expect(AppColors.blue, const Color(0xFF3B82F6));
      });

      test('blueLight is #DBEAFE', () {
        expect(AppColors.blueLight, const Color(0xFFDBEAFE));
      });

      test('orange is #F97316', () {
        expect(AppColors.orange, const Color(0xFFF97316));
      });

      test('orangeLight is #FED7AA', () {
        expect(AppColors.orangeLight, const Color(0xFFFED7AA));
      });
    });
  });
}
