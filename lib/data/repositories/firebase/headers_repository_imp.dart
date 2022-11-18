import 'package:igshark/data/sources/firebase/firebase_data_source.dart';
import 'package:igshark/domain/entities/ig_headers.dart';
import 'package:igshark/data/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:igshark/domain/repositories/firebase/headers_repository.dart';

import '../../../domain/entities/user.dart';
import '../../models/ig_headers_model.dart';
import '../../models/user_model.dart';

class HeadersRepositoryImp extends HeadersRepository {
  final FirebaseDataSource firebaseDataSource;

  HeadersRepositoryImp({required this.firebaseDataSource});
  @override
  Future<Either<Failure, IgHeaders>> getHeaders({User? currentUser, Map<String, dynamic>? headers}) async {
    try {
      // headers passed to the method are the headers fetched from instagram webview
      if (headers != null) {
        final IgHeaders igHeaders = IgHeadersModel.fromJson(headers).toEntity();
        return Right(igHeaders);
      }

      // user is logged in and currentUser passed to this method is not null
      if (currentUser != null) {
        final IgHeaders igHeaders = currentUser.igHeaders;
        return Right(igHeaders);
      }

      // currentUser is not passed to this method
      // try to get currentUser from Firestore
      final String? currentUserId = firebaseDataSource.getCurrentUserId();

      // user is not logged in get latest headers from Firestore
      if (currentUserId == null) {
        final IgHeadersModel igHeadersModel = await firebaseDataSource.getLatestHeaders();
        return Right(igHeadersModel.toEntity());
      } else {
        // if user is logged in, return user.igHeaders
        final UserModel userModel = await firebaseDataSource.getUser(userId: currentUserId);
        return Right(userModel.toEntity().igHeaders);
      }
    } catch (e) {
      return const Left(ServerFailure("Failed to get Latest Headers"));
    }
  }
}
