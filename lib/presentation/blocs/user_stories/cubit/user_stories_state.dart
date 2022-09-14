part of 'user_stories_cubit.dart';

abstract class UserStoriesState extends Equatable {
  const UserStoriesState();

  @override
  List<Object> get props => [];
}

class UserStoriesInitial extends UserStoriesState {}

class UserStoriesLoading extends UserStoriesState {}

class UserStoriesLoaded extends UserStoriesState {
  final List<UserStory> userStories;

  const UserStoriesLoaded({required this.userStories});

  @override
  List<Object> get props => [userStories];
}
