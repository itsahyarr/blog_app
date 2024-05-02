import 'package:blog_app/core/error/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;

  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );

      if (response.user == null) {
        throw ServerException('User is null');
      }

      debugPrint('RESPONSE_USER : ${response.user}');

      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      debugPrint('AUTH_EXEPTION : $e\n');

      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {
          'name': name,
        },
      );

      if (response.user == null) {
        throw ServerException('User is null');
      }

      debugPrint('RESPONSE_USER : ${response.user}');

      debugPrint(
          '\nUSER_META_DATA : ${currentUserSession!.user.userMetadata!['email']}\n');
      debugPrint('\nUSER_EMAIL : ${currentUserSession!.user.email}\n');

      debugPrint('JSON : ${response.user!.toJson()}\n');

      debugPrint(
          'JSON_CONVERTED : ${UserModel.fromJson(response.user!.toJson())}\n');
      // debugPrint(
      //     'JSON_CONVERTED : ${UserModel.fromJson(response.user!.toJson()).copyWith( email: currentUserSession!.user.email ?? '')}\n');
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      debugPrint('AUTH_EXEPTION : $e\n');

      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession == null) return null;

      final userData = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', currentUserSession!.user.id);
      return UserModel.fromJson(userData.first).copyWith(
        email: currentUserSession!.user.email ?? 'no_email',
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
