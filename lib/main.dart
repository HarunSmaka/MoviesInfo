import 'package:flutter/material.dart';
import 'package:movies_app/data/repository/movie_production_repo.dart';
import 'package:movies_app/data/repository/tv_show_production_repo.dart';
import 'package:movies_app/view/detail_screen.dart';
import 'package:movies_app/view/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import 'enum/source.dart';
import 'di/movie_dependency_injection.dart';
import 'di/tv_show_dependency_injection.dart';

void main() {
  MovieInjector.configure(Source.PRODUCTION);
  TvShowInjector.configure(Source.PRODUCTION);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MovieProductionRepo(),
        ),
        ChangeNotifierProvider(
          create: (context) => TvShowProductionRepo(),
        ),
      ],
      child: GetMaterialApp(
        title: 'The Movie DB',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(
            name: HomeScreen.routeName,
            page: () => HomeScreen(),
          ),
          GetPage(
            name: DetailScreen.routeName,
            page: () => DetailScreen(),
          ),
        ],
        initialRoute: HomeScreen.routeName,
      ),
    );
  }
}
