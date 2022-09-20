import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String id;

  const AuthUser({
    required this.id,
  });

  /// Empty user which represents an unauthenticated user.
  static const empty = AuthUser(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == AuthUser.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != AuthUser.empty;

  @override
  List<Object?> get props => [id];
}
