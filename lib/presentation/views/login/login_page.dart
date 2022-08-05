import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:igplus_ios/app/extensions/media_query_values.dart';
import 'package:igplus_ios/presentation/blocs/cubit/instagram_auth_cubit.dart';
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
    return BlocListener<InstagramAuthCubit, InstagramAuthState>(
      listener: (context, state) {
        if (state is InstagramAuthSuccess) {
          GoRouter.of(context).goNamed('tabs');
        }
        if (state is InstagramAuthFailure) {
          CupertinoAlertDialog(
            title: const Text('Error'),
            content: Text(state.message),
            actions: [
              CupertinoButton(
                child: const Text('OK'),
                onPressed: () {
                  GoRouter.of(context).goNamed('login');
                },
              ),
            ],
          );
        }
      },
      child: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Login'),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: context.height * 0.3,
              child: Column(
                children: const [
                  SizedBox(height: 20),
                  Text('Insta Reports'),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Container(
              height: context.height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(height: 20),
                  BlocBuilder<InstagramAuthCubit, InstagramAuthState>(builder: (context, state) {
                    if (state is InstagramAuthInProgress) {
                      return Container(
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(2, 20, 2, 20),
                            child: const CupertinoActivityIndicator(
                              color: ColorsManager.primaryColor,
                            ),
                          ),
                        ),
                      );
                    }

                    if (state is InstagramAuthInitial) {
                      return Container(
                        height: context.height * 0.5,
                        width: context.width * 0.9,
                        child: CupertinoButton(
                          child: const Text("Login"),
                          onPressed: () {
                            GoRouter.of(context).pushNamed('instagram_login');
                          },
                        ),
                      );
                    }
                    return Container(
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(2, 20, 2, 20),
                          child: const CupertinoActivityIndicator(
                            color: ColorsManager.primaryColor,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
