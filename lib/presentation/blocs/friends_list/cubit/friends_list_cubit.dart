import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:igplus_ios/domain/usecases/get_friends_from_local_use_case.dart';

part 'friends_list_state.dart';

class FriendsListCubit extends Cubit<FriendsListState> {
  final GetFriendsFromLocalUseCase getFriendsFromLocal;
  FriendsListCubit({required this.getFriendsFromLocal}) : super(FriendsListInitial());

  // void init({required String dataName, required int pageKey, required int pageSize, String? searchTerm}) async {
  //   emit(FriendsListLoading());
  //   // get friends from local
  //   final failureOrFriends = await getFriendsFromLocal.execute(
  //       dataName: dataName, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm);
  //   if (failureOrFriends == null || failureOrFriends.isLeft()) {
  //     emit(const FriendsListFailure(message: 'Failed to get friends'));
  //   } else {
  //     final friends = (failureOrFriends as Right).value;
  //     if (friends != null) {
  //       emit(FriendsListSuccess(friendsList: friends, pageKey: pageKey));
  //     } else {
  //       emit(const FriendsListFailure(message: 'No friend to show!'));
  //     }
  //   }
  // }

  Future<List<Friend>?> getFriendsList(
      {required String dataName, required int pageKey, required int pageSize, String? searchTerm}) async {
    final failureOrFriends = await getFriendsFromLocal.execute(
        dataName: dataName, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm);
    if (failureOrFriends == null || failureOrFriends.isLeft()) {
      emit(const FriendsListFailure(message: 'Failed to get friends'));
      return null;
    } else {
      final friends = (failureOrFriends as Right).value;
      if (friends != null) {
        return friends;
      } else {
        return null;
      }
    }
  }
}
