import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './interface/movie_repo.dart';
import '../../config/config.dart';
import '../../data/model/movie.dart';


class MovieProductionRepo with ChangeNotifier implements MovieRepo {
  List<Movie> _moviesList = [];
  List<Movie> _searchedMoviesList = [];

  List<Movie> get moviesList {
    return _moviesList;
  }

  List<Movie> get searchedMoviesList {
    return _searchedMoviesList;
  }

  @override
  Future<void> fetchMovies() async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/movie/top_rated?api_key=${Config.API_KEY}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        var loadedMovies = <Movie>[];
        final extractedResults = extractedData['results'];

        for (var i = 0; i < 10; i++) {
          loadedMovies.add(
            Movie(
              id: extractedResults[i]['id'],
              title: extractedResults[i]['title'],
              poster_path: extractedResults[i]['poster_path'],
              backdrop_path: extractedResults[i]['backdrop_path'],
              overview: extractedResults[i]['overview'],
            ),
          );
        }
        _moviesList = loadedMovies;
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }

  void emptySearchList() {
    _searchedMoviesList = [];
    notifyListeners();
  }

  @override
  Future<void> fetchSearchedMovies(String query) async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=${Config.API_KEY}&query=$query');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        final loadedMovies = <Movie>[];
        final List<dynamic> extractedResults = extractedData['results'];
        for (var i = 0; i < extractedResults.length; i++) {
          loadedMovies.add(
            Movie(
              id: extractedResults[i]['id'],
              title: extractedResults[i]['title'],
              poster_path: extractedResults[i]['poster_path'],
              backdrop_path: extractedResults[i]['backdrop_path'],
              overview: extractedResults[i]['overview'],
            ),
          );
        }

        _searchedMoviesList = loadedMovies;
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }
}
