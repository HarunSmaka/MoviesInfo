import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../config/config.dart';
import '../../data/model/tv_show.dart';
import '../../data/repository/interface/tv_show_repo.dart';

class TvShowProductionRepo with ChangeNotifier implements TvShowRepo {
  List<TvShow> _tvShowsList = [];
  List<TvShow> _searchedTvShowList = [];

  List<TvShow> get tvShowsList {
    return _tvShowsList;
  }

  List<TvShow> get searchedTvShowList {
    return _searchedTvShowList;
  }

  @override
  Future<void> fetchTvShows() async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/tv/top_rated?api_key=${Config.API_KEY}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;

        final loadedTvShows = <TvShow>[];
        final extractedResults = extractedData['results'];
        for (var i = 0; i < 10; i++) {
          loadedTvShows.add(
            TvShow(
              id: extractedResults[i]['id'],
              name: extractedResults[i]['name'],
              poster_path: extractedResults[i]['poster_path'],
              backdrop_path: extractedResults[i]['backdrop_path'],
              overview: extractedResults[i]['overview'],
            ),
          );
        }
        _tvShowsList = loadedTvShows;
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }

  void emptySearchList() {
    _searchedTvShowList = [];
    notifyListeners();
  }

  @override
  Future<void> fetchSearchedTvShows(String query) async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/search/tv?api_key=${Config.API_KEY}&query=$query');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        final loadedTvShows = <TvShow>[];
        final List<dynamic> extractedResults = extractedData['results'];
        for (var i = 0; i < extractedResults.length; i++) {
          loadedTvShows.add(
            TvShow(
              id: extractedResults[i]['id'],
              name: extractedResults[i]['name'],
              poster_path: extractedResults[i]['poster_path'],
              backdrop_path: extractedResults[i]['backdrop_path'],
              overview: extractedResults[i]['overview'],
            ),
          );
        }
        _searchedTvShowList = loadedTvShows;
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }
}
