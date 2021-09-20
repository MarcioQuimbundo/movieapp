import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/screenutil/screen_util.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/presentation/widgets/logo.dart';

class MovieAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil.statusBarHeight + Sizes.dimen_4.h,
          left: Sizes.dimen_16.w,
          right: Sizes.dimen_16.w),
      child: Row(
        children: [
          IconButton(
              icon: SvgPicture.asset(
                "assets/images/menu.svg",
                height: Sizes.dimen_12.h,
              ),
              onPressed: () {}),
          Expanded(
            child: const Logo(
              height: Sizes.dimen_14,
            ),
          ),
          IconButton(
              icon: Icon(Icons.search,
                  color: Colors.white, size: Sizes.dimen_12.h),
              onPressed: () {}),
        ],
      ),
    );
  }
}
