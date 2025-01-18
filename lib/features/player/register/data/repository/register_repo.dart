// register_repo.dart
import 'package:aqsa_key_game/features/admin/register/data/models/register_user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:aqsa_key_game/core/network/errors/failure.dart';
import 'package:aqsa_key_game/core/network/errors/network_exceptions.dart';
import 'package:aqsa_key_game/features/admin/register/data/repository/register_base_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterRepo extends RegisterBaseRepo {
  final FirebaseFirestore firestore;

  RegisterRepo({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<Either<Failure, RegisterUserModel>> registerPlayer({
    required String groupName,
    required String category,
    required String password,
  }) async {
    try {
      // Reference to the 'players' collection within the 'users' collection
      CollectionReference playersRef =
          firestore.collection('users').doc('players').collection('players');

      // Add a new document with the provided player details
      DocumentReference newUserRef = await playersRef.add({
        'group_name': groupName,
        'category': category,
        'password': password,
      });

      // Create a RegisterUserModel instance with the new user's ID
      RegisterUserModel user =
          RegisterUserModel(userId: newUserRef.id, success: true);

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
      // Reference to the 'admin_key' document within the 'config' collection
      DocumentReference adminKeyRef =
          firestore.collection('config').doc('admin_key');

      // Retrieve the admin_key from Firestore
      DocumentSnapshot adminKeySnapshot = await adminKeyRef.get();

      // Check if the admin_key document exists
      if (!adminKeySnapshot.exists) {
        return const Left(
            NetworkExceptions.notFound('هناك مشكلة في الاتصال بالشبكة'));
      }

      // Extract the stored admin key
      Map<String, dynamic> adminKeyData =
          adminKeySnapshot.data() as Map<String, dynamic>;
      String storedKey = adminKeyData['key'] ?? '';

      // Compare the provided key with the stored key
      if (adminKey != storedKey) {
        return const Left(
            NetworkExceptions.unauthorizedRequest('الرمز السري خاطئ'));
      }

      // If keys match, proceed to register the admin user
      CollectionReference adminsRef =
          firestore.collection('users').doc('admins').collection('admins');

      // Add a new document with the provided admin details
      DocumentReference newUserRef = await adminsRef.add({
        'phone_number': phoneNumber,
        'category': category,
        'password': password,
        // Add other necessary fields if needed
      });

      // Create a RegisterUserModel instance with the new admin's ID
      RegisterUserModel user =
          RegisterUserModel(userId: newUserRef.id, success: true);

      return Right(user);
    } catch (error) {
      // Handle any errors that occur during the process
      return const Left(
          NetworkExceptions.notFound('هناك مشكلة في الاتصال بالشبكة'));
      // Alternatively, you can return a more specific Failure subclass based on the error
    }
  }
}
