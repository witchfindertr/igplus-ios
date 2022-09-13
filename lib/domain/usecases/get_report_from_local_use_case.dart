import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:igplus_ios/domain/entities/report.dart';
import 'package:igplus_ios/domain/repositories/local/local_repository.dart';
import 'package:dartz/dartz.dart';

class GetReportFromLocalUseCase {
  final LocalRepository localRepository;
  GetReportFromLocalUseCase({required this.localRepository});

  Future<Either<Failure, Report?>> execute() async {
    return localRepository.getCachedReport();
  }
}
