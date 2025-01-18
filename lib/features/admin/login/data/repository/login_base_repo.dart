// login_base_repo.dart
import 'package:aqsa_key_game/features/admin/login/data/models/login_admin_model.dart';
import 'package:dartz/dartz.dart';
import 'package:aqsa_key_game/core/network/errors/failure.dart';
import 'package:aqsa_key_game/features/admin/login/data/models/login_player_model.dart';

abstract class LoginBaseRepo {
  Future<Either<Failure, LoginPlayerModel>> loginPlayer({
    required String groupName,
    required String password,
  });
  Future<Either<Failure, LoginAdminModel>> loginAdmin({
    required String adminKey,
    required String category,
    required String password,
  });
}
