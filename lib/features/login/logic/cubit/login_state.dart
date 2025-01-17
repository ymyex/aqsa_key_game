import 'package:aqsa_key_game/features/login/data/models/login_user_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LoginUserModel loginUserModel;
  LoginSuccessState(this.loginUserModel);
}

class LoginErrorState extends LoginStates {
  final String message;
  LoginErrorState(this.message);
}
