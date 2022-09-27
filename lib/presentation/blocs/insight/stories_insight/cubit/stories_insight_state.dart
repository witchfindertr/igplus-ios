part of 'stories_insight_cubit.dart';

abstract class StoriesListState extends Equatable {
  const StoriesListState();

  @override
  List<Object> get props => [];
}

class StoriesListInitial extends StoriesListState {}

class StoriesListLoading extends StoriesListState {}

class StoriesListFailure extends StoriesListState {
  final String message;

  const StoriesListFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class StoriesListSuccess extends StoriesListState {
  final List<Story> storiesList;
  final int pageKey;

  const StoriesListSuccess({
    required this.storiesList,
    required this.pageKey,
  });

  @override
  List<Object> get props => [storiesList, pageKey];
}
