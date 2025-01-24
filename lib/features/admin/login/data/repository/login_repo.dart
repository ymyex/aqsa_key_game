// login_repo.dart
import 'package:aqsa_key_game/features/admin/login/data/models/login_admin_model.dart';
import 'package:dartz/dartz.dart';
import 'package:aqsa_key_game/core/network/errors/failure.dart';
import 'package:aqsa_key_game/core/network/errors/network_exceptions.dart';
import 'package:aqsa_key_game/features/admin/login/data/models/login_player_model.dart';
import 'package:aqsa_key_game/features/admin/login/data/repository/login_base_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginRepo extends LoginBaseRepo {
  final FirebaseFirestore firestore;

  LoginRepo({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;
  @override
  Future<Either<Failure, LoginPlayerModel>> loginPlayer({
    required String groupName,
    required String password,
  }) async {
    try {
      CollectionReference playersRef =
          firestore.collection('users').doc('players').collection('players');
      QuerySnapshot querySnapshot = await playersRef
          .where('group_name', isEqualTo: groupName)
          .limit(1) // Limit to one result for efficiency
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userDoc = querySnapshot.docs.first;
        var userData = userDoc.data() as Map<String, dynamic>;

        if (userData['password'] == password) {
          // Consider hashing passwords
          LoginPlayerModel user = LoginPlayerModel(
            id: userDoc.id,
            groupName: userData['group_name'],
            category: userData['category'],
            // Add other fields if necessary
          );
          return Right(user);
        } else {
          return const Left(NetworkExceptions.notFound('get failed'));
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
      // Access the 'admins' collection within the 'users' collection
      CollectionReference adminsRef =
          firestore.collection('users').doc('admins').collection('admins');

      // Query where 'category' equals the provided category
      QuerySnapshot querySnapshot = await adminsRef
          .where('category', isEqualTo: category)
          .limit(1) // Limit to one result for efficiency
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userDoc = querySnapshot.docs.first;
        var userData = userDoc.data() as Map<String, dynamic>;

        if (userData['password'] == password) {
          // Consider hashing passwords
          // Create a LoginAdminModel from Firestore data
          LoginAdminModel user = LoginAdminModel(
            id: userDoc.id,
            phoneNumber: userData['phone_number'] ?? '',
            category: userData['category'] ?? '',
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
