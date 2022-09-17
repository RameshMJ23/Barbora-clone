

import 'package:barboraapp/bloc/lang_bloc/lang_state.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LangBloc extends Cubit<LangState>{

  LangBloc():super(LangState(radioOption: RadioOptions.English, locale: Locale("en")));

  changeLang(RadioOptions options){
    switch(options){
      case RadioOptions.Lietuvis:
        emit(LangState(radioOption: RadioOptions.Lietuvis, locale: Locale("lt")));
        break;
      case RadioOptions.English:
        emit(LangState(radioOption: RadioOptions.English, locale: Locale("en")));
        break;
      case RadioOptions.Russian:
        emit(LangState(radioOption: RadioOptions.Russian, locale: Locale("ru")));
        break;
    }
  }

  changeOption(RadioOptions options){
    switch(options){
      case RadioOptions.Lietuvis:
        emit(LangState(radioOption: RadioOptions.Lietuvis, locale: state.locale));
        break;
      case RadioOptions.English:
        emit(LangState(radioOption: RadioOptions.English, locale: state.locale));
        break;
      case RadioOptions.Russian:
        emit(LangState(radioOption: RadioOptions.Russian, locale: state.locale));
        break;
    }
  }
}