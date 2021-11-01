import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:movieapp/domain/entities/no_params.dart';
import 'package:movieapp/domain/usecases/get_comming_soon.dart';
import 'package:movieapp/domain/usecases/get_playing_now.dart';
import 'package:movieapp/domain/usecases/get_popular.dart';

part 'movie_tabbed_event.dart';
part 'movie_tabbed_state.dart';

class MovieTabbedBloc extends Bloc<MovieTabbedEvent, MovieTabbedState> {
  final GetPopular getPopular;
  final GetPlayingNow getPlayingNow;
  final GetCommingSoon getCommingSoon;

  MovieTabbedBloc(
      {@required this.getPopular,
      @required this.getPlayingNow,
      @required this.getCommingSoon})
      : super(MovieTabbedInitial());

  @override
  Stream<MovieTabbedState> mapEventToState(MovieTabbedEvent event) async* {
    if (event is MovieTabChangedEvent) {
      Either<AppError, List<MovieEntity>> moviesEither;
      switch (event.currentTabIndex) {
        case 0:
          moviesEither = await getPopular(NoParams());
          break;
        case 1:
          moviesEither = await getPlayingNow(NoParams());
          break;
        case 2:
          moviesEither = await getCommingSoon(NoParams());
          break;
      }
      yield moviesEither.fold(
          (l) => MovieTabLoadError(
              currentTabIndex: event.currentTabIndex,
              errorType: l.appErrorType), (movies) {
        return MovieTabChanged(
            currentTabIndex: event.currentTabIndex, movies: movies);
      });
    }
  }
}
