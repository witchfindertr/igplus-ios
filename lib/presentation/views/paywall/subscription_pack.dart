import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:igshark/presentation/blocs/paywall/cubit/paywall_cubit.dart';
import 'package:igshark/presentation/resources/colors_manager.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionPack extends StatefulWidget {
  SubscriptionPack(
      {Key? key, required this.title, required this.saveText, required this.monthlyPrice, required this.productId})
      : super(key: key);

  String title;
  String saveText;
  String monthlyPrice;
  String productId;

  @override
  State<SubscriptionPack> createState() => _SubscriptionPackState();
}

class _SubscriptionPackState extends State<SubscriptionPack> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          // call PaywallLoading state
          BlocProvider.of<PaywallCubit>(context).emit(PaywallLoading());
          try {
            final rs = await Purchases.purchaseProduct(widget.productId);
            inspect(rs);
          } catch (e) {
            debugPrint(e.toString());
            BlocProvider.of<PaywallCubit>(context).emit(PaywallLoaded());
          }
        },
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: ColorsManager.primaryColor),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title,
                          style: const TextStyle(
                            color: ColorsManager.textColor,
                            fontSize: 24.0,
                            fontFamily: 'Abel',
                            fontStyle: FontStyle.normal,
                          ),
                          textAlign: TextAlign.left),
                      Text(widget.saveText,
                          style: const TextStyle(
                            color: ColorsManager.secondarytextColor,
                            fontSize: 16.0,
                            fontFamily: 'Abel',
                            fontStyle: FontStyle.normal,
                          ),
                          textAlign: TextAlign.left),
                    ],
                  ),
                  Text(widget.monthlyPrice,
                      style: const TextStyle(
                        color: ColorsManager.primaryColor,
                        fontSize: 18.0,
                        fontFamily: 'Abel',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
