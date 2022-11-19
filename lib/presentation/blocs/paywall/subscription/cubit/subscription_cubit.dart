import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

part 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  SubscriptionCubit() : super(SubscriptionInitial()) {
    getSubscriptionPack();
  }

  // get subscription pack list
  Future<void> getSubscriptionPack() async {
    emit(SubscriptionLoading());
    try {
      final offerings = await Purchases.getOfferings();
      if (offerings.current != null) {
        List<Package> packages = offerings.current!.availablePackages;
        inspect(packages);
        emit(SubscriptionLoaded(packages: packages));
      }
    } catch (e) {
      emit(SubscriptionFailure(e.toString()));
    }
  }

  // check if user is subscribed
  Future<bool> isSubscribed() async {
    final purchaserInfo = await Purchases.getCustomerInfo();
    return purchaserInfo.entitlements.all['premium']!.isActive;
  }

  // get purchaser info
  Future<void> getPurchaserInfo() async {
    emit(SubscriptionLoading());
    try {
      final purchaserInfo = await Purchases.getCustomerInfo();
      inspect(purchaserInfo);
      // emit(SubscriptionLoaded(subscriptionPack));
    } catch (e) {
      emit(SubscriptionFailure(e.toString()));
    }
  }
}
