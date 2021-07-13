import 'package:flutter/foundation.dart';

class Movie with ChangeNotifier {
  int id;
  String? poster_path;
  String? backdrop_path;
  String title;
  String overview;

  Movie({
    required this.id,
    this.poster_path,
    this.backdrop_path,
    required this.title,
    required this.overview,
  });
}

class ResponseData {
  int page;
  List<dynamic> results;
  int total_pages;
  int total_results;
  ResponseData({
    required this.page,
    required this.results,
    required this.total_pages,
    required this.total_results,
  });
}
