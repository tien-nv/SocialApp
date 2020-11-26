import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget singleClipOvalButton({
  icon = FontAwesomeIcons.search,
  backgroundColor = Colors.white,
  iconColor = Colors.grey,
  splashColor = Colors.white,
  double sizeButton = 29.0,
  double iconSize = 15.0,
  callbackFunction,
}) {
  return ClipOval(
    child: Material(
      color: backgroundColor, // button color
      child: InkWell(
        splashColor: splashColor, // inkwell color
        child: SizedBox(
          width: sizeButton,
          height: sizeButton,
          child: Icon(
            icon,
            size: iconSize,
            color: iconColor,
          ),
        ),
        onTap: callbackFunction,
      ),
    ),
  );
}
