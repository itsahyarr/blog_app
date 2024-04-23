import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import '../../../../core/common/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    // try {
    //   final user = await remoteDataSource.loginWithEmailPassword(
    //     email: email,
    //     password: password,
    //   );

    //   return right(user);
    // } on ServerException catch (e) {
    //   return left(Failure(e.message));
    // }
    return await _getUser(
      () async => await remoteDataSource.loginWithEmailPassword(
          email: email, password: password),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    debugPrint('SIGNUP_PARAMS : $name\n $email\n $password\n');
    
    // try {
    //   final user = await remoteDataSource.signUpWithEmailPassword(
    //     name: name,
    //     email: email,
    //     password: password,
    //   );

    //   return right(user);
    // } on ServerException catch (e) {
    //   return left(Failure(e.message));
    // }
    return await _getUser(
      () async => await remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      final user = await fn();
      //  await remoteDataSource.loginWithEmailPassword(
      //   email: email,
      //   password: password,
      // );

      return right(user);
    } on sb.AuthException catch (e) {
      debugPrint('AUTH_EXEPTION : $e\n');
      return left(Failure(e.message));
    } on ServerException catch (e) {
      debugPrint('SERVER_EXEPTION : $e\n');
      debugPrint('SERVER_EXEPTION_MESSAGE : ${e.message}\n');
      debugPrint(e.toString());
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUserData();

      if (user == null) {
        return left(Failure('User is not logged in'));
      }

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
