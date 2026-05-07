import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  // SAVE USER DATA
  Future<void> saveUserData({

    required String uid,
    required String fullName,
    required String email,
    required String phone,
    required String studentId,

  }) async {

    await _firestore
        .collection('users')
        .doc(uid)
        .set({

      'fullName': fullName,
      'nickname': '',
      'email': email,
      'phone': phone,
      'studentId': studentId,
      'department':
      'Computer Science & Engineering',
      'university':
      'Bangladesh Army University of Science & Technology',
      'profileImage': '',
      'createdAt': Timestamp.now(),
    });
  }

  // GET USER DATA
  Future<DocumentSnapshot<Map<String, dynamic>>>
  getUserData(String uid) async {

    return await _firestore
        .collection('users')
        .doc(uid)
        .get();
  }

  // UPDATE PROFILE IMAGE
  Future<void> updateProfileImage({

    required String uid,
    required String imageUrl,

  }) async {

    await _firestore
        .collection('users')
        .doc(uid)
        .update({

      'profileImage': imageUrl,
    });
  }

  // UPDATE PROFILE
  Future<void> updateProfile({

    required String uid,
    required String fullName,
    required String nickname,
    required String phone,
    required String studentId,
    required String department,
    required String university,

  }) async {

    await _firestore
        .collection('users')
        .doc(uid)
        .update({

      'fullName': fullName,
      'nickname': nickname,
      'phone': phone,
      'studentId': studentId,
      'department': department,
      'university': university,
    });
  }
}