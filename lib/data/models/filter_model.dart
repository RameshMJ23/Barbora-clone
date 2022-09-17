
import 'package:barboraapp/bloc/filter_bloc/filter_bloc.dart';
import 'package:flutter/material.dart';

import '../../bloc/filter_bloc/filter_bloc_state.dart';

class FilterModel{

  String filterName;

  Widget widget;

  FilterScreenEnum screenEnum;

  FilterModel(this.filterName, this.widget, this.screenEnum);
}