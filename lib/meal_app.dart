import 'package:flutter/material.dart';
import 'package:submission_dicoding_pemula/common/styles/theme.dart';
import 'package:submission_dicoding_pemula/page/splash_page.dart';

import 'common/constans/string.dart';

class TheMealApp extends StatelessWidget {
  const TheMealApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kSAppName,
      theme: tdMain(context),
      home: const SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
