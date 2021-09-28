import 'package:flutter/material.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/presentation/themes/app_color.dart';
import 'package:movieapp/common/extensions/string_extensions.dart';
import 'package:movieapp/presentation/widgets/button.dart';

class AppDialog extends StatelessWidget {
  final String title, description, buttonText;
  final Widget image;
  const AppDialog(
      {Key key,
      @required this.title,
      @required this.description,
      @required this.buttonText,
      this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.vulcan,
      elevation: Sizes.dimen_32,
      insetPadding: EdgeInsets.all(Sizes.dimen_32.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.dimen_8.w),
      ),
      child: Container(
        padding: EdgeInsets.only(
            top: Sizes.dimen_4.h,
            left: Sizes.dimen_16.w,
            right: Sizes.dimen_16.w),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(blurRadius: Sizes.dimen_16, color: AppColor.vulcan),
        ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title.translate(context),
              style: Theme.of(context).textTheme.headline5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: Sizes.dimen_6.h),
              child: Text(description.translate(context),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2),
            ),
            if (image != null) image,
            Button(
                text: TranslationConstants.okay,
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        ),
      ),
    );
  }
}
