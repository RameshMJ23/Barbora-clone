

import 'dart:developer';

import 'package:barboraapp/bloc/booking_bloc/booking_bloc.dart';
import 'package:barboraapp/bloc/booking_bloc/booking_process_bloc/booking_process_bloc.dart';
import 'package:barboraapp/bloc/booking_bloc/booking_process_bloc/booking_process_state.dart';
import 'package:barboraapp/bloc/booking_bloc/reservation_bloc/reservation_bloc.dart';
import 'package:barboraapp/bloc/booking_bloc/reservation_bloc/reservation_state.dart';
import 'package:barboraapp/bloc/scroll_bloc/scroll_bloc.dart';
import 'package:barboraapp/data/models/booking_model.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers.dart';


class BookingWidget extends StatefulWidget {
  @override
  _BookingWidgetState createState() => _BookingWidgetState();
}

class _BookingWidgetState extends State<BookingWidget> {
  late final ScrollController _headController;
  late final ScrollController _bodyController;


  DateTime dateTime = DateTime.now();

  final List<BookingModel> _firstRow = [
    BookingModel(dayValue: 1, timeValue: 1, isAvail: false),
    BookingModel(dayValue: 2, timeValue: 1, isAvail: true),
    BookingModel(dayValue: 3, timeValue: 1, isAvail: true),
    BookingModel(dayValue: 4, timeValue: 1, isAvail: true),
    BookingModel(dayValue: 5, timeValue: 1, isAvail: true),
    BookingModel(dayValue: 6, timeValue: 1, isAvail: true),
    BookingModel(dayValue: 7, timeValue: 1, isAvail: true),
  ];

  final List<BookingModel> _generalRow = [
    BookingModel(dayValue: 1, timeValue: 2, isAvail: true),
    BookingModel(dayValue: 2, timeValue: 2, isAvail: true),
    BookingModel(dayValue: 3, timeValue: 2, isAvail: true),
    BookingModel(dayValue: 4, timeValue: 2, isAvail: true),
    BookingModel(dayValue: 5, timeValue: 2, isAvail: true),
    BookingModel(dayValue: 6, timeValue: 2, isAvail: true),
    BookingModel(dayValue: 7, timeValue: 2, isAvail: true),
  ];

