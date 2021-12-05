import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:movieapp/domain/entities/no_params.dart';
import 'package:movieapp/domain/usecases/get_trending.dart';
import 'package:movieapp/presentation/blocs/loading/loading_cubit.dart';
import 'package:movieapp/presentation/blocs/movie_backdrop/movie_backdrop_cubit.dart';

part 'movie_carousel_state.dart';

class MovieCarouselCubit extends Cubit<MovieCarouselState> {
  final GetTrending getTrending;
  final MovieBackdropCubit movieBackdropCubit;
  final LoadingCubit loadingCubit;
  MovieCarouselCubit(
      {@required this.loadingCubit,
      @required this.getTrending,
      @required this.movieBackdropCubit})
      : super(MovieCarouselInitial());

  void carouselLoad({int defaultIndex = 0}) async {
    loadingCubit.show();
    final moviesEither = await getTrending(NoParams());

    emit(
      moviesEither.fold((l) => MovieCarouselError(l.appErrorType), (movies) {
        movieBackdropCubit.backdropChanged(movies[defaultIndex]);
        return MovieCarouseLoaded(movies: movies, defaultIndex: defaultIndex);
      }),
    );

    loadingCubit.hide();
  }
}
