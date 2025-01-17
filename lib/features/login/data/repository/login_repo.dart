// login_repo.dart
import 'package:aqsa_key_game/features/login/data/models/login_admin_model.dart';
import 'package:dartz/dartz.dart';
import 'package:aqsa_key_game/core/network/errors/failure.dart';
import 'package:aqsa_key_game/core/network/errors/network_exceptions.dart';
import 'package:aqsa_key_game/features/login/data/models/login_player_model.dart';
import 'package:aqsa_key_game/features/login/data/repository/login_base_repo.dart';
import 'package:firebase_database/firebase_database.dart';

class LoginRepo extends LoginBaseRepo {
  @override
  Future<Either<Failure, LoginPlayerModel>> loginPlayer({
    required String groupName,
    required String password,
  }) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("users");
      Query query = ref.orderByChild('group_name').equalTo(groupName);
      DatabaseEvent snapshot = await query.once();

      if (snapshot.snapshot.exists) {
        Map<dynamic, dynamic> users =
            snapshot.snapshot.value as Map<dynamic, dynamic>;
        var userKey = users.keys.first;
        var userData = users[userKey];

        if (userData['password'] == password) {
          // Consider hashing passwords
          LoginPlayerModel user = LoginPlayerModel(
            id: userKey,
            groupName: userData['group_name'],
            category: userData['category'],
            // Add other fields if necessary
          );
          return Right(user);
        } else {
          return Right(LoginPlayerModel(
            id: '0',
            groupName: '',
            category: '',
            // Add other fields if necessary
          ));
        }
      } else {
        return const Left(NetworkExceptions.notFound('get failed'));
      }
    } catch (error) {
      return Left(NetworkExceptions.getDioException(error));
    }
  }

  @override
  Future<Either<Failure, LoginAdminModel>> loginAdmin(
      {required String category,
      required String password,
      required String adminKey}) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("users");
      Query query = ref.orderByChild('category').equalTo(category);
      DatabaseEvent snapshot = await query.once();

      if (snapshot.snapshot.exists) {
        Map<dynamic, dynamic> users =
            snapshot.snapshot.value as Map<dynamic, dynamic>;
        var userKey = users.keys.first;
        var userData = users[userKey];

        if (userData['password'] == password) {
          // Consider hashing passwords
          LoginAdminModel user = LoginAdminModel(
            id: userKey,
            phoneNumber: userData['phone_number'],
            category: userData['category'],
            // Add other fields if necessary
          );
          return Right(user);
        } else {
          return Right(LoginAdminModel(
            id: '0',
            phoneNumber: '',
            category: '',
            // Add other fields if necessary
          ));
        }
      } else {
        return const Left(NetworkExceptions.notFound('get failed'));
      }
    } catch (error) {
      return Left(NetworkExceptions.getDioException(error));
    }
  }
}
