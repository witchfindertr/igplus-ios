part of 'media_commenters_cubit.dart';

abstract class MediaCommentersState extends Equatable {
  const MediaCommentersState();

  @override
  List<Object> get props => [];
}

class MediaCommentersInitial extends MediaCommentersState {}

class MediaCommentersLoading extends MediaCommentersState {}

class MediaCommentersSuccess extends MediaCommentersState {
  final List<MediaCommenter> mediaCommenters;
  final int pageKey;
  const MediaCommentersSuccess({required this.mediaCommenters, required this.pageKey});
}

class MediaCommentersFailure extends MediaCommentersState {
  final String message;

  const MediaCommentersFailure({required this.message});

  @override
  List<Object> get props => [message];
}