  @override
  void initState() {
    // TODO: implement initState
    _headController = ScrollController();
    _bodyController = ScrollController();

    _headController.addListener((){
      //_bodyController.jumpTo(_headController.offset);
      if(_headController.position.atEdge){
        if(_headController.position.userScrollDirection == ScrollDirection.reverse){
          BlocProvider.of<ScrollBloc>(context).reachedRightEnd();
        }else{
          BlocProvider.of<ScrollBloc>(context).reachedLeftEnd();
        }
      }else{
        BlocProvider.of<ScrollBloc>(context).inCenter();
      }
    });

   _bodyController.addListener(() {
      _headController.jumpTo(_bodyController.offset);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return StickyHeader(
        header: Row(
          children: [
            Row(
              children: [
                Container(
                  color: Colors.white,
                  child: Padding(
                    child: Column(
                      children: const [
                        Text("10 - 11", style: TextStyle(color: Colors.transparent),),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                child: Stack(
                  children: [
                    Center(
                      child: SingleChildScrollView(
                        //physics: ClampingScrollPhysics(),
                        controller: _headController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(7, (index) => Text("€0.00")).mapIndexed((index, content){
                            return Padding(
                              child: Column(
                                children: [
                                  Text(
                                    getDay(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + index)),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  Text(
                                    getDate(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + index)),
                                    style: TextStyle(
                                        color: Colors.grey.shade600
                                    ),
                                  )
                                ],
                              ),
                              padding: const EdgeInsets.only(left: 35.0, right: 30.5),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    BlocBuilder<ScrollBloc, ScrollEndPosition>(
                      builder: (context, state){
                        return (state == ScrollEndPosition.center || state == ScrollEndPosition.rightEnd) ?
                          const Positioned(
                            left: 10.0,
                            top: 6.0,
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 15.0,
                            ),
                          ): const SizedBox();
                      },
                    ),
                    BlocBuilder<ScrollBloc, ScrollEndPosition>(
                      builder: (context, state){
                        return (state == ScrollEndPosition.center || state == ScrollEndPosition.leftEnd) ?
                          const Positioned(
                            right: 10.0,
                            top: 6.0,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 15.0,
                            ),
                          ): const SizedBox();
                      },
                    ),

                  ],
                ),
                color: Colors.white,
              ),
            )
          ],
        ),
        content: Row(
          children: [
            Column(
              children: getTimingList().map((time){
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 5.0),
                  child: Text(
                    time,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500
                    ),
                  ),
                );
              }).toList(),
            ),
            BlocBuilder<BookingProcessBloc, BookingProcessState>(
              builder: (context, state){
                return Expanded(
                  child: SingleChildScrollView(
                    controller: _bodyController,
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        Row(
                          children: _firstRow.map((bookingData){
                            return _buildBookingButtons(bookingData, () {
                              if(state is ReBookState){
                                BlocProvider.of<BookingProcessBloc>(context).reBookNewVal(bookingData.dayValue, bookingData.timeValue);
                              }else{
                                BlocProvider.of<BookingProcessBloc>(context).changeReservation(bookingData.dayValue, bookingData.timeValue);
                              }
                            });
                          }).toList(),
                        ),
                        Row(
                          children: _generalRow.map((bookingData){
                            return _buildBookingButtons(bookingData, () {
                              if(state is ReBookState){
                                BlocProvider.of<BookingProcessBloc>(context).reBookNewVal(bookingData.dayValue, bookingData.timeValue);
                              }else{
                                BlocProvider.of<BookingProcessBloc>(context).changeReservation(bookingData.dayValue, bookingData.timeValue);
                              }

                            });
                          }).toList(),
                        ),
                        Row(
                          children: _generalRow.map((bookingData){
                            return _buildBookingButtons(
                                BookingModel(dayValue: bookingData.dayValue, timeValue: bookingData.timeValue + 1, isAvail: bookingData.isAvail), () {
                              if(state is ReBookState){
                                BlocProvider.of<BookingProcessBloc>(context).reBookNewVal(bookingData.dayValue, bookingData.timeValue + 1);
                              }else{
                                BlocProvider.of<BookingProcessBloc>(context).changeReservation(bookingData.dayValue, bookingData.timeValue + 1);
                              }

                            });
                          }).toList(),
                        ),
                        Row(
                          children: _generalRow.map((bookingData){
                            return _buildBookingButtons(
                                BookingModel(dayValue: bookingData.dayValue, timeValue: bookingData.timeValue + 2, isAvail: bookingData.isAvail), () {
                              if(state is ReBookState){
                                BlocProvider.of<BookingProcessBloc>(context).reBookNewVal(bookingData.dayValue, bookingData.timeValue + 2);
                              }else{
                                BlocProvider.of<BookingProcessBloc>(context).changeReservation(bookingData.dayValue, bookingData.timeValue + 2);
                              }

                            });
                          }).toList(),
                        ),
                        Row(
                          children: _generalRow.map((bookingData){
                            return _buildBookingButtons(
                                BookingModel(dayValue: bookingData.dayValue, timeValue: bookingData.timeValue + 3, isAvail: bookingData.isAvail), () {
                              if(state is ReBookState){
                                BlocProvider.of<BookingProcessBloc>(context).reBookNewVal(bookingData.dayValue, bookingData.timeValue  + 3);
                              }else{
                                BlocProvider.of<BookingProcessBloc>(context).changeReservation(bookingData.dayValue, bookingData.timeValue  + 3);
                              }

                            });
                          }).toList(),
                        ),
                        Row(
                          children: _generalRow.map((bookingData){
                            return _buildBookingButtons(
                                BookingModel(dayValue: bookingData.dayValue, timeValue: bookingData.timeValue + 4, isAvail: bookingData.isAvail), () {
                              if(state is ReBookState){
                                BlocProvider.of<BookingProcessBloc>(context).reBookNewVal(bookingData.dayValue, bookingData.timeValue + 4);
                              }else{
                                BlocProvider.of<BookingProcessBloc>(context).changeReservation(bookingData.dayValue, bookingData.timeValue + 4);
                              }

                            });
                          }).toList(),
                        ),
                        Row(
                          children: _generalRow.map((bookingData){
                            return _buildBookingButtons(
                                BookingModel(dayValue: bookingData.dayValue, timeValue: bookingData.timeValue + 5, isAvail: bookingData.isAvail), () {
                              if(state is ReBookState){
                                BlocProvider.of<BookingProcessBloc>(context).reBookNewVal(bookingData.dayValue, bookingData.timeValue + 5);
                              }else{
                                BlocProvider.of<BookingProcessBloc>(context).changeReservation(bookingData.dayValue, bookingData.timeValue + 5);
                              }

                            });
                          }).toList(),
                        ),
                        Row(
                          children: _generalRow.map((bookingData){
                            return _buildBookingButtons(
                                BookingModel(dayValue: bookingData.dayValue, timeValue: bookingData.timeValue + 6, isAvail: bookingData.isAvail), () {
                              if(state is ReBookState){
                                BlocProvider.of<BookingProcessBloc>(context).reBookNewVal(bookingData.dayValue, bookingData.timeValue + 6);
                              }else{
                                BlocProvider.of<BookingProcessBloc>(context).changeReservation(bookingData.dayValue, bookingData.timeValue + 6);
                              }

                            });
                          }).toList(),
                        ),
                        Row(
                          children: _generalRow.map((bookingData){
                            return _buildBookingButtons(
                                BookingModel(dayValue: bookingData.dayValue, timeValue: bookingData.timeValue + 7, isAvail: bookingData.isAvail), () {
                              if(state is ReBookState){
                                BlocProvider.of<BookingProcessBloc>(context).reBookNewVal(bookingData.dayValue, bookingData.timeValue + 7);
                              }else{
                                BlocProvider.of<BookingProcessBloc>(context).changeReservation(bookingData.dayValue, bookingData.timeValue + 7 );
                              }
                            });
                          }).toList(),
                        ),
                        Row(
                          children: _generalRow.map((bookingData){
                            return _buildBookingButtons(
                                BookingModel(dayValue: bookingData.dayValue, timeValue: bookingData.timeValue + 8, isAvail: bookingData.isAvail), () {

                              if(state is ReBookState){
                                BlocProvider.of<BookingProcessBloc>(context).reBookNewVal(bookingData.dayValue, bookingData.timeValue + 8);
                              }else{
                                BlocProvider.of<BookingProcessBloc>(context).changeReservation(bookingData.dayValue, bookingData.timeValue + 8);
                              }

                            });
                          }).toList(),
                        ),
                        Row(
                          children:_generalRow.map((bookingData){
                            return _buildBookingButtons(
                                BookingModel(dayValue: bookingData.dayValue, timeValue: bookingData.timeValue + 9, isAvail: bookingData.isAvail), () {
                              if(state is ReBookState){
                                BlocProvider.of<BookingProcessBloc>(context).reBookNewVal(bookingData.dayValue, bookingData.timeValue + 9 );
                              }else{
                                BlocProvider.of<BookingProcessBloc>(context).changeReservation(bookingData.dayValue, bookingData.timeValue + 9);
                              }
                            });
                          }).toList(),
                        ),
                        Row(
                          children: _generalRow.map((bookingData){
                            return _buildBookingButtons(
                                BookingModel(dayValue: bookingData.dayValue, timeValue: bookingData.timeValue + 10, isAvail: bookingData.isAvail), () {
                              if(state is ReBookState){
                                BlocProvider.of<BookingProcessBloc>(context).reBookNewVal(bookingData.dayValue, bookingData.timeValue + 10);
                              }else{
                                BlocProvider.of<BookingProcessBloc>(context).changeReservation(bookingData.dayValue, bookingData.timeValue + 10);
                              }
                            });
                          }).toList(),
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        )
    );
  }

  String getDay(DateTime dateTime){
    return DateFormat('E').format(dateTime).substring(0, 2);
  }

  String getDate(DateTime dateTime){
    if(dateTime.day.toString().length >= 2){
      return dateTime.day.toString();
    }else{
      return dateTime.day.toString().padLeft(2, "0");
    }
  }

  Widget _buildBookingButtons(BookingModel bookingModel, VoidCallback onPressed) => BlocBuilder<BookingProcessBloc, BookingProcessState>(
    builder: (context, state){

      final bookingState;

      if(state is ToBookState){
        bookingState = state;
      }else{
        bookingState = state as ReBookState;
      }
      
      bool isSelected = state is ToBookState
        ? (bookingState.timeValue == bookingModel.timeValue && bookingState.dayValue == bookingModel.dayValue)
        : (state is ReBookState)
        ? ((bookingState as ReBookState).newTimeVal == bookingModel.timeValue && (bookingState as ReBookState).newDayVal == bookingModel.dayValue)
        : false;

      bool drawBorder = state is ReBookState
        ? (bookingState.timeValue == bookingModel.timeValue && bookingState.dayValue == bookingModel.dayValue)
        : false;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3.0),
        child:  SizedBox(
          height: 45.0,
          width: 80.0,
          child: MaterialButton(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            elevation: 0.0,
            highlightElevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: drawBorder ? Colors.green : Colors.transparent)
            ),
            color: bookingModel.isAvail
                ? isSelected
                ? Colors.green
                : Colors.green.withOpacity(0.3)
                : Colors.red,
            onPressed: onPressed,
            child: Center(
              child: Text(
                bookingModel.isAvail ? "€0.00" : "Not available",
                style:  TextStyle(
                    color: (!bookingModel.isAvail || isSelected)
                        ? Colors.white : Colors.green,
                    fontWeight: bookingModel.isAvail ? FontWeight.w600 : FontWeight.normal,
                    fontSize: 14.0
                ),
              ),
            ),
          ),
        ),
      );
    },
  );

  @override
  void dispose() {
    // TODO: implement dispose
    _headController.dispose();
    _bodyController.dispose();
    super.dispose();
  }
}
