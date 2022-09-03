import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:igplus_ios/presentation/blocs/login/cubit/instagram_auth_cubit.dart';
import 'package:igplus_ios/presentation/resources/colors_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<InstagramAuthCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CupertinoPageScaffold(
        backgroundColor: ColorsManager.appBack,
        child: BlocConsumer<InstagramAuthCubit, InstagramAuthState>(
          listener: (context, state) {
            if (state is InstagramAuthSuccess) {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              GoRouter.of(context).goNamed('tabs');
            }
            if (state is InstagramAuthFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  ),
                );
              context.read<InstagramAuthCubit>().emitInstagramAuthInitialState();
            }
          },
          builder: (context, state) {
            if (state is InstagramAuthInProgress) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            if (state is InstagramAuthInitial) {
              return Center(
                child: CupertinoButton(
                  child: const Text("Login"),
                  onPressed: () {
                    GoRouter.of(context).pushNamed('instagram_login');
                  },
                ),
              );
            }
            return const Center(
              child: Text('Unknown'),
            );
          },
        ),
      ),
    );
  }
}
