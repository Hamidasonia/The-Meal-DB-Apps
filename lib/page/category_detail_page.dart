import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:submission_dicoding_pemula/data/request.dart';
import 'package:submission_dicoding_pemula/model/app/singleton_model.dart';
import 'package:submission_dicoding_pemula/model/category_model.dart';
import 'package:dio/dio.dart' as dio;
import 'package:submission_dicoding_pemula/model/filter_category_model.dart';

class CategoryDetailPage extends StatelessWidget {
  final Category data;

  const CategoryDetailPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    SingletonModel model = SingletonModel.withContext(context);
    Request request = Request();
    Future future = request.meals.listFood(data.strCategory!);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            color: Colors.blueGrey,
          ),
          Container(
            height: MediaQuery.of(context).size.height * .6,
            decoration: BoxDecoration(
              image:
                  DecorationImage(image: NetworkImage(data.strCategoryThumb!)),
            ),
          ),
          Positioned(
            top: 50,
            left: 25,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const Positioned(
            top: 50,
            right: 25,
            child: FavoriteButton(),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.only(
                top: 24,
                left: 24,
                right: 24,
                bottom: 20,
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .55,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.strCategory!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      data.strCategoryDescription!,
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "List of Food",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FutureBuilder(
                      future: future,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.active:
                          case ConnectionState.waiting:
                            return const SpinKitThreeBounce(
                              color: Colors.black,
                              size: 12,
                            );
                          case ConnectionState.done:
                            if (snapshot.hasData) {
                              dio.Response res = snapshot.data as dio.Response;
                              model.filterCategoryModel =
                                  FilterCategoryModel.fromJson(res.data);
                              return SizedBox(
                                height: 100,
                                child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      width: 200,
                                      height: 100,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 6,
                                            child: Container(
                                              width: 50,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: Colors.blueGrey,
                                                borderRadius: const BorderRadius
                                                        .horizontal(
                                                    left: Radius.circular(10)),
                                                image: DecorationImage(
                                                  image: NetworkImage(model
                                                      .filterCategoryModel!
                                                      .meals![index]
                                                      .strMealThumb!),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.horizontal(
                                                        right: Radius.circular(
                                                            10)),
                                              ),
                                              padding: const EdgeInsets.all(8),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    model.filterCategoryModel!
                                                        .meals![index].strMeal!,
                                                    textAlign: TextAlign.center,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 3,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontSize: 12),
                                                  ),
                                                  Text(
                                                    data.strCategory!,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount:
                                      model.filterCategoryModel!.meals!.length,
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(width: 20);
                                  },
                                ),
                              );
                            }
                        }
                        return Container();
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.white,
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
    );
  }
}
