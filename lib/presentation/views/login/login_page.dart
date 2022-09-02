import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: CupertinoButton(
          child: const Text("Login"),
          onPressed: () {
            GoRouter.of(context).pushNamed('instagram_login');
          },
        ),
      ),
    );
  }
}
