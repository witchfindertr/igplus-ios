import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:igshark/app/utils/cache_client.dart';

import '../../../data/failure.dart';
import '../../../data/sources/firebase/firebase_data_source.dart';
import '../../entities/auth_user.dart';

extension on firebase_auth.User {
  AuthUser get toAuthUser {
    return AuthUser(
      id: uid,
    );
  }
}

abstract class AuthRepository {
  // Future<Either<Failure, Unit>> login();
  Future<Either<Failure, Unit>> loginWithCustomToken({required String uid});
  Stream<AuthUser> get authUser;

  AuthUser get currentAuthUser;

  Future<Unit> logOut();
}

// AuthRepositoryImp is a concrete implementation of AuthRepository
class AuthRepositoryImp implements AuthRepository {
  final FirebaseDataSource firebaseDataSource;
  final CacheClient _cache;

  AuthRepositoryImp({required this.firebaseDataSource, CacheClient? cache}) : _cache = cache ?? CacheClient();

  static const userCacheKey = '__user_cache_key__';

  @override
  Future<Either<Failure, Unit>> loginWithCustomToken({required String uid}) async {
    try {
      final String customToken = await firebaseDataSource.getCustomToken(uid: uid);

      final result = await firebaseDataSource.loginWithCustomToken(customToken: customToken);

      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Stream<AuthUser> get authUser {
    return firebaseDataSource.authStateChange.map((firebaseUser) {
      if (firebaseUser == null) {
        return AuthUser.empty;
      } else {
        final authUser = firebaseUser.toAuthUser;
        _cache.write(key: userCacheKey, value: authUser);
        return AuthUser(id: firebaseUser.uid);
      }
    });
  }

  @override
  AuthUser get currentAuthUser => _cache.read<AuthUser>(key: userCacheKey) ?? AuthUser.empty;

  @override
  Future<Unit> logOut() async {
    await firebaseDataSource.logout();
    return unit;
  }
}
