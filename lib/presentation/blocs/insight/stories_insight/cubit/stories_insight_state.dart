part of 'stories_insight_cubit.dart';

abstract class StoriesInsightState extends Equatable {
  const StoriesInsightState();

  @override
  List<Object> get props => [];
}

class StoriesListInitial extends StoriesInsightState {}

class StoriesListLoading extends StoriesInsightState {}

class StoriesListFailure extends StoriesInsightState {
  final String message;

  const StoriesListFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class StoriesInsightSuccess extends StoriesInsightState {
  final List<Story> storiesList;
  final int pageKey;

  const StoriesInsightSuccess({
    required this.storiesList,
    required this.pageKey,
  });

  @override
  List<Object> get props => [storiesList, pageKey];
}
