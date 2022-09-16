import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:igplus_ios/presentation/blocs/home/cubit/report_cubit.dart';
import 'package:igplus_ios/presentation/resources/colors_manager.dart';
import 'package:igplus_ios/presentation/resources/theme_manager.dart';
import 'package:igplus_ios/presentation/views/home/profile_manager.dart';
import 'package:igplus_ios/presentation/views/home/report_data.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      theme: appMaterialTheme(),
      home: Scaffold(
        body: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            backgroundColor: ColorsManager.appBack,
            middle: BlocBuilder<ReportCubit, ReportState>(
              builder: (context, state) {
                if (state is ReportSuccess || state is ReportAccountInfoLoaded) {
                  final String username;
                  if (state is ReportSuccess) {
                    username = state.accountInfo.username;
                  } else if (state is ReportAccountInfoLoaded) {
                    username = state.accountInfo.username;
                  } else {
                    username = "";
                  }
                  return ProfileManager(username: username);
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            trailing: BlocBuilder<ReportCubit, ReportState>(builder: (context, state) {
              return SizedBox(
                  width: 80.0,
                  child: (state is ReportSuccess)
                      ? AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: GestureDetector(
                            onTap: () => context.read<ReportCubit>().init(),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text("Refresh",
                                    style: TextStyle(fontSize: 12, color: ColorsManager.secondarytextColor)),
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
                            width: 80.0,
                            height: 4.0,
                            child: LinearProgressIndicator(
                              backgroundColor: ColorsManager.appBack,
                              valueColor: AlwaysStoppedAnimation<Color>(ColorsManager.cardBack),
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
        ),
      ),
    );
  }
}
