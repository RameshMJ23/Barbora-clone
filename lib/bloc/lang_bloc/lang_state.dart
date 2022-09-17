
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class LangState extends Equatable{

  RadioOptions radioOption;

  Locale locale;

  LangState({required this.radioOption, required this.locale});

  @override
  // TODO: implement props
  List<Object?> get props => [radioOption, locale];
}