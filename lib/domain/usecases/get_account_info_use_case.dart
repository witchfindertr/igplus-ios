import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/domain/entities/account_info.dart';
import 'package:igplus_ios/domain/entities/ig_headers.dart';
import 'package:igplus_ios/domain/repositories/instagram/instagram_repository.dart';
import 'package:dartz/dartz.dart';

class GetAccountInfoUseCase {
  final InstagramRepository instagramRepository;
  GetAccountInfoUseCase({required this.instagramRepository});

  Future<Either<Failure, AccountInfo>> execute(
      {String? username, String? igUserId, required IgHeaders igHeaders}) async {
    return instagramRepository.getAccountInfo(username: username, igUserId: igUserId, igHeaders: igHeaders);
  }
}
