import 'package:flutter/material.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/domain/entities/movie_entity.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';

import 'favorite_movie_card.dart';

class FavoriteMovieGridView extends StatelessWidget {
  final List<MovieEntity> movies;
  FavoriteMovieGridView(this.movies);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_8.w),
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: movies.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: Sizes.dimen_16.w),
            itemBuilder: (context, index) {
              return FavoriteMovieCard(movies: movies[index]);
            }));
  }
}
