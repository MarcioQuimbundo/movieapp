import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:movieapp/presentation/blocs/movie_backdrop/movie_backdrop_cubit.dart';

class MovieDataWidget extends StatelessWidget {
  const MovieDataWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBackdropCubit, MovieEntity>(
      builder: (context, movie) {
        if (movie != null) {
          return Text(movie.title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: Theme.of(context).textTheme.headline6);
        }
        return SizedBox.shrink();
      },
    );
  }
}
