import 'dart:async';
import 'dart:developer';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:igplus_ios/presentation/blocs/login/cubit/instagram_auth_cubit.dart';

import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InstagramLoginPage extends StatefulWidget {
  InstagramLoginPage({
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
    return SafeArea(
      child: Scaffold(
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
              // _cookieManager.clearCookies();
            }
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
              //"23689336944%3A7RknvrX3SdUpYB%3A7%3AAYfosXmPcAl9__jTr47HqVTK2gjTrqh5sa8rnvoY5g"

              GoRouter.of(context).pop();
              Map<String, String> headers = {
                'User-Agent': userAgent.replaceAll('"', '').trim(),
                'Cookie': 'sessionid=${sessionidCookies.value}',
                'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
                'Accept-Encoding': 'gzip, deflate, br',
                'Accept-Language': 'en-US,en;q=0.5',
                'Upgrade-Insecure-Requests': '1',
                'X-IG-App-ID': '936619743392459',
                'X-CSRFToken': csrftokenCookies?.value ?? ""
              };

              context.read<InstagramAuthCubit>().createOrUpdateInstagramInfo(
                    headers: headers,
                    igUserId: useridCookies.value,
                  );

              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) async {},
        ),
      ),
    );
  }
}
