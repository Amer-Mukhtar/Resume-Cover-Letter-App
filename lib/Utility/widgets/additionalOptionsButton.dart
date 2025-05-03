import 'package:flutter/material.dart';

class AdditonalOptions extends StatelessWidget {
  final void Function() onPressed;

  const AdditonalOptions({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.white38),
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        icon: const Icon(
          Icons.more_vert,
          color: Colors.white,
          size: 18,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
