import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:igplus_ios/app/app.dart';
import 'package:igplus_ios/presentation/blocs/home/cubit/report_cubit.dart';
import 'package:igplus_ios/presentation/blocs/login/cubit/instagram_auth_cubit.dart';
import 'app/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.signInAnonymously();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await di.init();
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider<InstagramAuthCubit>(
        create: (_) => di.sl<InstagramAuthCubit>(),
      ),
      BlocProvider<ReportCubit>(create: (_) => di.sl<ReportCubit>()),
    ], child: App()),
  );
}
