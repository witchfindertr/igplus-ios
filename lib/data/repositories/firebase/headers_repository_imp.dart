import 'package:igplus_ios/data/sources/firebase/firebase_data_source.dart';
import 'package:igplus_ios/domain/entities/ig_headers.dart';
import 'package:igplus_ios/data/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:igplus_ios/domain/repositories/firebase/headers_repository.dart';

import '../../models/ig_headers_model.dart';

class HeadersRepositoryImp extends HeadersRepository {
  final FirebaseDataSource firebaseDataSource;

  HeadersRepositoryImp({required this.firebaseDataSource});
  @override
  Future<Either<Failure, IgHeaders>> getHeaders() async {
    // TODO: if user is logged in, return user.igHeaders

    // if user is not logged in, return latest headers
    try {
      final IgHeadersModel igHeadersModel = await firebaseDataSource.getLatestHeaders();

      return Right(igHeadersModel.toEntity());
    } catch (e) {
      return const Left(ServerFailure("Unknown error"));
    }
  }
}
