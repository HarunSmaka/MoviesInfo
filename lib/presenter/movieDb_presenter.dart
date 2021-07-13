import '../di/movie_dependency_injection.dart';
import '../data/repository/interface/movie_repo.dart';

abstract class MovieListViewContract {
  void onLoadMovieComplete();
}

class MovieListPresenter {
  final MovieListViewContract _view;
  late MovieRepo _repository;

  MovieListPresenter(this._view) {
    _repository = MovieInjector().movieRepo;
  }
}
