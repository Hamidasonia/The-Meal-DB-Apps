import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:ui' as ui;
import 'package:url_launcher/url_launcher.dart';

class Helper {
  Future<String> createFolder({String? dir}) async {
    final folderName = dir == null ? "" : "/$dir";
    final path = Directory("storage/emulated/0/AWANN APPS $folderName");
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    if ((await path.exists())) {
      return path.path;
    } else {
      path.create();
      return path.path;
    }
  }

  Future takeScreenshot({required GlobalKey renderKey}) async {
    try {
      RenderRepaintBoundary? boundary =
      renderKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      return pngBytes;
    } catch (e) {
      return (e.toString());
    }
  }

  Future saveImage(
      {required Uint8List image, String? dir, String? firstName}) async {
    try {
      final path = await createFolder(dir: dir);
      final fullPath =
          '$path/$firstName-${DateTime
          .now()
          .millisecondsSinceEpoch}.png';
      File file = File(fullPath);
      await file.writeAsBytes(image);
      return file.path;
    } catch (e) {
      return e.toString();
    }
  }

  bool isValidMail(String mail) {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(mail);
  }

  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  Future exitApp() {
    return Platform.isIOS ? exit(0) : SystemNavigator.pop(animated: true);
  }

  Future jumpToPage(BuildContext context, {required Widget page}) {
    return Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  Future moveToPageNoAnim(BuildContext context, {required Widget page}) {
    return Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionDuration: const Duration(seconds: 0),
      ),
    );
  }

  Future moveToPage(BuildContext context, {required Widget page}) {
    return Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => page));
  }

  Future jumpToPageNamed(BuildContext context, {
    required String route,
    dynamic arguments,
  }) {
    return Navigator.of(context).pushNamed(route, arguments: arguments);
  }

  Future moveToPageNamed(BuildContext context, {
    required String route,
    dynamic arguments,
  }) {
    return Navigator.of(context).pushReplacementNamed(
      route,
      arguments: arguments,
    );
  }

  void backToRootPage(BuildContext context) {
    Navigator?.of(context).popUntil((route) => route.isFirst);
  }

  void showToast(String msg, {
    Toast? length,
    ToastGravity? gravity,
    Color? bgColor,
    Color? textColor,
    double? size,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: length ?? Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.CENTER,
      backgroundColor: bgColor ?? Colors.black,
      textColor: textColor ?? Colors.white,
      fontSize: size ?? 16.0,
    );
  }

  String dioErrorHandler(e) {
    if (e == null) return "Unknown Error";
    if (e.runtimeType != DioError) {
      if (e is String) {
        return "Error : $e";
      } else {
        return "Unknown Error";
      }
    }
    if (e.response == null) return "Error : ${e.message}";
    String response = "";
    if (e.response.data != null) {
      Map<String, dynamic>? data = e.response.data;
      if (data != null) {
        if (data.containsKey("errors")) {
          data["errors"]?.forEach(
                (key, value) {
              if (value is Map<String, dynamic>) {
                value.forEach((key, val) => response += "\n$val");
              } else if (value is List) {
                for (var v in value) {
                  response += "\n$v";
                }
              } else {
                response += "\n$value";
              }
            },
          );
        }
      }
    }
    return response;
  }

  Future launcherIntent(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  double getSize({
    BuildContext? context,
    double? scale,
  }) {
    return MediaQuery
        .of(context!)
        .size
        .height * scale! / 100;
  }
}