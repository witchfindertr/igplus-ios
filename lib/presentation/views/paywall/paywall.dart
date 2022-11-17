import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:igshark/presentation/resources/colors_manager.dart';
import 'package:igshark/presentation/views/paywall/subscription_pack.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class Paywall extends StatelessWidget {
  const Paywall({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
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
              const SizedBox(height: 20),
              SubscriptionPack(
                title: '1 Month - 4.99€',
                saveText: 'Normal price',
                monthlyPrice: '4.99€/Month',
                productId: 'igshark_premium_4.99_month',
              ),
              SubscriptionPack(
                title: '6 Month - 9.99€',
                saveText: 'Save 60%',
                monthlyPrice: '1.66€/Month',
                productId: 'igshark_premium_9.99_6month',
              ),
              SubscriptionPack(
                title: '1 Year - 14.99€',
                saveText: 'Save 75%',
                monthlyPrice: '1.25€/Month',
                productId: 'igshark_premium_14.99_1year',
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
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
}
