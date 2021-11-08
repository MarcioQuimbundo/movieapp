import 'package:flutter/material.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/presentation/themes/theme_text.dart';

class LabelFieldWidget extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final UnderlineInputBorder _enableBorder =
      const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey));
  final UnderlineInputBorder _focusedBorder =
      const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white));
  const LabelFieldWidget(
      {Key key,
      @required this.label,
      @required this.hintText,
      this.isPassword = false,
      @required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Sizes.dimen_8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.headline6,
          ),
          TextField(
            obscureText: isPassword,
            obscuringCharacter: '*',
            style: Theme.of(context).textTheme.headline6,
            controller: controller,
            decoration: InputDecoration(
                hintText: hintText,
                hintStyle: Theme.of(context).textTheme.greySubtitle1,
                focusedBorder: _focusedBorder,
                enabledBorder: _enableBorder),
          )
        ],
      ),
    );
  }
}
