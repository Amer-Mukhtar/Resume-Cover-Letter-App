import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/Home_Screen/home_screen.dart';
import 'Screens/add_resume_screen/resume_view_model.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ResumeViewModelProvider(),
      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainApp(),)

  )
  );
}


class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: home(),
    );
  }
}


