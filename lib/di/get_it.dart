import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:movieapp/data/core/api_client.dart';
import 'package:movieapp/data/data_sources/movie_remote_data_source.dart';
import 'package:movieapp/data/repositories/movie_repository_impl.dart';
import 'package:movieapp/domain/repositories/movie_repository.dart';
import 'package:movieapp/domain/usecases/get_cast.dart';
import 'package:movieapp/domain/usecases/get_comming_soon.dart';
import 'package:movieapp/domain/usecases/get_movie_detail.dart';
import 'package:movieapp/domain/usecases/get_playing_now.dart';
import 'package:movieapp/domain/usecases/get_popular.dart';
import 'package:movieapp/domain/usecases/get_trending.dart';
import 'package:movieapp/domain/usecases/get_videos.dart';
import 'package:movieapp/domain/usecases/search_movies.dart';
import 'package:movieapp/presentation/blocs/cast/cast_bloc.dart';
import 'package:movieapp/presentation/blocs/language/language_bloc.dart';
import 'package:movieapp/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movieapp/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:movieapp/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movieapp/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:movieapp/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:movieapp/presentation/blocs/videos/videos_bloc.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());

  getItInstance.registerLazySingleton(() => ApiClient(getItInstance()));

  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(getItInstance()));

  getItInstance
      .registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));

  getItInstance
      .registerLazySingleton<GetPopular>(() => GetPopular(getItInstance()));

  getItInstance.registerLazySingleton<GetPlayingNow>(
      () => GetPlayingNow(getItInstance()));

  getItInstance.registerLazySingleton<GetCommingSoon>(
      () => GetCommingSoon(getItInstance()));

  getItInstance.registerLazySingleton<GetMovieDetail>(
      () => GetMovieDetail(getItInstance()));

  getItInstance.registerLazySingleton<GetCast>(
    () => GetCast(
      getItInstance(),
    ),
  );

  getItInstance.registerLazySingleton<SearchMovies>(
    () => SearchMovies(
      getItInstance(),
    ),
  );

  getItInstance.registerLazySingleton<GetVideos>(
    () => GetVideos(
      getItInstance(),
    ),
  );

  getItInstance.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(getItInstance()));

  getItInstance.registerFactory(() => MovieBackdropBloc());

  getItInstance.registerFactory(
    () => MovieCarouselBloc(
      getTrending: getItInstance(),
      movieBackdropBloc: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => MovieTabbedBloc(
      getPopular: getItInstance(),
      getCommingSoon: getItInstance(),
      getPlayingNow: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => MovieDetailBloc(
        getMovieDetail: getItInstance(),
        castBloc: getItInstance(),
        videosBloc: getItInstance()),
  );

  getItInstance.registerFactory(
    () => CastBloc(getCast: getItInstance()),
  );

  getItInstance.registerFactory(
    () => VideosBloc(getVideos: getItInstance()),
  );

  getItInstance.registerFactory(
    () => SearchMovieBloc(searchMovies: getItInstance()),
  );

  getItInstance.registerSingleton<LanguageBloc>(LanguageBloc());
}
