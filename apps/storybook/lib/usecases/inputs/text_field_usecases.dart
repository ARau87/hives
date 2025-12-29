import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: HivesTextField)
Widget hivesTextFieldDefault(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 300,
      child: HivesTextField(
        label: 'Email Address',
        hint: 'Enter your email',
        keyboardType: TextInputType.emailAddress,
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'With Error', type: HivesTextField)
Widget hivesTextFieldWithError(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 300,
      child: HivesTextField(
        label: 'Username',
        hint: 'Enter username',
        errorText:
            context.knobs.boolean(label: 'Show Error', initialValue: true)
            ? 'Username is already taken'
            : null,
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Password Field', type: HivesTextField)
Widget hivesTextFieldPassword(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 300,
      child: HivesTextField(
        label: 'Password',
        hint: 'Enter your password',
        isPassword: context.knobs.boolean(
          label: 'Is Password',
          initialValue: true,
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'With Icons', type: HivesTextField)
Widget hivesTextFieldWithIcons(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 300,
      child: HivesTextField(
        label: 'Search',
        hint: 'Search...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: const Icon(Icons.close),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Disabled', type: HivesTextField)
Widget hivesTextFieldDisabled(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 300,
      child: HivesTextField(
        label: 'Disabled Field',
        hint: 'Cannot edit',
        isEnabled: false,
        initialValue: 'Disabled value',
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Multiline', type: HivesTextField)
Widget hivesTextFieldMultiline(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 300,
      child: HivesTextField(
        label: 'Description',
        hint: 'Enter description',
        maxLines: context.knobs.int.slider(
          label: 'Max Lines',
          initialValue: 4,
          min: 2,
          max: 8,
        ),
      ),
    ),
  );
}
