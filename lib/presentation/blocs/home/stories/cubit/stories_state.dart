part of 'stories_cubit.dart';

abstract class StoriesState extends Equatable {
  const StoriesState();

  @override
  List<Object> get props => [];
}

class StoriesInitial extends StoriesState {}

class StoriesLoading extends StoriesState {}

class StoriesLoaded extends StoriesState {
  final List<Story?> stories;
  final StoryController controller;
  final StoryOwner storyOwner;

  const StoriesLoaded({required this.stories, required this.controller, required this.storyOwner});

  @override
  List<Object> get props => [stories, controller, storyOwner];
}

class StoriesFailure extends StoriesState {
  final Failure failure;

  const StoriesFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
