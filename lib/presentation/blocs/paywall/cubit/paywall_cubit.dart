import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

part 'paywall_state.dart';

class PaywallCubit extends Cubit<PaywallState> {
  PaywallCubit() : super(PaywallInitial());

  // purchase product
  purchaseProduct(productId) async {
    emit(PaywallLoading());
    try {
      await Purchases.purchaseProduct(productId);
    } catch (e) {
      if (e.toString().contains('PURCHASE_CANCELLED')) {
        emit(const PaywallFailure(message: "Purchase was cancelled."));
      } else {
        emit(const PaywallFailure(message: "An unexpected system error occurred while processing this request."));
      }
    }

    emit(PaywallLoaded());
  }
}
