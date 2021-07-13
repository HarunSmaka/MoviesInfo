import '../enum/source.dart';
import '../data/repository/tv_show_production_repo.dart';
import '../data/repository/interface/tv_show_repo.dart';

//DI
class TvShowInjector {
  static final TvShowInjector _singleton =  TvShowInjector._internal();
  static Source _source = Source.PRODUCTION;

  static void configure(Source source) {
    _source = source;
  }

  factory TvShowInjector() {
    return _singleton;
  }

  TvShowInjector._internal();

  TvShowRepo get tvShowRepo {
        return TvShowProductionRepo();
  }
}
