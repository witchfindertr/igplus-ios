part of 'stories_cubit.dart';

abstract class StoriesState extends Equatable {
  const StoriesState();

  @override
  List<Object> get props => [];
}

class StoriesInitial extends StoriesState {}

class StoriesLoading extends StoriesState {}

class StoriesLoaded extends StoriesState {
  final List<StoryItem> storyItems;
  const StoriesLoaded({required this.storyItems});

  @override
  List<Object> get props => [storyItems];
}
