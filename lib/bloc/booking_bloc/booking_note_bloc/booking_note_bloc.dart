
import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class BookingNoteBloc extends HydratedCubit<String>{

  BookingNoteBloc():super("");

  updateNote(String note){
    emit(note);
  }

  @override
  Map<String, String> toJson(String state) {
    return {
      "note": state
    };
  }

  @override
  String fromJson(Map<String, dynamic> json) {
     return json['note'] as String;
  }


}