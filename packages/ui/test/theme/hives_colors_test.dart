import 'package:flutter_test/flutter_test.dart';
import 'package:ui/src/theme/app_colors.dart';
import 'package:ui/src/theme/hives_colors.dart';

void main() {
  group('HivesColors', () {
    group('HivesColors.light', () {
      test('honey matches AppColors.primary', () {
        expect(HivesColors.light.honey, AppColors.primary);
      });

      test('honeyLight matches AppColors.primaryLight', () {
        expect(HivesColors.light.honeyLight, AppColors.primaryLight);
      });

      test('honeyDark matches AppColors.primaryDark', () {
        expect(HivesColors.light.honeyDark, AppColors.primaryDark);
      });

      test('secondary matches AppColors.secondary (purple)', () {
        expect(HivesColors.light.secondary, AppColors.secondary);
      });

      test('secondaryLight matches AppColors.secondaryLight', () {
        expect(HivesColors.light.secondaryLight, AppColors.secondaryLight);
      });

      test('nature matches AppColors.healthyStatus', () {
        expect(HivesColors.light.nature, AppColors.healthyStatus);
      });

      test('natureLightShade matches AppColors.healthyFill', () {
        expect(HivesColors.light.natureLightShade, AppColors.healthyFill);
      });

      // Status color field tests
      test('healthyStatus matches AppColors.healthyStatus', () {
        expect(HivesColors.light.healthyStatus, AppColors.healthyStatus);
      });

      test('healthyFill matches AppColors.healthyFill', () {
        expect(HivesColors.light.healthyFill, AppColors.healthyFill);
      });

      test('attentionStatus matches AppColors.attentionStatus', () {
        expect(HivesColors.light.attentionStatus, AppColors.attentionStatus);
      });

      test('attentionFill matches AppColors.attentionFill', () {
        expect(HivesColors.light.attentionFill, AppColors.attentionFill);
      });

      test('urgentStatus matches AppColors.urgentStatus', () {
        expect(HivesColors.light.urgentStatus, AppColors.urgentStatus);
      });

      test('urgentFill matches AppColors.urgentFill', () {
        expect(HivesColors.light.urgentFill, AppColors.urgentFill);
      });

      test('unknownStatus matches AppColors.unknownStatus', () {
        expect(HivesColors.light.unknownStatus, AppColors.unknownStatus);
      });

      test('unknownFill matches AppColors.unknownFill', () {
        expect(HivesColors.light.unknownFill, AppColors.unknownFill);
      });

      test('surface matches AppColors.surface', () {
        expect(HivesColors.light.surface, AppColors.surface);
      });

      test('outline matches AppColors.outline', () {
        expect(HivesColors.light.outline, AppColors.outline);
      });
    });

    group('copyWith', () {
      test('copyWith returns new instance with updated value', () {
        final updated = HivesColors.light.copyWith(
          honey: AppColors.urgentStatus,
        );
        expect(updated.honey, AppColors.urgentStatus);
        expect(updated.honeyLight, HivesColors.light.honeyLight);
      });
    });

    group('lerp', () {
      test('lerp with null returns self', () {
        final result = HivesColors.light.lerp(null, 0.5);
        expect(result, HivesColors.light);
      });

      test('lerp at t=0 matches source', () {
        final result = HivesColors.light.lerp(HivesColors.dark, 0.0);
        expect(result.honey, HivesColors.light.honey);
      });

      test('lerp at t=1 matches target', () {
        final result = HivesColors.light.lerp(HivesColors.dark, 1.0);
        expect(result.honey, HivesColors.dark.honey);
      });
    });
  });
}
