import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'AlertSnackBar.dart';

Container reorderButton(BuildContext context) {
  return Container(
    width: 45,
    height: 45,
    decoration: BoxDecoration(
      color: Colors.black,
      border: Border.all(color: Colors.white60),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
      child: IconButton(
        icon:  const Icon(
          CupertinoIcons.arrow_up_arrow_down,
          color: Colors.blue,
          size: 20,
        ),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            AlertSnackBar('Press and hold to position it',const Color(0xFF454545),Colors.blue),
          );
        },
      ),
    ),
  );
}

