import 'package:igplus_ios/domain/repositories/local/local_repository.dart';

class ClearAllBoxesUseCase {
  final LocalRepository localRepository;
  ClearAllBoxesUseCase({required this.localRepository});

  // clear all boxes data from local
  Future<void> execute() async {
    return localRepository.clearAllBoxes();
  }
}
