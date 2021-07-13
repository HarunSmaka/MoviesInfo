abstract class MovieRepo {
  Future<void> fetchMovies();
  Future<void> fetchSearchedMovies(String query);
}
