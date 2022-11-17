import 'package:igshark/data/failure.dart';
import 'package:igshark/domain/entities/account_info.dart';
import 'package:igshark/domain/entities/ig_headers.dart';
import 'package:dartz/dartz.dart';
import 'package:igshark/domain/repositories/local/local_repository.dart';

class GetAccountInfoFromLocalUseCase {
  final LocalRepository localRepository;
  GetAccountInfoFromLocalUseCase({required this.localRepository});

  Future<Either<Failure, AccountInfo?>> execute() async {
    return localRepository.getCachedAccountInfo();
  }
}
