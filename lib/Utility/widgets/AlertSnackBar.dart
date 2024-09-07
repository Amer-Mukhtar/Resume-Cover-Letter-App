import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

SnackBar AlertSnackBar(String message,Color color,Color color1)
{
  return SnackBar(
    backgroundColor: Colors.transparent,
    elevation: 30,
    behavior: SnackBarBehavior.floating,
    content: Container(
      margin: EdgeInsets.only(bottom: 82),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(height: 28, width: 2, color: color1),
          const SizedBox(width: 5),
           Icon(FontAwesomeIcons.circleExclamation, color: color1),
          const SizedBox(width: 5),
          Text(message),
        ],
      ),
    ),
    duration: const Duration(seconds: 2),
  );
}
