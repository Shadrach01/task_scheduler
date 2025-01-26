import 'package:flutter/material.dart';
import 'package:task_scheduler/features/general_page_nav_bar.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    // );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const GeneralPageWithNavBar(),
    );
  }
}
