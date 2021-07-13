import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../data/repository/movie_production_repo.dart';
import '../data/repository/tv_show_production_repo.dart';
import '../presenter/movieDb_presenter.dart';
import '../view/widgets/movies_tab.dart';
import '../view/widgets/tv_show_tab.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    implements MovieListViewContract {
  late MovieListPresenter _presenter;
  bool _isLoading = false;
  final _searchController = TextEditingController();
  String searchText = '';

  _HomeScreenState() {
    _presenter = MovieListPresenter(this);
  }

  @override
  void initState() {
    _isLoading = true;

    Provider.of<MovieProductionRepo>(context, listen: false)
        .fetchMovies()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });

    Provider.of<TvShowProductionRepo>(context, listen: false).fetchTvShows();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProductionRepo>(context);
    final tvShowProvider = Provider.of<TvShowProductionRepo>(context);
    const duration = Duration(milliseconds: 1000);
    var searchOnStoppedTyping = Timer(duration, () {});

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 120,
          leading: const SizedBox(
            width: 20,
          ),
          title: TextField(
            maxLength: 15,
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search...',
              fillColor: Colors.white,
            ),
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
            onChanged: (_) {
              searchText = _searchController.text;
              // Search does not trigger unless user inputs at least 3 characters
              if (searchText.trim().length < 3) {
                movieProvider.emptySearchList();
                tvShowProvider.emptySearchList();
                return;
              }

              // clear timer if user continues typing
              if (searchOnStoppedTyping != null) {
                setState(() => searchOnStoppedTyping.cancel());
              }
              // callback function triggers if user stops typing for a second
              setState(() => searchOnStoppedTyping = Timer(duration, () {
                    movieProvider.fetchSearchedMovies(searchText);
                    tvShowProvider.fetchSearchedTvShows(searchText);
                  }));
            },
          ),
          actions: [
            Container(
                margin: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.search)),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Movies',
              ),
              Tab(text: 'TV Shows'),
            ],
          ),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : TabBarView(
                children: [
                  MoviesTab(),
                  TvShowsTab(),
                ],
              ),
      ),
    );
  }

  @override
  void onLoadMovieComplete() {
    setState(() {
      _isLoading = false;
    });
  }
}
