import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../../failure.dart';
import '../../models/ig_headers_model.dart';
import '../../models/user_model.dart';

// extension on firebase_auth.User {
//   UserModel get toUserModel {
//     return UserModel(uid: uid, igUserId: uid, username: username, contactPhoneNumber: contactPhoneNumber, phoneCountryCode: phoneCountryCode, publicPhoneNumber: publicPhoneNumber, publicEmail: publicEmail, picture: picture, igHeaders: igHeaders, igAuth: igAuth, isActive: isActive, createdAt: createdAt, privateMessage: privateMessage)
//   }
// }

abstract class FirebaseDataSource {
  Stream<User?> get authStateChange;
  Future<UserModel> getUser({required String userId});
  Future<Unit> setUser({required String uid, required Map<String, dynamic> userData});

  Future<List<String>> getBannedUserIds();

  String getCurrentUserId();

  Future<IgHeadersModel> getLatestHeaders();
  // Future<Unit> login();

  //get custom token
  Future<String> getCustomToken({required String uid});

  // login to firebase with custom token
  Future<Unit> loginWithCustomToken({required String customToken});

  // logout from firebase
  Future<Unit> logout();
}

class FirebaseDataSourceImp extends FirebaseDataSource {
  final http.Client client;
  // final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  // final CollectionReference blackListCollection = FirebaseFirestore.instance.collection('blacklist');
  // final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  FirebaseDataSourceImp({
    required this.client,
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });
  @override
  Future<IgHeadersModel> getLatestHeaders() async {
    var uri = Uri.https('us-central1-igreports-96c3d.cloudfunctions.net', '/getNewestIgHeader');

    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> igHeaders = jsonDecode(response.body)["igHeaders"];

      IgHeadersModel igHeadersModel = IgHeadersModel.fromJson(igHeaders);

      return igHeadersModel;
    } else {
      throw const ServerFailure("Failed to get Latest Headers");
    }

    // } else {
    //   return {
    //     'User-Agent':
    //         'Mozilla/5.0 (Linux; Android 9; Redmi Note 8 Pro Build/PPR1.180610.011; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/101.0.4951.61 Mobile Safari/537.36',
    //     'Cookie': 'sessionid=2728720115%3Afux9lhzGjD8ESf%3A11',
    //     'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
    //     'Accept-Encoding': 'gzip, deflate, br',
    //     'Accept-Language': 'en-US,en;q=0.5',
    //     'Upgrade-Insecure-Requests': '1',
    //     'X-IG-App-ID': '936619743392459',
    //     'X-CSRFToken': '0fRjvDxa1IMmqLxokwSCERUV2savdxmc'
    //   };
    // }
  }

  // @override
  // Future<Unit> login() async {
  //   final FirebaseAuth auth = FirebaseAuth.instance;

  //   try {
  //     await auth.signInAnonymously();
  //     return unit;
  //   } catch (e) {
  //     throw const ServerFailure("Failed to login to Firebase");
  //   }
  // }

  @override
  Future<UserModel> getUser({required String userId}) async {
    final CollectionReference userCollection = firebaseFirestore.collection('users');

    var snap = await userCollection.doc(userId).get();
    if (snap.exists) {
      return UserModel.fromFirestore(snap);
    }
    throw const ServerFailure("Failed to get User from firestore");
  }

  @override
  String getCurrentUserId() {
    final currentUser = firebaseAuth.currentUser;

    if (currentUser != null) {
      return currentUser.uid;
    }

    throw const ServerFailure("Failed to get current user id");
  }

  @override
  Future<List<String>> getBannedUserIds() async {
    final CollectionReference blackListCollection = firebaseFirestore.collection('blacklist');

    List<String> bannedUserIds = [];
    QuerySnapshot blackListSnap = await blackListCollection.get();
    for (var doc in blackListSnap.docs) {
      bannedUserIds.add(doc.id);
    }
    return bannedUserIds;
  }

  @override
  Future<Unit> setUser({required String uid, required Map<String, dynamic> userData}) async {
    final CollectionReference userCollection = firebaseFirestore.collection('users');

    await userCollection.doc(uid).set(userData);

    return unit;
  }

  @override
  Future<Unit> loginWithCustomToken({required String customToken}) async {
    try {
      await firebaseAuth.signInWithCustomToken(customToken);
      return unit;
    } catch (e) {
      throw const ServerFailure("Failed to login to Firebase");
    }
  }

  @override
  Future<String> getCustomToken({required String uid}) async {
    //https://us-central1-igplusios.cloudfunctions.net/createFirebaseToken?uid=igUserId
    var uri = Uri.https('us-central1-igplusios.cloudfunctions.net', '/createFirebaseToken', {'uid': uid});

    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      String customToken = jsonDecode(response.body)["customToken"];
      return customToken;
    } else {
      throw const ServerFailure("Failed to login to Firebase with custom token");
    }
  }

  @override
  Future<Unit> logout() async {
    // logout from firebase
    await firebaseAuth.signOut();
    return unit;
  }

  @override
  Stream<User?> get authStateChange => firebaseAuth.authStateChanges();
}
