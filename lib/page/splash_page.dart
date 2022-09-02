import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:submission_dicoding_pemula/common/constans/images.dart';
import 'package:submission_dicoding_pemula/common/styles/color.dart';
import 'package:submission_dicoding_pemula/page/home_page.dart';
import 'package:submission_dicoding_pemula/tool/helper.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    Helper helper = Helper();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      var duration = const Duration(seconds: 3);
      Timer(duration, (){
        helper.moveToPage(context, page: const HomePage());
      });
    });
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              kImgLogo,
              width: 150,
            ),
            const SizedBox(height: 10),
            Text(
              "The Meals App",
              style: TextStyle(
                color: hText,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
