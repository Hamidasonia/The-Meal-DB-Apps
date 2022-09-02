const String _baseUrl = "https://themealdb.com/api/json/v1/1/";

class API {
  _Meals meals = _Meals();

  static const String baseUrl = _baseUrl;
}

class _Meals {
  final String category = "${_baseUrl}categories.php";
  String listFood(String name) => "${_baseUrl}filter.php?c=$name";
}
