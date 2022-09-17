
import 'dart:developer';

import 'package:bloc/bloc.dart';

class WebViewBloc extends Cubit<bool>{

  WebViewBloc():super(false);

  webViewLoaded(){
    log("From Bloc =========== WebView Loaded");
    Future.delayed(Duration(seconds: 1),(){
      emit(true);
    });
  }

  resetLoader(){
    log("From Bloc =========== WebView reseted");
    emit(false);
  }
}