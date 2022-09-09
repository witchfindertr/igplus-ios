import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:igplus_ios/domain/usecases/get_friends_from_local_use_case.dart';

part 'friends_list_state.dart';

class FriendsListCubit extends Cubit<FriendsListState> {
  final GetFriendsFromLocalUseCase getFriendsFromLocal;
  FriendsListCubit({required this.getFriendsFromLocal}) : super(FriendsListInitial());

  void init() async {
    emit(FriendsListLoading());
    // get friends from local
    final failureOrFriends = await getFriendsFromLocal.execute(dataName: "followers");
    if (failureOrFriends == null || failureOrFriends.isLeft()) {
      emit(const FriendsListFailure(message: 'Failed to get friends'));
    } else {
      final friends = (failureOrFriends as Right).value;
      emit(FriendsListSuccess(friendsList: friends));
    }
  }
}
