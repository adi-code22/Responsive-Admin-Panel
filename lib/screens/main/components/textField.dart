import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.multiline,
    required this.context,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final bool multiline;
  final BuildContext context;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Container(
          height: widget.multiline ? 150 : 60,
          width: MediaQuery.of(context).size.width *
              (Responsive.isDesktop(context) ? 0.35 : 0.4),
          child: TextField(
            maxLines: widget.multiline ? 4 : 1,
            keyboardType: TextInputType.multiline,
            controller: widget.controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 10, bottom: 50),
              hintText: widget.hintText,
              fillColor: secondaryColor,
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
