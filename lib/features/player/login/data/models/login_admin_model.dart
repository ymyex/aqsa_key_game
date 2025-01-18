import 'package:aqsa_key_game/features/admin/login/data/models/login_user_model.dart';

class LoginAdminModel extends LoginUserModel {
  final String phoneNumber;

  LoginAdminModel({
    required this.phoneNumber,
    required super.id,
    required super.category,
  });
}
