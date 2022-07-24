import 'dart:async';
import 'dart:developer';

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InstagramLoginPage extends StatefulWidget {
  const InstagramLoginPage({
    Key? key,
    this.updateInstagramAccount = false,
  }) : super(key: key);

  final bool updateInstagramAccount;

  @override
  State<InstagramLoginPage> createState() => _InstagramLoginPageState();
}

class _InstagramLoginPageState extends State<InstagramLoginPage> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  final WebviewCookieManager _cookieManager = WebviewCookieManager();

  Cookie? findCookie({required String name, required List<Cookie> cookies}) {
    for (final cookie in cookies) {
      if (cookie.name == name) {
        return cookie;
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: "https://www.instagram.com/accounts/login",
        javascriptMode: JavascriptMode.unrestricted,
        initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
          if (widget.updateInstagramAccount == true) {
            webViewController.clearCache();
            final cookieManager = CookieManager();
            cookieManager.clearCookies();
          }
          inspect(widget.updateInstagramAccount);
        },
        onProgress: (int progress) {},
        navigationDelegate: (NavigationRequest request) async {
          final controller = await _controller.future;
          final userAgent = await controller.runJavascriptReturningResult('navigator.userAgent');
          final cookies = await _cookieManager.getCookies('https://www.instagram.com/');

          final Cookie? sessionidCookies = findCookie(name: "sessionid", cookies: cookies);
          final useridCookies = findCookie(name: "ds_user_id", cookies: cookies);
          final Cookie? csrftokenCookies = findCookie(name: "csrftoken", cookies: cookies);

          if (sessionidCookies != null && useridCookies != null && mounted) {
            GoRouter.of(context).pop();
            // context.read<InstagramAuthCubit>()
            //   ..submiteInstagramAuthHeader(
            //     cookies: cookies,
            //     userAgent: userAgent,
            //     igUserId: useridCookies.value,
            //     sessionid: sessionidCookies.value,
            //     csrftoken: csrftokenCookies?.value,
            //   );

            print(
                "cookies: $cookies | userAgent: $userAgent | igUserId: ${useridCookies.value} | sessionid: ${sessionidCookies.value}");

            return NavigationDecision.prevent;
          }

          return NavigationDecision.navigate;
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) async {},
      ),
    );
  }
}
