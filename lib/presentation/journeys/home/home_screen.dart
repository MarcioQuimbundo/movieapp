import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/di/get_it.dart';
import 'package:movieapp/presentation/blocs/movie_backdrop/movie_backdrop_cubit.dart';
import 'package:movieapp/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:movieapp/presentation/blocs/movie_tabbed/movie_tabbed_cubit.dart';
import 'package:movieapp/presentation/blocs/search_movie/search_movie_cubit.dart';
import 'package:movieapp/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:movieapp/presentation/journeys/home/movie_tabbed/movie_tabbed_widget.dart';

import '../../widgets/app_error_widget.dart';
import 'movie_carousel/movie_carousel_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MovieCarouselCubit movieCarouselBloc;
  MovieBackdropCubit movieBackdropBloc;
  MovieTabbedCubit movieTabbedBloc;
  SearchMovieCubit searchMovieBloc;

  @override
  void initState() {
    super.initState();
    movieCarouselBloc = getItInstance<MovieCarouselCubit>();
    movieBackdropBloc = movieCarouselBloc.movieBackdropCubit;
    movieTabbedBloc = getItInstance<MovieTabbedCubit>();
    searchMovieBloc = getItInstance<SearchMovieCubit>();
    movieCarouselBloc.carouselLoad();
  }

  @override
  void dispose() {
    super.dispose();
    movieCarouselBloc?.close();
    movieBackdropBloc?.close();
    movieTabbedBloc?.close();
    searchMovieBloc?.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => movieCarouselBloc,
        ),
        BlocProvider(
          create: (context) => movieBackdropBloc,
        ),
        BlocProvider(
          create: (context) => movieTabbedBloc,
        ),
        BlocProvider(
          create: (context) => searchMovieBloc,
        ),
      ],
      child: Scaffold(
        drawer: const NavigationDrawer(),
        body: BlocBuilder<MovieCarouselCubit, MovieCarouselState>(
          cubit: movieCarouselBloc,
          builder: (context, state) {
            if (state is MovieCarouseLoaded) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  FractionallySizedBox(
                      alignment: Alignment.topCenter,
                      heightFactor: 0.6,
                      child: MovieCarouselWidget(
                          movies: state.movies,
                          defaultIndex: state.defaultIndex)),
                  FractionallySizedBox(
                    alignment: Alignment.bottomCenter,
                    heightFactor: 0.4,
                    child: MovieTabbedWidget(),
                  )
                ],
              );
            } else if (state is MovieCarouselError) {
              return AppErrorWidget(
                onPressed: () => movieCarouselBloc.carouselLoad(),
                errorType: state.errorType,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
