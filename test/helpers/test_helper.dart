import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:igshark/data/sources/firebase/firebase_data_source.dart';
import 'package:igshark/data/sources/instagram/instagram_data_source.dart';
import 'package:igshark/domain/repositories/auth/auth_repository.dart';
import 'package:igshark/domain/repositories/firebase/headers_repository.dart';
import 'package:igshark/domain/repositories/instagram/instagram_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  InstagramRepository,
  InstagramDataSource,
  HeadersRepository,
  FirebaseDataSource,
  AuthRepository,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient),
  MockSpec<FirebaseAuth>(as: #MockFirebaseAuth),
  MockSpec<FirebaseFirestore>(as: #MockFirebaseFirestore),
])
void main() {}
