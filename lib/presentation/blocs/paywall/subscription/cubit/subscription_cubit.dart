import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:igshark/domain/entities/subscription_pack.dart';
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
        emit(SubscriptionLoaded(packages));
      }
    } catch (e) {
      emit(SubscriptionFailure(e.toString()));
    }
  }

  // make purchase
  Future<void> makePurchase(Package packageId) async {
    emit(SubscriptionLoading());
    try {
      final purchaserInfo = await Purchases.purchasePackage(packageId);
      inspect(purchaserInfo);
      // emit(SubscriptionLoaded(subscriptionPack));
    } catch (e) {
      emit(SubscriptionFailure(e.toString()));
    }
  }

  // restore purchase
  Future<void> restorePurchase() async {
    emit(SubscriptionLoading());
    try {
      final purchaserInfo = await Purchases.restorePurchases();
      inspect(purchaserInfo);
      // emit(SubscriptionLoaded(subscriptionPack));
    } catch (e) {
      emit(SubscriptionFailure(e.toString()));
    }
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
