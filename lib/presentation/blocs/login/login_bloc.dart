import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/login_request_params.dart';
import 'package:movieapp/domain/entities/no_params.dart';
import 'package:movieapp/domain/usecases/login_user.dart';
import 'package:movieapp/domain/usecases/logout_user.dart';
import 'package:movieapp/presentation/blocs/loading/loading_cubit.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUser loginUser;
  final LogoutUser logoutUser;
  final LoadingCubit loadingCubit;

  LoginBloc(
      {@required this.loadingCubit,
      @required this.loginUser,
      @required this.logoutUser})
      : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginInitialEvent) {
      loadingCubit.show();

      final Either<AppError, bool> eitherResponse = await loginUser(
        LoginRequestParams(userName: event.username, password: event.password),
      );

      yield eitherResponse.fold(
        (l) {
          var message = getErrorMessage(l.appErrorType);
          return LoginError(message);
        },
        (r) => LoginSuccess(),
      );
      loadingCubit.hide();

    } else if (event is LogoutEvent) {
      await logoutUser(NoParams());
      yield LogoutSuccess();
    }
  }
}

String getErrorMessage(AppErrorType appErrorType) {
  switch (appErrorType) {
    case AppErrorType.network:
      return TranslationConstants.noNetwork;
    case AppErrorType.api:
    case AppErrorType.database:
      return TranslationConstants.somethingWentWrong;
    case AppErrorType.sessionDenied:
      return TranslationConstants.sessionDenied;
    default:
      return TranslationConstants.wrongUsernamePassword;
  }
}
