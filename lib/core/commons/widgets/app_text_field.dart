import 'package:flutter/material.dart';
import 'package:task_scheduler/core/utils/app_text_style.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;

  final void Function(String)? onChanged;

  final String? Function(String?)? validator;

  final bool readOnly;

  const AppTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.validator,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      style: AppTextStyle.textStyle(
        color: Colors.black87,
        size: 20,
        weight: FontWeight.w600,
      ),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: InputBorder.none,
        isDense: true,
        suffixIconColor: Colors.grey,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 2,
        ),
      ),
      textInputAction: TextInputAction.newline,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      minLines: 1,
      readOnly: readOnly,
    );
  }
}
