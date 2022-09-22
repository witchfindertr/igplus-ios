import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/domain/entities/account_info.dart';
import 'package:igplus_ios/domain/entities/ig_headers.dart';
import 'package:dartz/dartz.dart';
import 'package:igplus_ios/domain/repositories/local/local_repository.dart';

class GetAccountInfoFromLocalUseCase {
  final LocalRepository localRepository;
  GetAccountInfoFromLocalUseCase({required this.localRepository});

  Future<Either<Failure, AccountInfo?>> execute() async {
    return localRepository.getCachedAccountInfo();
  }
}
