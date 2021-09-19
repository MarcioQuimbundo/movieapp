import 'package:movieapp/domain/entities/movie_entity.dart';

abstract class MovieRepository {
  Future<List<MovieEntity>> getTrending();
}