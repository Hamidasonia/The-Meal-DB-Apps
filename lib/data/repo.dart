import 'package:dio/dio.dart' as dio;
import 'package:submission_dicoding_pemula/data/api.dart';
import 'package:submission_dicoding_pemula/data/dio.dart';

late API _api;
late Dio _dio;

class Repo {
  late _Meals meals;

  Repo() {
    meals = _Meals();
    _api = API();
    _dio = Dio();
  }
}

class _Meals {
  Future<dio.Response> category() async {
    return await _dio.get(url: _api.meals.category);
  }

  Future<dio.Response> listFood(String name) async {
    return await _dio.get(url: _api.meals.listFood(name));
  }
}
