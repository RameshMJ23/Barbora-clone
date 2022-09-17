

import 'package:flutter_bloc/flutter_bloc.dart';

class CarouselBloc extends Cubit<int>{

  CarouselBloc():super(0);

  changePage(int index){
    emit(index);
  }
}