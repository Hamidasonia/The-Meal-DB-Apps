import 'package:dio/dio.dart' as dio;
import 'package:submission_dicoding_pemula/data/repo.dart';

late Repo _repo;

class Request {
  late _Meals meals;

  Request() {
    _repo = Repo();
    meals = _Meals();
  }
}

class _Meals {
  Future<dio.Response> category() async {
    return _repo.meals.category();
  }

  Future<dio.Response> listFood(String name) async {
    return _repo.meals.listFood(name);
  }
}
