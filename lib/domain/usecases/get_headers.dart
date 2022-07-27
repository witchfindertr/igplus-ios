import 'package:dartz/dartz.dart';
import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/domain/entities/ig_headers.dart';
import 'package:igplus_ios/domain/repositories/firebase/headers_repository.dart';

class GetHeaders {
  final HeadersRepository headersRepository;

  GetHeaders({required this.headersRepository});
  Future<Either<Failure, IgHeaders>> execute() async {
    return await headersRepository.getHeaders();
  }
}
