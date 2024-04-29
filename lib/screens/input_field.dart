import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  const InputField({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // Add a Text widget to display the title
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Container(
            height: 52,
            margin: EdgeInsets.only(top: 8.0),
            padding: EdgeInsets.only(left: 14.0),
            decoration: BoxDecoration(
              // Use color within BoxDecoration
              border: Border.all(width: 1.0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    controller: controller,
                    decoration: InputDecoration(
                        hintText: hint, focusedBorder: UnderlineInputBorder()),
                  ),
                ),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
