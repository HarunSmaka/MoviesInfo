import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../enum/content_type.dart';
import '../../data/repository/tv_show_production_repo.dart';
import './content_card.dart';

class TvShowsTab extends StatelessWidget {
  const TvShowsTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tvShowsData = Provider.of<TvShowProductionRepo>(context);
    final tvShows = tvShowsData.tvShowsList;
    final searchedTvShows = tvShowsData.searchedTvShowList;

    var _items = searchedTvShows.isEmpty || searchedTvShows == null
        ? tvShows
        : searchedTvShows;

    return _items.isEmpty
        ? Center(
            child: Text('No Content'),
          )
        : Container(
            child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (ctx, index) {
                  return MovieCard(
                    item: _items[index],
                    contentType: ContentType.TvShow,
                  );
                }),
          );
  }
}
