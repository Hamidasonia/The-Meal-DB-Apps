import 'package:flutter/material.dart';
import 'package:submission_dicoding_pemula/model/category_model.dart';
import 'package:submission_dicoding_pemula/model/filter_category_model.dart';

class SingletonModel {
  static SingletonModel? _singleton;

  factory SingletonModel() => _singleton ?? SingletonModel._internal();

  SingletonModel._internal();

  static SingletonModel withContext(BuildContext context) {
    _singleton ??= SingletonModel._internal();
    _singleton!.context = context;

    return _singleton!;
  }

  static SingletonModel get shared => _singleton ?? SingletonModel._internal();

  CategoryModel? categoryModel;
  BuildContext? context;
  FilterCategoryModel? filterCategoryModel;
}