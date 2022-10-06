import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:igplus_ios/domain/usecases/follow_user_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_friends_from_local_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_user_use_case.dart';
import 'package:igplus_ios/domain/usecases/unfollow_user_use_case%20copy.dart';

part 'friends_list_state.dart';

class FriendsListCubit extends Cubit<FriendsListState> {
  final GetFriendsFromLocalUseCase getFriendsFromLocal;
  final FollowUserUseCase followUserUseCase;
  final UnfollowUserUseCase unfollowUserUseCase;
  final GetUserUseCase getUser;
  FriendsListCubit(
      {required this.getFriendsFromLocal,
      required this.followUserUseCase,
      required this.getUser,
      required this.unfollowUserUseCase})
      : super(FriendsListInitial());

  Future<List<Friend>?> getFriendsList(
      {required String boxKey, required int pageKey, required int pageSize, String? searchTerm}) async {
    final failureOrFriends =
        await getFriendsFromLocal.execute(boxKey: boxKey, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm);
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

  // follow user
  Future<bool> followUser({required int userId}) async {
    final failureOrCurrentUser = await getUser.execute();
    if (failureOrCurrentUser.isLeft()) {
      return false;
    } else {
      final currentUser = (failureOrCurrentUser as Right).value;
      final failureOrSuccess = await followUserUseCase.execute(userId: userId, igHeaders: currentUser.igHeaders);

      if (failureOrSuccess.isLeft()) {
        return false;
      } else {
        return true;
      }
    }
  }

  // unfollow user
  Future<bool> unfollowUser({required int userId}) async {
    final failureOrCurrentUser = await getUser.execute();
    if (failureOrCurrentUser.isLeft()) {
      return false;
    } else {
      final currentUser = (failureOrCurrentUser as Right).value;
      final failureOrSuccess = await unfollowUserUseCase.execute(userId: userId, igHeaders: currentUser.igHeaders);

      if (failureOrSuccess.isLeft()) {
        return false;
      } else {
        return true;
      }
    }
  }
}
