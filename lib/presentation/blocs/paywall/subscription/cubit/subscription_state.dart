part of 'subscription_cubit.dart';

abstract class SubscriptionState extends Equatable {
  const SubscriptionState();

  @override
  List<Object> get props => [];
}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionLoading extends SubscriptionState {}

class SubscriptionLoaded extends SubscriptionState {
  const SubscriptionLoaded({required this.packages});

  final List<Package> packages;

  @override
  List<Object> get props => [packages];
}

class SubscriptionFailure extends SubscriptionState {
  const SubscriptionFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
