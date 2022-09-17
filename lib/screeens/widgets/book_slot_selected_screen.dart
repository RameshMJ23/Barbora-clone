import 'package:barboraapp/bloc/booking_bloc/booking_bloc.dart';
import 'package:barboraapp/bloc/booking_bloc/booking_note_bloc/booking_note_bloc.dart';
import 'package:barboraapp/bloc/booking_bloc/booking_process_bloc/booking_process_bloc.dart';
import 'package:barboraapp/bloc/booking_bloc/booking_process_bloc/booking_process_state.dart';
import 'package:barboraapp/bloc/booking_bloc/booking_state.dart';
import 'package:barboraapp/bloc/booking_bloc/reservation_bloc/reservation_bloc.dart';
import 'package:barboraapp/bloc/booking_bloc/reservation_bloc/reservation_state.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:barboraapp/screeens/widgets/progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/address_bloc/select_address_bloc/select_address_bloc.dart';
import '../../bloc/address_bloc/select_address_bloc/select_address_stream_bloc.dart';
import '../../bloc/address_bloc/select_address_bloc/select_address_stream_state.dart';
import '../../data/shared_preference.dart';

class BookSlotSelectedScreen extends StatelessWidget {

  bool showProgressWidget;

  BookSlotSelectedScreen(this.showProgressWidget);

  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      //padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          showProgressWidget
            ? ProgressWidget(status: ProgressWidgetStatus.bookSlot)
            : const SizedBox(height: 0.0,width: 0.0,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 15.0),
                        child: Icon(Icons.home_outlined, color:  Colors.red, size: 28.0,),
                      ),
                      BlocBuilder<BookingBloc, BookingState>(
                        builder: (context, bookingState){
                          return bookingState is DeliverToHomeState
                          ? BlocBuilder<SelectAddressStreamBloc, SelectAddressStreamState>(
                            builder: (context, addressState){
                              return addressState is AddressState ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                                    child: Text(
                                      addressState.addressList[SharedPreference.getAddressIndex()].addressName,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                                    child: Text(addressState.addressList[SharedPreference.getAddressIndex()].address),
                                  )
                                ],
                              )
                              : const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ): BlocBuilder<SelectAddressBloc, int>(
                            builder: (context, savedIndex){
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                                    child: Text(
                                      getAllLocation()[savedIndex].locationName,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                                    child: Text(getAllLocation()[savedIndex].locationName, overflow: TextOverflow.ellipsis),
                                  )
                                ],
                              );
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 15.0),
                        child: Icon(Icons.access_time, color:  Colors.black87, size: 28.0,),
                      ),
                      BlocBuilder<BookingProcessBloc, BookingProcessState>(
                        builder: (context, state){

                          final bookedState = state as BookedState;

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.0),
                                child: Text(
                                  getDay(bookedState.dayValue),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2.0),
                                child: Text(getShowingTimingList()[bookedState.timeValue]),
                              )
                            ],
                          );
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                    child: SizedBox(
                      width: double.infinity,
                      child: MaterialButton(
                        elevation: 0.0,
                        focusElevation: 0.0,
                        highlightElevation: 0.0,
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side : BorderSide(color: Colors.grey.shade400)
                        ),
                        onPressed: (){
                          showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))
                              ),
                              context: context,
                              isScrollControlled: true,
                              useRootNavigator: true,
                              builder: (bottomSheetContext){
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    buildBottomSheetHeader("Note to courier", Icons.close, bottomSheetContext),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                                            child: TextField(
                                              controller: _noteController,
                                              decoration: InputDecoration(
                                                contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(5.0),
                                                    borderSide: BorderSide(color: Colors.grey.shade400)
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(5.0),
                                                    borderSide: BorderSide(color: Colors.grey.shade400)
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(5.0),
                                                    borderSide: BorderSide(color: Colors.grey.shade800)
                                                ),
                                              ),
                                              cursorColor: Colors.grey.shade900,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                                            child: getConfirmationButton(
                                              buttonName: "Save",
                                              onPressed: (){
                                                Navigator.pop(bottomSheetContext);
                                                BlocProvider.of<BookingNoteBloc>(context).updateNote(_noteController.text);
                                              }
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              }
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              const Icon(Icons.edit),
                              Padding(
                                child: BlocBuilder<BookingNoteBloc, String>(
                                  builder: (context, state){
                                    return Text(
                                      state.isEmpty ? "Note to courier" : state,
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14.0
                                      ),
                                    );
                                  },
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              ),
                            ],
                          ),
                        ),
                        color: Colors.grey.shade200,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15.0)
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: BlocBuilder<BookingProcessBloc, BookingProcessState>(
                    builder: (context, state){
                      return getConfirmationButton(
                        buttonName: "Change time/location",
                        onPressed: (){
                          BlocProvider.of<BookingProcessBloc>(context).reBook(
                            (state as BookedState).dayValue,
                            (state as BookedState).timeValue
                          );
                        },
                        side: true,
                        buttonColor: Colors.transparent,
                        buttonNameColor: Colors.grey.shade800
                      );
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String getDay(int dayValue){
    DateTime dateTime = DateTime.now();

    switch(dayValue){
      case 1:
        return "Today";
      case 2:
        return "Tomorrow";
      case 3:
        return "Day after tomorrow";
      case 4:
        return getFullDayName(DateFormat("E").format(DateTime(dateTime.year, dateTime.month, dateTime.day + 3)).toString());
      case 5:
        return getFullDayName(DateFormat("E").format(DateTime(dateTime.year, dateTime.month, dateTime.day + 4)).toString());
      case 6:
        return getFullDayName(DateFormat("E").format(DateTime(dateTime.year, dateTime.month, dateTime.day + 5)).toString());
      case 7:
        return getFullDayName(DateFormat("E").format(DateTime(dateTime.year, dateTime.month, dateTime.day + 6)).toString());
      default:
        return "Today";
    }
  }

  String getFullDayName(String day){
    switch(day.toLowerCase()){
      case "mon":
        return "Monday";
      case "tue":
        return "Tuesday";
      case "wed":
        return "Wednesday";
      case "thu":
        return "Thursday";
      case "fri":
        return "Friday";
      case "sat":
        return "Saturday";
      case "sun":
        return "Sunday";
      default:
        return "Default day";
    }
  }
}
