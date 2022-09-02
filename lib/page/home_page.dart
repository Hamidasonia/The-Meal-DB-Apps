import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:submission_dicoding_pemula/common/constans/general.dart';
import 'package:submission_dicoding_pemula/common/styles/color.dart';
import 'package:submission_dicoding_pemula/data/request.dart';
import 'package:submission_dicoding_pemula/model/app/singleton_model.dart';
import 'package:submission_dicoding_pemula/model/category_model.dart';
import 'package:submission_dicoding_pemula/page/category_detail_page.dart';
import 'package:submission_dicoding_pemula/tool/helper.dart';
import 'package:dio/dio.dart' as dio;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    SingletonModel model = SingletonModel.withContext(context);
    Helper helper = Helper();
    Request request = Request();
    Future future = request.meals.category();
    TextEditingController textController = TextEditingController();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hi,Ilyas",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "What do you want to cook today?",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: textController,
                autofocus: false,
                onTap: () {},
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.grey[300]!,
                      width: 3,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.grey[300]!,
                      width: 3,
                    ),
                  ),
                  prefixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Recommended by category",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 300,
                child: FutureBuilder(
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
                          model.categoryModel =
                              CategoryModel.fromJson(res.data);
                          return ListView.separated(
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  InkWell(
                                    onTap: () => helper.jumpToPage(
                                      context,
                                      page: CategoryDetailPage(
                                          data: model.categoryModel!
                                              .categories![index]),
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 40),
                                      height: 250,
                                      width: 190,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        color: hText,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            model
                                                    .categoryModel
                                                    ?.categories?[index]
                                                    .strCategory ??
                                                "",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 30)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: Constants.padding,
                                    right: Constants.padding,
                                    top: Constants.padding - 5,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        model.categoryModel!.categories![index]
                                            .strCategoryThumb!,
                                      ),
                                      maxRadius: 60,
                                    ),
                                  ),
                                ],
                              );
                            },
                            itemCount: model.categoryModel!.categories!.length,
                            scrollDirection: Axis.horizontal,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(width: 20);
                            },
                          );
                        }
                    }
                    return Container();
                  },
                ),
              ),
              const Text(
                "Recommended by popular food",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 180,
                margin: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://www.themealdb.com/images/media/meals/1ngcbf1628770793.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
