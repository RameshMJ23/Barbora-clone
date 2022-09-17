import 'dart:developer';

import 'package:barboraapp/bloc/address_bloc/select_address_bloc/select_address_bloc.dart';
import 'package:barboraapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:barboraapp/bloc/auth_bloc/auth_state.dart';
import 'package:barboraapp/bloc/booking_bloc/booking_bloc.dart';
import 'package:barboraapp/bloc/booking_bloc/booking_process_bloc/booking_process_bloc.dart';
import 'package:barboraapp/bloc/booking_bloc/booking_process_bloc/booking_process_state.dart';
import 'package:barboraapp/bloc/booking_bloc/booking_state.dart';
import 'package:barboraapp/bloc/booking_bloc/reservation_bloc/reservation_bloc.dart';
import 'package:barboraapp/bloc/scroll_bloc/scroll_bloc.dart';
import 'package:barboraapp/l10n/generated_files/app_localizations.dart';
import 'package:barboraapp/screeens/select_location_screen.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:barboraapp/screeens/widgets/unselected_booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/address_bloc/select_address_bloc/select_address_stream_bloc.dart';
import 'booking_widget.dart';

class WillPickupMySelf extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state){
        return state is WillPickUpMyselfState
         ? ListView(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 10.0, bottom: 10.0),
                    child: Text(
                      AppLocalizations.of(context)!.placeOfDelivery,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                        color: Colors.black87
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.shade100,
                          border: Border.all(color: Colors.grey)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Icon(Icons.home_outlined, color:  Colors.red, size: 35.0,),
                                ),
                                Expanded(
                                  child: BlocBuilder<SelectAddressBloc, int>(
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
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 20.0,
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                value: SelectAddressBloc(AddressBlocEnum.pickUpLocation),
                              ),
                              BlocProvider.value(
                                value: BlocProvider.of<BookingBloc>(context)
                              ),
                            ],
                            child: SelectLocationScreen()
                          )
                        )
                      );
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              decoration: getContainerDecoration(),
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      AppLocalizations.of(context)!.deliveryTime,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                        color: Colors.black87
                      ),
                    ),
                  ),
                  informationWidget(
                      content: "We don't do 60-minute deliveries at this time. The service is available every day from 10:00 to 20:00, except Sundays"
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) =>  BlocProvider.of<BookingProcessBloc>(context),
                        ),
                        BlocProvider(
                          create: (context) =>  ScrollBloc(),
                        ),
                      ],
                      child: BookingWidget(),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            )
          ],
        ) : state is BookingLoadingState
        ? const Center(
          child: CircularProgressIndicator(),
        )
        : UnselectedBookingScreen(onPressed:  (){
          Navigator.push(context, MaterialPageRoute(builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: SelectAddressBloc(AddressBlocEnum.pickUpLocation),
              ),
              BlocProvider.value(
                value: BookingBloc(),
              )
            ],
            child: SelectLocationScreen()
          )));
        });
      }
    );
  }
}
