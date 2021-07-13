import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../enum/content_type.dart';
import '../../data/repository/movie_production_repo.dart';
import './content_card.dart';

class MoviesTab extends StatelessWidget {
  const MoviesTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesData = Provider.of<MovieProductionRepo>(context);
    final movies = moviesData.moviesList;
    dynamic searchedMovies = moviesData.searchedMoviesList;

    var _items = searchedMovies.isEmpty || searchedMovies == null
        ? movies
        : searchedMovies;

    return Container(
      child: _items.isEmpty
          ? Center(
              child: Text('No Content'),
            )
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (ctx, index) {
                return MovieCard(
                  item: _items[index],
                  contentType: ContentType.Movie,
                );
              }),
    );
  }
}
