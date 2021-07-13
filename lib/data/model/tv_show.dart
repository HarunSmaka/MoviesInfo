import 'package:flutter/foundation.dart';

class TvShow with ChangeNotifier {
  int id;
  String name;
  String? poster_path;
  String? backdrop_path;
  String overview;

  TvShow({
    required this.id,
    required this.name,
    this.poster_path,
    this.backdrop_path,
    required this.overview,
  });
}
