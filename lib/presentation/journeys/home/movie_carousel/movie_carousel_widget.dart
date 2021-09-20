import 'package:flutter/material.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:movieapp/presentation/widgets/movie_app_bar.dart';

class MovieCarouserWidget extends StatelessWidget {
  final List<MovieEntity> movies;
  final int defaultIndex;

  const MovieCarouserWidget(
      {Key key, @required this.movies, @required this.defaultIndex})
      : assert(defaultIndex >= 0, 'defaultIndex cannot be less than 0'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      MovieAppBar(),
      MoviePageView(movies: movies, initialPage: defaultIndex)
    ]);
  }
}
