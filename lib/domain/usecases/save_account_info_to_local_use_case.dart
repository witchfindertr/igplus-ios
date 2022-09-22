import 'package:igplus_ios/domain/entities/account_info.dart';
import 'package:igplus_ios/domain/repositories/local/local_repository.dart';

class CacheAccountInfoToLocalUseCase {
  final LocalRepository localRepository;
  CacheAccountInfoToLocalUseCase({required this.localRepository});

  Future<void> execute({required AccountInfo accountInfo}) async {
    return localRepository.cacheAccountInfo(accountInfo: accountInfo);
  }
}
