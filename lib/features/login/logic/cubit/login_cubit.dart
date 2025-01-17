// login_cubit.dart
import 'package:aqsa_key_game/features/login/data/models/login_admin_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aqsa_key_game/core/network/errors/failure.dart';
import 'package:aqsa_key_game/core/network/local/cache_helper.dart';
import 'package:aqsa_key_game/features/login/data/models/login_player_model.dart';
import 'package:aqsa_key_game/features/login/data/repository/login_base_repo.dart';
import 'package:aqsa_key_game/features/login/logic/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  final LoginBaseRepo loginRepo;
  static LoginCubit get(context) => BlocProvider.of(context);

  LoginCubit(this.loginRepo) : super(LoginInitialState());

  Future<void> loginPlayer(String username, String password) async {
    emit(LoginLoadingState());

    Either<Failure, LoginPlayerModel> response = await loginRepo.loginPlayer(
      groupName: username,
      password: password,
    );

    response.fold((failure) {
      String messege = "Wrong Username or Password";
      emit(LoginErrorState(messege));
    }, (success) {
      CacheHelper.savedata(key: "id", value: success.id);
      CacheHelper.savedata(key: "group_name", value: success.groupName);
      CacheHelper.savedata(key: "category", value: success.category);
      emit(LoginSuccessState(success));
    });
  }

  Future<void> loginAdmin(
      String category, String password, String adminKey) async {
    emit(LoginLoadingState());

    Either<Failure, LoginAdminModel> response = await loginRepo.loginAdmin(
      adminKey: adminKey,
      category: category,
      password: password,
    );

    response.fold((failure) {
      String messege = "Wrong Username or Password";
      emit(LoginErrorState(messege));
    }, (success) {
      CacheHelper.savedata(key: "id", value: success.id);
      CacheHelper.savedata(key: "phone_number", value: success.phoneNumber);
      CacheHelper.savedata(key: "category", value: success.category);
      emit(LoginSuccessState(success));
    });
  }
}
