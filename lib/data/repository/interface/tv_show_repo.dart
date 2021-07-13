abstract class TvShowRepo {
  Future<void> fetchTvShows();
  Future<void> fetchSearchedTvShows(String query);
}
