import 'package:aqsa_key_game/features/admin/login/data/models/login_user_model.dart';

class LoginPlayerModel extends LoginUserModel {
  final String groupName;

  LoginPlayerModel({
    required this.groupName,
    required super.id,
    required super.category,
  });
}
