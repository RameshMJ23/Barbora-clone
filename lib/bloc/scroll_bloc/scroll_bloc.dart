
import 'package:flutter_bloc/flutter_bloc.dart';

enum ScrollEndPosition{
  leftEnd,
  center,
  rightEnd
}

class ScrollBloc extends Cubit<ScrollEndPosition>{

  ScrollBloc():super(ScrollEndPosition.leftEnd);

  reachedRightEnd(){
    emit(ScrollEndPosition.rightEnd);
  }

  reachedLeftEnd(){
    emit(ScrollEndPosition.leftEnd);
  }

  inCenter(){
    emit(ScrollEndPosition.center);
  }
}