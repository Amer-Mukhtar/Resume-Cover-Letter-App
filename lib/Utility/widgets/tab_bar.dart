import 'package:flutter/material.dart';

class tabBar extends StatelessWidget {
  const tabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
        length: 2, child: Scaffold(
      body: Column(children: [
        TabBar(tabs: [
          Tab(
            text: 'Resume',
          ),
          Tab(text: 'Cover Letters',)
        ],
        )
      ],
      ),
    )
    );
  }
}
