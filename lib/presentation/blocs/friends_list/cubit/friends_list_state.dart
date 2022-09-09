part of 'friends_list_cubit.dart';

abstract class FriendsListState extends Equatable {
  const FriendsListState();

  @override
  List<Object> get props => [];
}

class FriendsListInitial extends FriendsListState {}

class FriendsListLoading extends FriendsListState {}

class FriendsListFailure extends FriendsListState {
  final String message;

  const FriendsListFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class FriendsListSuccess extends FriendsListState {
  final List<Friend> friendsList;

  const FriendsListSuccess({
    required this.friendsList,
  });

  @override
  List<Object> get props => [friendsList];
}
