import 'package:flutter/material.dart';
import 'package:movieapp/presentation/themes/app_color.dart';
import 'package:wiredash/wiredash.dart';

class WiredashApp extends StatelessWidget {
  final navigatorKey;
  final Widget child;

  const WiredashApp(
      {Key key, @required this.navigatorKey, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      projectId: "movie-app-h1h081e",
      secret: "t27CJojJ6KZ3h6TwTyHmPINdnXWekOg6",
      navigatorKey: navigatorKey,
      child: child,
      theme: WiredashThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColor.royalBlue,
        secondaryColor: AppColor.violet,
        secondaryBackgroundColor: AppColor.vulcan,
        dividerColor: AppColor.vulcan,
      ),
      options: WiredashOptionsData(
        showDebugFloatingEntryPoint: false,
        locale: Locale("pt"),
      ),
    );
  }
}
