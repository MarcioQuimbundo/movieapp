import 'package:flutter/material.dart';
import 'package:movieapp/presentation/journeys/drawer/navigation_list_item.dart';

class NavigationExpandedListTile extends StatelessWidget {
  final String title;
  final Function onPressed;
  final List<String> children;
  const NavigationExpandedListTile(
      {Key key,
      @required this.title,
      @required this.children,
      @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.7),
              blurRadius: 2)
        ]),
        child: ExpansionTile(
          title: Text(title, style: Theme.of(context).textTheme.subtitle1),
          children: [
            for (int i = 0; i < children.length; i++)
              NavigationSubListItem(title: children[i], onPressed: () {})
          ],
        ),
      ),
    );
  }
}
