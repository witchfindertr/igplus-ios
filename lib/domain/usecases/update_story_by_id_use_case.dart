import 'package:igshark/domain/repositories/local/local_repository.dart';

class UpdateStoryByIdUseCase {
  final LocalRepository localRepository;
  UpdateStoryByIdUseCase({required this.localRepository});

  Future<void> execute({required String boxKey, required String mediaId, int? viewersCount}) async {
    localRepository.updateStoryById(boxKey: boxKey, mediaId: mediaId, viewersCount: viewersCount);
  }
}
