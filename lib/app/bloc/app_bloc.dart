import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:igshark/domain/entities/auth_user.dart';

import 'package:igshark/domain/repositories/auth/auth_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository authRepository;
  late final StreamSubscription authSubscription;
  AppBloc({
    required this.authRepository,
  }) : super(authRepository.currentAuthUser.isNotEmpty
            ? AppState.authenticated(authRepository.currentAuthUser)
            : const AppState.unauthenticated()) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);

    authSubscription = authRepository.authUser.listen((user) {
      add(AppUserChanged(user: user));
    });
  }

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    emit(event.user.isNotEmpty ? AppState.authenticated(event.user) : const AppState.unauthenticated());
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) async {
    unawaited(authRepository.logOut());
  }

  @override
  Future<void> close() {
    authSubscription.cancel();
    return super.close();
  }
}
