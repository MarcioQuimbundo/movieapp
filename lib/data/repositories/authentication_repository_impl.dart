import 'dart:io';

import 'package:movieapp/data/core/unathorised_exception.dart';
import 'package:movieapp/data/data_sources/authentication_local_data_source.dart';
import 'package:movieapp/data/data_sources/authentication_remote_data_sourse.dart';
import 'package:movieapp/data/models/request_token_model.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;
  final AuthenticationLocalDataSource _authenticationLocalDataSource;
  AuthenticationRepositoryImpl(this._authenticationRemoteDataSource,
      this._authenticationLocalDataSource);

  Future<Either<AppError, RequestTokenModel>> _getRequestToken() async {
    try {
      final response = await _authenticationRemoteDataSource.getRequestToken();
      return Right(response);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, bool>> loginUser(Map<String, dynamic> body) async {
    final requestTokenEitherResponse = await _getRequestToken();
    final token1 =
        requestTokenEitherResponse.getOrElse(() => null)?.requestToken ?? '';
    try {
      body.putIfAbsent('request_token', () => token1);
      final validateWithLoginToken =
          await _authenticationRemoteDataSource.validateWithLogin(body);
      final sessionId = await _authenticationRemoteDataSource
          .createSession(validateWithLoginToken.toJson());
      if (sessionId != null) {
        await _authenticationLocalDataSource.saveSessionId(sessionId);
        return Right(true);
      }
      return Left(AppError(AppErrorType.sessionDenied));
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on UnauthorisedException {
      return Left(AppError(AppErrorType.unauthorised));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, void>> logoutUser() async {
    final sessionId = await _authenticationLocalDataSource.getSessionId();
    await Future.wait([
      _authenticationRemoteDataSource.deleteSession(sessionId),
      _authenticationLocalDataSource.deleteSessionId()
    ]);
    print(sessionId);
    return Right(Unit);
  }
}
