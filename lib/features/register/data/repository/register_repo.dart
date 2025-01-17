import 'package:dartz/dartz.dart';
import 'package:aqsa_key_game/core/network/errors/failure.dart';
import 'package:aqsa_key_game/core/network/errors/network_exceptions.dart';
import 'package:aqsa_key_game/features/register/data/models/register_user_model.dart';
import 'package:aqsa_key_game/features/register/data/repository/register_base_repo.dart';
import 'package:firebase_database/firebase_database.dart';

class RegisterRepo extends RegisterBaseRepo {
  @override
  Future<Either<Failure, RegisterUserModel>> registerPlayer({
    required String groupName,
    required String category,
    required String password,
  }) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("users");
      DatabaseReference newUserRef = ref.push();

      await newUserRef.set({
        'group_name': groupName,
        'category': category,
        'password': password,
      });

      RegisterUserModel user =
          RegisterUserModel(userId: newUserRef.key!, success: true);

      return Right(user);
    } catch (error) {
      return Left(NetworkExceptions.getDioException(error));
    }
  }

  @override
  Future<Either<Failure, RegisterUserModel>> registerAdmin({
    required String phoneNumber,
    required String category,
    required String password,
    required String adminKey,
  }) async {
    try {
      // Reference to the admin_key in the database
      DatabaseReference keyRef = FirebaseDatabase.instance.ref("admin_key");

      // Retrieve the admin_key from the database
      DataSnapshot keySnapshot = await keyRef.get();

      // Check if the admin_key exists in the database
      if (!keySnapshot.exists) {
        return const Left(
            NetworkExceptions.notFound('هناك مشكلة في الاتصال بالشبكة'));
      }

      // Extract the stored admin key
      String storedKey = keySnapshot.value as String;

      // Compare the provided key with the stored key
      if (adminKey != storedKey) {
        return const Left(
            NetworkExceptions.unauthorizedRequest('الرمز السري خاطئ'));
      }

      // If keys match, proceed to register the admin user
      DatabaseReference usersRef = FirebaseDatabase.instance.ref("users");
      DatabaseReference newUserRef = usersRef.push();

      // Set the new admin user's data
      await newUserRef.set({
        'phone_number': phoneNumber,
        'category': category,
        'password': password,
        // Add other necessary fields
      });

      // Create a RegisterUserModel instance with the new user's ID
      RegisterUserModel user = RegisterUserModel(
        userId: newUserRef.key!,
        success: true,
      );

      // Return the successful result
      return Right(user);
    } catch (error) {
      // Handle any errors that occur during the process
      return const Left(
          NetworkExceptions.notFound('هناك مشكلة في الاتصال بالشبكة'));
      // Alternatively, use a more specific Failure subclass based on the error
    }
  }
}
