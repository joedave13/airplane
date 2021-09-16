import 'package:airplane/models/user_model.dart';
import 'package:airplane/services/auth_service.dart';
import 'package:airplane/services/user_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signIn({
    required String email,
    required String password,
  }) async {
    try {
      //* Loading State
      emit(AuthLoading());

      //* Sign In User
      UserModel user = await AuthService().signIn(
        email: email,
        password: password,
      );

      //* If sign in success, change state to Auth Success
      emit(AuthSuccess(user));
    } catch (e) {
      //* If sign in error, change state to Auth Error
      emit(AuthFailed(e.toString()));
    }
  }

  void signUp({
    required String email,
    required String password,
    required String name,
    String hobby = '',
  }) async {
    try {
      //* Loading State
      emit(AuthLoading());

      //* Register User
      UserModel user = await AuthService().signUp(
        email: email,
        password: password,
        name: name,
        hobby: hobby,
      );

      //* If registered successfully, change state to success
      emit(AuthSuccess(user));
    } catch (e) {
      //* If register failed, change state to failed
      emit(AuthFailed(e.toString()));
    }
  }

  void signOut() async {
    try {
      //* Loading State
      emit(AuthLoading());

      //* Sign out current user
      await AuthService().signOut();

      //* Change auth state back to Auth Initial
      emit(AuthInitial());
    } catch (e) {
      //* If sign out failed, change to Auth Failed
      emit(AuthFailed(e.toString()));
    }
  }

  void getCurrentUser(String id) async {
    try {
      UserModel user = await UserService().getUserById(id);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
