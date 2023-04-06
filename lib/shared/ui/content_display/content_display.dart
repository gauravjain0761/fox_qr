import 'package:flutter/material.dart';
import 'package:fox/routes/arguments/index.dart';
import 'package:fox/shared/shared.dart';
import 'package:fox/themes/app_text.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContentScreen extends StatefulWidget {
  final ContentArgs data;

  const ContentScreen({super.key, required this.data});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  final _webViewController = WebViewController();

  @override
  void initState() {
    super.initState();

    _webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://flutter.dev'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppHeader(
        leftWidget: const AppBackButton(),
        isDrawerNeeded: false,
        title: widget.data.title,
      ),
      bottomNavigationBar: _renderCta(),
      body: SafeArea(
        child: GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 32.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBoxWithHeight(10),
                Text(
                  "Terms & Conditions",
                  style: AppText.text24w600.copyWith(
                    fontSize: 24.sp,
                  ),
                ),
                Expanded(
                  child: WebViewWidget(controller: _webViewController),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderCta() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 32.w),
      child: SizedBox(
        height: 60.h,
        child: AppButton(
          onClick: widget.data.onTap,
          label: 'Done',
          iconAlign: Alignment.centerRight,
          icon: AppImage(
            Images.arrowBackWhite,
            height: 16.h,
            width: 32.w,
          ),
        ),
      ),
    );
  }
}
