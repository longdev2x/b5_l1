import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exercies4/common/data/model/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepos {
  static final FirebaseAuth _fbAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _fbStore = FirebaseFirestore.instance;

  static Future<UserCredential> signUp({required String email, required String pass}) async {
    return await _fbAuth.createUserWithEmailAndPassword(email: email, password: pass);
  }

  static Future<UserCredential> signIn({required String email, required String pass}) async {
    return await _fbAuth.signInWithEmailAndPassword(email: email, password: pass);
  }

  static Future<void> setUserInfor(UserEntity objUser) async {
    await _fbStore.collection('user').doc(objUser.uid).set(objUser.toJson());
  }

  static Future<UserEntity?> getUserInfor(String uid) async {
    final docRef = await _fbStore.collection('user').doc(uid).get();
    return docRef.data() !=null ? UserEntity.fromJson(docRef.data()!) : null;
  }
}