import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/no_params.dart';
import 'package:movieapp/domain/usecases/get_comming_soon.dart';
import 'package:movieapp/domain/usecases/get_playing_now.dart';
import 'package:movieapp/domain/usecases/get_popular.dart';
import 'package:movieapp/presentation/blocs/movie_tabbed/movie_tabbed_cubit.dart';
import 'package:test/test.dart';

class GetPopularMock extends Mock implements GetPopular {}

class GetPlayingNowMock extends Mock implements GetPlayingNow {}

class GetCommingSoonMock extends Mock implements GetCommingSoon {}

main() {
  GetPopularMock getPopularMock;
  GetPlayingNowMock getPlayingNowMock;
  GetCommingSoonMock getCommingSoonMock;

  MovieTabbedCubit movieTabbedCubit;

  setUp(() {
    getPopularMock = GetPopularMock();
    getPlayingNowMock = GetPlayingNowMock();
    getCommingSoonMock = GetCommingSoonMock();

    movieTabbedCubit = MovieTabbedCubit(
        getCommingSoon: getCommingSoonMock,
        getPlayingNow: getPlayingNowMock,
        getPopular: getPopularMock);
  });

  tearDown(() {
    movieTabbedCubit.close();
  });

  test('bloc should have initial state as [MovieTabbedInitial]', () {
    expect(movieTabbedCubit.state.runtimeType, MovieTabbedInitial);
  });

  blocTest(
      'should emit [MovieTabLoading, MovieTabChanged] state when playing now tab changed success',
      build: () => movieTabbedCubit,
      act: (MovieTabbedCubit cubit) {
        when(getPlayingNowMock.call(NoParams()))
            .thenAnswer((_) async => Right([]));

        cubit.movieTabbedChanged(currentTabIndex: 1);
      },
      expect: [isA<MovieTabLoading>(), isA<MovieTabChanged>()],
      verify: (MovieTabbedCubit cubit) {
        verify(getPlayingNowMock.call(any)).called(1);
      });

  blocTest(
      'should emit [MovieTabLoading, MovieTabChanged] state when popular tab changed success',
      build: () => movieTabbedCubit,
      act: (MovieTabbedCubit cubit) {
        when(getPopularMock.call(NoParams()))
            .thenAnswer((_) async => Right([]));

        cubit.movieTabbedChanged(currentTabIndex: 0);
      },
      expect: [isA<MovieTabLoading>(), isA<MovieTabChanged>()],
      verify: (MovieTabbedCubit cubit) {
        verify(getPopularMock.call(any)).called(1);
      });

  blocTest(
      'should emit [MovieTabLoading, MovieTabLoadError] state when comming soon tab changed success',
      build: () => movieTabbedCubit,
      act: (MovieTabbedCubit cubit) {
        when(getCommingSoonMock.call(NoParams()))
            .thenAnswer((_) async => Right([]));

        cubit.movieTabbedChanged(currentTabIndex: 2);
      },
      expect: [isA<MovieTabLoading>(), isA<MovieTabLoadError>()],
      verify: (MovieTabbedCubit cubit) {
        verify(getCommingSoonMock.call(any)).called(1);
      });

  blocTest(
      'should emit [MovieTabLoading, MovieTabChanged] state when comming soon tab changed fail',
      build: () => movieTabbedCubit,
      act: (MovieTabbedCubit cubit) {
        when(getCommingSoonMock.call(NoParams()))
            .thenAnswer((_) async => Left(AppError(AppErrorType.api)));

        cubit.movieTabbedChanged(currentTabIndex: 2);
      },
      expect: [isA<MovieTabLoading>(), isA<MovieTabChanged>()],
      verify: (MovieTabbedCubit cubit) {
        verify(getCommingSoonMock.call(any)).called(1);
      });
}
