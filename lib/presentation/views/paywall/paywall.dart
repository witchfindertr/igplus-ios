import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:igshark/presentation/blocs/paywall/cubit/paywall_cubit.dart';
import 'package:igshark/presentation/blocs/paywall/subscription/cubit/subscription_cubit.dart';
import 'package:igshark/presentation/resources/colors_manager.dart';
import 'package:igshark/presentation/views/global/loading_indicator.dart';
import 'package:igshark/presentation/views/paywall/subscription_pack.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class Paywall extends StatelessWidget {
  const Paywall({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backGreenEffect.png'),
                fit: BoxFit.fitHeight,
                alignment: Alignment.centerRight,
              ),
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          "x",
                          style: TextStyle(
                            color: ColorsManager.secondarytextColor,
                            fontSize: 24.0,
                            fontFamily: 'Abel',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(width: 2.0),
                        Padding(
                          padding: EdgeInsets.only(top: 4.0),
                          child: Text(
                            "Close",
                            style: TextStyle(
                              color: ColorsManager.secondarytextColor,
                              fontSize: 14.0,
                              fontFamily: 'Abel',
                              fontStyle: FontStyle.normal,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  child: Text(
                    "Upgrade to Premium",
                    style: TextStyle(
                      color: ColorsManager.textColor,
                      fontSize: 38.0,
                      fontFamily: 'Abel',
                      fontStyle: FontStyle.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                  child: Text(
                    "Unlock all features",
                    style: TextStyle(
                      color: ColorsManager.secondarytextColor,
                      fontSize: 24.0,
                      fontFamily: 'Abel',
                      fontStyle: FontStyle.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                feature("Get access to our most exlusive data"),
                feature("Watch all instagram stories anonymously"),
                feature("Find out who unfollowed you"),
                feature("Discover your secret admires"),
                feature("And more..."),
                BlocBuilder<SubscriptionCubit, SubscriptionState>(
                  builder: (context, state) {
                    if (state is SubscriptionLoaded) {
                      List<Package> packages = state.packages;
                      List<Widget> subscriptionPacks = [const SizedBox(height: 20)];
                      String currency =
                          getCurrency(packages.first.storeProduct.priceString, packages.first.storeProduct.price);

                      for (var package in packages) {
                        final product = package.storeProduct;
                        int numberOfMonths = getMonthsNumber(package.identifier);
                        subscriptionPacks.add(
                          SubscriptionPack(
                            title: '${capitalize(package.packageType.name)} - ${product.priceString}',
                            saveText: getSaveText(numberOfMonths),
                            monthlyPrice: '$currency${getmonthlyPrice(numberOfMonths, product.price)}',
                            productId: product.identifier,
                          ),
                        );
                      }
                      return Column(children: subscriptionPacks);
                    } else if (state is SubscriptionFailure) {
                      return Text(state.message);
                    }

                    return const LoadingIndicator();
                  },
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 20.0),
                  child: Text(
                    "Your subscription will automatically renew unless auto-renew is turned off at least 24-hours before the end of the current period. Your account will be charged for renewal within 24-hours prior to the end of the current period, and identify the cost of the renewal. Subscriptions may be managed by you and auto-renewal may be turned off by going to your Account Settings after purchase.",
                    style: TextStyle(
                      color: ColorsManager.secondarytextColor,
                      fontSize: 14.0,
                      fontFamily: 'Abel',
                      fontStyle: FontStyle.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).goNamed('terms');
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                        child: Text(
                          "Terms of Service",
                          style: TextStyle(
                            color: ColorsManager.textColor,
                            fontSize: 14.0,
                            fontFamily: 'Abel',
                            fontStyle: FontStyle.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const Divider(
                      color: ColorsManager.textColor,
                      thickness: 2,
                      indent: 10,
                      endIndent: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).goNamed('privacy');
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                        child: Text(
                          "Privacy Policy",
                          style: TextStyle(
                            color: ColorsManager.textColor,
                            fontSize: 14.0,
                            fontFamily: 'Abel',
                            fontStyle: FontStyle.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          BlocBuilder<PaywallCubit, PaywallState>(
            builder: (context, state) {
              if (state is PaywallLoading) {
                return Center(
                  child: Container(
                    color: Colors.black.withOpacity(0.8),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: const Center(
                        child: LoadingIndicator(
                      width: 40.0,
                      height: 40.0,
                      radius: 14.0,
                    )),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ]),
      ),
    );
  }

  Padding feature(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(FontAwesomeIcons.circleCheck, color: ColorsManager.primaryColor),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
            child: Text(
              text,
              style: const TextStyle(
                color: ColorsManager.textColor,
                fontSize: 18.0,
                fontFamily: 'Abel',
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  String capitalize(String str) => str[0].toUpperCase() + str.substring(1);
  int getMonthsNumber(String identifier) {
    return (identifier.contains('rc_annual'))
        ? 12
        : (identifier.contains('rc_six_month'))
            ? 6
            : (identifier.contains('rc_three_month'))
                ? 3
                : (identifier.contains('rc_two_month'))
                    ? 2
                    : (identifier.contains('rc_monthly'))
                        ? 1
                        : (identifier.contains('rc_lifetime'))
                            ? 0
                            : (identifier.contains('rc_weekly'))
                                ? -1
                                : 1;
  }

  String getSaveText(int numberOfMonths) {
    return (numberOfMonths == 0)
        ? 'Best price'
        : (numberOfMonths == -1)
            ? 'Normal price'
            : (numberOfMonths == 1)
                ? 'Save 10%'
                : (numberOfMonths == 2)
                    ? 'Save 25%'
                    : (numberOfMonths == 3)
                        ? 'Save 40%'
                        : (numberOfMonths == 6)
                            ? 'Save 60%'
                            : (numberOfMonths == 12)
                                ? 'Save 75%'
                                : 'Normal price';
  }

  getmonthlyPrice(int numberOfMonths, double price) {
    String priceToShow = price.toStringAsFixed(2);
    String monthlyPriceString = (numberOfMonths == 0)
        ? 'No more payments'
        : (numberOfMonths == -1)
            ? '$priceToShow/Weekly'
            : '${(price / numberOfMonths).toStringAsFixed(2)}/Monthly';

    return monthlyPriceString;
  }

  String getCurrency(String priceString, double price) {
    String currency = price.toStringAsFixed(2);
    currency = priceString.replaceAll(currency, '');
    return currency;
  }
}
