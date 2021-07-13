import '../enum/source.dart';
import '../data/repository/movie_production_repo.dart';
import '../data/repository/interface/movie_repo.dart';

//DI
class MovieInjector {
  static final MovieInjector _singleton = MovieInjector._internal();
  static Source _source = Source.PRODUCTION;

  static void configure(Source source) {
    _source = source;
  }

  factory MovieInjector() {
    return _singleton;
  }

  MovieInjector._internal();

  MovieRepo get movieRepo {
    return MovieProductionRepo();
  }
}
