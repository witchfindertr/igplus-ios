part of 'app_bloc.dart';

// abstract class AppState extends Equatable {
//   const AppState();

//   @override
//   List<Object> get props => [];
// }

// class AppInitial extends AppState {}

enum AppStatus {
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {
  final AppStatus status;

  const AppState._({required this.status});

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  const AppState.authenticated(AuthUser user) : this._(status: AppStatus.authenticated);

  @override
  List<Object> get props => [status];
}
