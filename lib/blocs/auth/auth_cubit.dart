import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());


  Future<void> getMe() async {
    emit(AuthLoading());
    try {
      final me = await authRepository.getMe();
      emit(MeLoaded(me));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }


  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      await authRepository.login(email, password);
      emit(AuthSuccess('Connection Effectuée avec succès'));
    } catch (e) {
      print(e.toString());
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register(String email, String fullname, String password , String confirmPassword, String referrerCode) async {
    emit(AuthLoading());
    try {
      await authRepository.register(email, fullname, password , confirmPassword, referrerCode);
      emit(AuthSuccess('Inscription Effectuée avec succès'));
    } catch (e) {
      print(e.toString());
      emit(AuthError(e.toString()));
    }
  }

  Future<void> resetPassword(String id, String password , String confirmPassword) async {
    emit(AuthLoading());
    try {
      await authRepository.resetPassword(id, password, confirmPassword);
      emit(AuthSuccess('Mot de passe modifier avec succès'));
    } catch (e) {
      print(e.toString());
      emit(AuthError(e.toString()));
    }
  }

  Future<void> forgotPasswordRequest(String email) async {
    emit(AuthLoading());
    try {
      await authRepository.forgotPasswordRequest(email);
      emit(AuthSuccess('Effectuée avec succès'));
    } catch (e) {
      print(e.toString());
      emit(AuthError(e.toString()));
    }
  }

  Future<void> resendForgotPasswordCode(String email) async {
    emit(AuthLoading());
    try {
      await authRepository.resendForgotPasswordCode(email);
      emit(AuthSuccess('Effectuée avec succès'));
    } catch (e) {
      print(e.toString());
      emit(AuthError(e.toString()));
    }
  }

  Future<void> verifyCode(String email, String code) async {
    emit(AuthLoading());
    try {
      await authRepository.verifyCode(email, code);
      emit(AuthSuccess('Verrification effectuée avec succès'));
    } catch (e) {
      print(e.toString());
      emit(AuthError(e.toString()));
    }
  }


  Future<void> logout() async {
    await authRepository.logout();
    emit(AuthInitial());
  }
}
