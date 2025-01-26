import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:task_scheduler/core/commons/widgets/app_text_field.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';

class UserNameTextField extends StatefulWidget {
  final String containerTitle;
  final String? initialUsername;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  const UserNameTextField({
    super.key,
    this.containerTitle = '',
    this.initialUsername,
    this.controller,
    this.onChanged,
  });

  @override
  State<UserNameTextField> createState() => _UserNameTextFieldState();
}

class _UserNameTextFieldState extends State<UserNameTextField> {
  bool readOnly = true;

  @override
  void initState() {
    super.initState();
    // Set the initial username if provided; otherwise, show "No username".
    widget.controller?.text = widget.initialUsername?.isNotEmpty == true
        ? widget.initialUsername!
        : "No username";
  }

  @override
  Widget build(BuildContext context) {
    final appHeight = context.appHeight;
    final appWidth = context.appWidth;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: appWidth * .05,
        vertical: appHeight * .025,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: appWidth * .025,
        children: [
          // TextField
          Expanded(
            child: AppTextField(
              controller: widget.controller,
              onChanged: widget.onChanged,
              readOnly: readOnly,
            ),
          ),

          // Edit Icon
          IconButton(
            onPressed: () {
              setState(() {
                // Toggle edit mode
                readOnly = !readOnly;

                // Clear "No username" when editing
                if (!readOnly && widget.controller?.text == "No username") {
                  widget.controller?.clear();
                }
              });
            },
            icon: Icon(
              readOnly ? IconlyBold.edit : IconlyBold.tick_square,
              color: readOnly ? Colors.grey : Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
