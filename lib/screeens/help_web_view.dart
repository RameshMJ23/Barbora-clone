
import 'dart:developer';
import 'dart:io';

import 'package:barboraapp/bloc/web_view_bloc/web_view_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  @override
  _WebViewScreenState createState() => _WebViewScreenState();

  String screenName;

  String url;

  WebViewScreen({required this.screenName, required this.url});
}

class _WebViewScreenState extends State<WebViewScreen> {


  late WebViewController _viewController;

  @override
  void initState() {
    // TODO: implement initState

    if (Platform.isAndroid) WebView.platform = AndroidWebView();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WebViewBloc, bool>(
      builder: (context, state){

        log(state.toString()+ "state value =========");
        return WillPopScope(
          onWillPop: onWillPopFunc,
          child: Scaffold(
            appBar: AppBar(
              title: Text(widget.screenName),
              centerTitle: true,
              backgroundColor: const Color(0xffE32323),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 20.0,),
                onPressed: (){
                 BlocProvider.of<WebViewBloc>(context).resetLoader();
                  Navigator.pop(context);
                },
              ),
            ),
            body: Stack(
              children: [
                WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: widget.url,
                  onWebViewCreated: (controller){
                    _viewController = controller;
                    BlocProvider.of<WebViewBloc>(context).webViewLoaded();
                    log("WebView created");
                  },
                  onPageFinished: (url){
                    log("WebView finished");

                  },
                  onPageStarted: (url){
                    log("WebView started");

                  },
                ),
                state == false
                  ? Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.white,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    ),
                  )
                  : const SizedBox(height: 0.0,width: 0.0,)
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> onWillPopFunc(){
    BlocProvider.of<WebViewBloc>(context).resetLoader();
    return Future.value(true);
  }
}

/*if(url.contains("https://barbora.lt/info/prekiu-pristatymas")){
                    _viewController.runJavascriptReturningResult(
                      "document.getElementsByTagName('header')[0].style.display='none'"
                    );
                    _viewController.runJavascript(
                        "document.getElementsByTagName('footer')[0].style.display='none'"
                    );
                }*/