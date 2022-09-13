import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import 'package:igplus_ios/presentation/blocs/home/cubit/report_cubit.dart';
import 'package:igplus_ios/presentation/resources/colors_manager.dart';
import 'package:igplus_ios/presentation/views/global/info_card.dart';
import 'package:igplus_ios/presentation/views/global/section_title.dart';
import 'package:igplus_ios/presentation/views/home/report_data.dart';
import 'package:igplus_ios/presentation/views/home/stats/line-chart.dart';
import 'package:igplus_ios/presentation/views/home/stories/stories_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<ReportCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: ColorsManager.appBack,
        middle: Container(
          decoration: BoxDecoration(
            color: ColorsManager.cardBack,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                FontAwesomeIcons.user,
                color: ColorsManager.secondarytextColor,
                size: 16.0,
              ),
              SizedBox(width: 6.0),
              Text("Brahimaito", style: TextStyle(fontSize: 14, color: ColorsManager.textColor)),
              SizedBox(width: 4.0),
              Icon(
                FontAwesomeIcons.chevronDown,
                color: ColorsManager.secondarytextColor,
                size: 12.0,
              ),
            ],
          ),
        ),
        trailing: BlocBuilder<ReportCubit, ReportState>(builder: (context, state) {
          return Container(
              width: 80.0,
              child: (state is ReportSuccess)
                  ? AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: GestureDetector(
                        onTap: () => context.read<ReportCubit>().init(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text("Refresh", style: TextStyle(fontSize: 12, color: ColorsManager.secondarytextColor)),
                            SizedBox(width: 6.0),
                            Icon(
                              FontAwesomeIcons.arrowsRotate,
                              size: 20.0,
                              color: ColorsManager.textColor,
                            ),
                          ],
                        ),
                      ),
                    )
                  :
                  // mini loading
                  const AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(ColorsManager.textColor),
                        ),
                      ),
                    ));
        }),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
        child: BlocBuilder<ReportCubit, ReportState>(
          builder: (context, state) {
            if (state is ReportInProgress) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (state is ReportAccountInfoLoaded) {
              return ReportData(accountInfo: state.accountInfo);
            }
            if (state is ReportSuccess) {
              return ReportData(report: state.report, accountInfo: state.accountInfo);
            } else if (state is ReportFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    TextButton(
                      onPressed: () => context.read<ReportCubit>().init(),
                      child: const Text("Retry", style: TextStyle(color: ColorsManager.primaryColor)),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
