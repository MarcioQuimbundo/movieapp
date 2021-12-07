import 'package:flutter/material.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/extensions/string_extensions.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/presentation/themes/app_color.dart';

class Button extends StatelessWidget {
  final String text;
  final bool isEnabled;
  final Function onPressed;
  const Button(
      {Key key, @required this.text, @required this.onPressed, this.isEnabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
      margin: EdgeInsets.symmetric(vertical: Sizes.dimen_12.h),
      height: Sizes.dimen_16.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          isEnabled ? AppColor.royalBlue : Colors.grey,
          isEnabled ? AppColor.violet : Colors.grey
        ]),
        borderRadius: BorderRadius.circular(Sizes.dimen_20.w),
      ),
      child: TextButton(
        key: const ValueKey('main_button'),
        onPressed: isEnabled ? onPressed : null,
        child: Text(
          text.translate(context),
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}