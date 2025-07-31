import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:resume_maker/Models/model_cover.dart';
import 'package:resume_maker/Utility/Adapters/CLAdapters.dart';
import 'Models/model_resume.dart';
import 'Views/Gpt/gpt.dart';
import 'Views/Home_Screen/home_screen.dart';
import 'Views/add_resume_screen/resume_2.dart';
import 'ViewModels/resume_view_model.dart';
import 'ViewModels/cover_viewmode.dart';
import 'Utility/Adapters/ResumeAdapters.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(ResumeModelAdapter());
  Hive.registerAdapter(IntroAdapter());
  Hive.registerAdapter(ContactAdapter());
  Hive.registerAdapter(EducationAdapter());
  Hive.registerAdapter(ExperienceAdapter());
  Hive.registerAdapter(SkillAdapter());
  Hive.registerAdapter(LanguageAdapter());
  Hive.registerAdapter(CertificationAdapter());
  Hive.registerAdapter(ReferenceAdapter());
  Hive.registerAdapter(AchievementsAdapter());
  var resumeBox = await Hive.openBox<ResumeModel>('resumes');

  Hive.registerAdapter(CLModelAdapter());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ResumeViewModelProvider(resumeBox: resumeBox),
        ),
        ChangeNotifierProvider(
          create: (context) => CoverViewModelProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ResumeState(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainApp(),
      ),
    ),
  );
}
//is thwe commit working now
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Home(),
    );
  }
}
