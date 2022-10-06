part of 'media_likers_cubit.dart';

abstract class MediaLikersState extends Equatable {
  const MediaLikersState();

  @override
  List<Object> get props => [];
}

class MediaLikersInitial extends MediaLikersState {}

class MediaLikersLoading extends MediaLikersState {}

class MediaLikersSuccess extends MediaLikersState {
  final List<MediaLiker> mediaLikers;
  final int pageKey;
  MediaLikersSuccess({required this.mediaLikers, required this.pageKey});
}

class MediaLikersFailure extends MediaLikersState {
  final String message;

  const MediaLikersFailure({required this.message});

  @override
  List<Object> get props => [message];
}
