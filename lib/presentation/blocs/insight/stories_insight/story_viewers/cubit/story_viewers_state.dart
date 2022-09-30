part of 'story_viewers_cubit.dart';

abstract class StoryViewersState extends Equatable {
  const StoryViewersState();

  @override
  List<Object> get props => [];
}

class StoryViewersInitial extends StoryViewersState {}

class StoryViewersLoading extends StoryViewersState {}

class StoryViewersFailure extends StoryViewersState {
  final String message;

  const StoryViewersFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class StoryViewersSuccess extends StoryViewersState {
  final List<StoryViewer> storyViewersList;
  final int pageKey;

  const StoryViewersSuccess({
    required this.storyViewersList,
    required this.pageKey,
  });

  @override
  List<Object> get props => [storyViewersList, pageKey];
}
