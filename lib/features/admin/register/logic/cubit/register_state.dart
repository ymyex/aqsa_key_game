part of 'register_cubit.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final RegisterUserModel registerUserModel;
  RegisterSuccessState(this.registerUserModel);
}

class RegisterErrorState extends RegisterStates {
  final String message;
  RegisterErrorState(this.message);
}
