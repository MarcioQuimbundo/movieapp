import 'package:flutter/material.dart';
import 'package:movieapp/common/constants/languages.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/presentation/journeys/drawer/navigation_expanded_list_tile.dart';
import 'package:movieapp/presentation/journeys/drawer/navigation_list_item.dart';
import 'package:movieapp/presentation/widgets/logo.dart';

import '../../app_localizations.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.dimen_300.w,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            blurRadius: 4,
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(
                    top: Sizes.dimen_8.h,
                    bottom: Sizes.dimen_18.h,
                    left: Sizes.dimen_8.w,
                    right: Sizes.dimen_8.w),
                child: Logo(
                  height: Sizes.dimen_20.h,
                )),
            NavigationListItem(
                title: AppLocalizations.of(context).translate('favoriteMovies'),
                onPressed: () {}),
            NavigationExpandedListTile(
                title: "Language",
                children: Languages.languages.map((e) => e.value).toList(),
                onPressed: () {}),
            NavigationListItem(title: 'Feedback', onPressed: () {}),
            NavigationListItem(title: 'About', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
