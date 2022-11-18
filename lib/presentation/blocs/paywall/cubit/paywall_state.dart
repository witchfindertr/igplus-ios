part of 'paywall_cubit.dart';

abstract class PaywallState extends Equatable {
  const PaywallState();

  @override
  List<Object> get props => [];
}

class PaywallInitial extends PaywallState {}

class PaywallLoading extends PaywallState {}

class PaywallLoaded extends PaywallState {}

class PaywallFailure extends PaywallState {
  const PaywallFailure({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
