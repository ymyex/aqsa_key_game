import 'package:dartz/dartz.dart';
import 'package:aqsa_key_game/core/network/errors/failure.dart';
import 'package:aqsa_key_game/features/admin/register/data/models/register_user_model.dart';

abstract class RegisterBaseRepo {
  Future<Either<Failure, RegisterUserModel>> registerPlayer({
    required String groupName,
    required String category,
    required String password,
  });
  Future<Either<Failure, RegisterUserModel>> registerAdmin({
    required String phoneNumber,
    required String category,
    required String password,
    required String adminKey,
  });
}
