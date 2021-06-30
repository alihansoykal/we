import 'package:WE/Resources/constants.dart';
import 'package:WE/Screens/BottomNavigation/bottom_navigation.dart';
import 'package:flutter/material.dart';

Widget buildPopupDialog(BuildContext context, title, bool) {
  return AlertDialog(
    insetPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 1),
    title: Text('Info'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title),
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          if (bool == true) {
            Navigator.of(context).pop();
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return BottomNavigation();
                },
              ),
            );
          }
        },
        child: Text(
          'Close',
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
    ],
  );
}

void popUp(context, string, bool) {
  showDialog(
    context: context,
    builder: (BuildContext context) => buildPopupDialog(context, string, bool),
  );
}

class PopUpButton extends StatelessWidget {
  final String image;
  final String text;
  final double scale;
  final Widget widget;

  const PopUpButton({
    this.widget,
    this.image,
    @required this.text,
    this.scale,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          popUp(context, text, bool);
        },
        child: widget);
  }
}
