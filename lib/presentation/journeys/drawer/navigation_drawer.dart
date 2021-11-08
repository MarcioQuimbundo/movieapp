import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/languages.dart';
import 'package:movieapp/common/constants/route_constants.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/presentation/blocs/language/language_bloc.dart';
import 'package:movieapp/presentation/blocs/login/login_bloc.dart';
import 'package:movieapp/presentation/journeys/drawer/navigation_expanded_list_tile.dart';
import 'package:movieapp/presentation/journeys/drawer/navigation_list_item.dart';
import 'package:movieapp/presentation/widgets/app_dialog.dart';
import 'package:movieapp/presentation/widgets/logo.dart';
import 'package:movieapp/common/extensions/string_extensions.dart';
import 'package:wiredash/wiredash.dart';

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
                title: TranslationConstants.favoriteMovies.translate(context),
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteList.favorite);
                }),
            NavigationExpandedListTile(
                title: TranslationConstants.language.translate(context),
                children: Languages.languages.map((e) => e.value).toList(),
                onPressed: (index) {
                  BlocProvider.of<LanguageBloc>(context)
                      .add(ToogleLanguageEvents(Languages.languages[index]));
                }),
            NavigationListItem(
                title: TranslationConstants.feedback.translate(context),
                onPressed: () {
                  Navigator.of(context).pop();
                  Wiredash.of(context).show();
                }),
            NavigationListItem(
                title: TranslationConstants.about.translate(context),
                onPressed: () {
                  Navigator.of(context).pop();
                  _showDialog(context);
                }),
            BlocListener<LoginBloc, LoginState>(
              listenWhen: (previous, current) => current is LogoutSuccess,
              listener: (context, state) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteList.initial, (route) => false);
              },
              child: NavigationListItem(
                  title: TranslationConstants.logout.translate(context),
                  onPressed: () {
                    BlocProvider.of<LoginBloc>(context).add(LogoutEvent());
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      child: AppDialog(
        title: TranslationConstants.about,
        description: TranslationConstants.aboutDescription,
        buttonText: TranslationConstants.okay,
        image: Image.asset(
          "assets/images/tmdb_logo.png",
          height: Sizes.dimen_32.h,
        ),
      ),
    );
  }
}
