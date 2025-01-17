import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aqsa_key_game/core/network/errors/network_exceptions.dart';
import 'package:aqsa_key_game/features/register/data/models/register_user_model.dart';
import 'package:aqsa_key_game/features/register/data/repository/register_base_repo.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  final RegisterBaseRepo registerRepo;
  static RegisterCubit get(context) => BlocProvider.of(context);

  RegisterCubit(this.registerRepo) : super(RegisterInitialState());

  Future<void> registerPlayer(
      String groupName, String category, String password) async {
    emit(RegisterLoadingState());

    var response = await registerRepo.registerPlayer(
      groupName: groupName,
      category: category,
      password: password,
    );

    response.fold((failure) {
      // Ensure that we properly handle the Failure type
      emit(RegisterErrorState(
          NetworkExceptions.getErrorMessage(failure as NetworkExceptions)));
    }, (success) {
      emit(RegisterSuccessState(success));
    });
  }

  Future<void> registerAdmin(String phoneNumber, String adminKey,
      String category, String password) async {
    emit(RegisterLoadingState());

    var response = await registerRepo.registerAdmin(
      phoneNumber: phoneNumber,
      adminKey: adminKey,
      category: adminKey,
      password: password,
    );

    response.fold((failure) {
      // Ensure that we properly handle the Failure type
      emit(RegisterErrorState(
          NetworkExceptions.getErrorMessage(failure as NetworkExceptions)));
    }, (success) {
      emit(RegisterSuccessState(success));
    });
  }
}
