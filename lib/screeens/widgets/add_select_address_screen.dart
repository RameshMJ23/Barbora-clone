
import 'dart:developer';

import 'package:barboraapp/bloc/address_bloc/address_bloc.dart';
import 'package:barboraapp/bloc/address_bloc/select_address_bloc/select_address_bloc.dart';
import 'package:barboraapp/bloc/address_bloc/select_address_bloc/select_address_stream_bloc.dart';
import 'package:barboraapp/bloc/address_bloc/select_address_bloc/select_address_stream_state.dart';
import 'package:barboraapp/bloc/booking_bloc/booking_bloc.dart';
import 'package:barboraapp/bloc/booking_bloc/booking_process_bloc/booking_process_bloc.dart';
import 'package:barboraapp/data/models/address_model.dart';
import 'package:barboraapp/screeens/add_address_screen.dart';
import 'package:barboraapp/screeens/widgets/common_bookin_loading_screen.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/auth_bloc/auth_state.dart';


class AddSelectAddressScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select/Add Address"),
        centerTitle: true,
        backgroundColor: const Color(0xffE32323),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20.0,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      persistentFooterButtons: [
        SizedBox(
          width: double.infinity,
          child: BlocBuilder<SelectAddressBloc, int>(
            builder:(blocContext, addressIndex){
              return getConfirmationButton(
                buttonName: "Select",
                onPressed: (){
                  BlocProvider.of<SelectAddressBloc>(context).saveIndex(addressIndex);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MultiBlocProvider(
                          providers: [
                            BlocProvider.value(
                              value: BlocProvider.of<BookingBloc>(context),
                            ),
                            BlocProvider.value(
                              value: BlocProvider.of<BookingProcessBloc>(context),
                            )
                          ],
                          child: CommonBookingLoadingScreen()
                        )
                      ),
                      (route) => route.isFirst
                  );
                  BlocProvider.of<BookingBloc>(context).changeToDeliverToHome();
                }
              );
            },
          ),
        )
      ],
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: [
            Padding(
              child: BlocBuilder<SelectAddressStreamBloc, SelectAddressStreamState>(
                builder: (context, state){
                  return state is AddressState
                  ? Column(
                    children: state.addressList.mapIndexed((index, address){
                      return BlocBuilder<SelectAddressBloc, int>(
                        builder: (context, radioState){
                          return RadioListTile(
                            activeColor: Colors.green,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,

                              children: [
                                Padding(
                                  child: CircleAvatar(
                                    child: Icon(
                                      getIconList[address.addressIcon].icon,
                                      color: Colors.white,
                                    ),
                                    backgroundColor: getIconList[address.addressIcon].color,
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        address.addressName,
                                        style: const TextStyle(
                                            fontSize: 16.0
                                        ),
                                      ),
                                      Text(
                                        address.address,
                                        style: const TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.grey
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            groupValue: radioState,
                            onChanged: (val){
                              BlocProvider.of<SelectAddressBloc>(context).changeAddress(val as int);
                            },
                            value: index,
                          );
                        },
                      );
                    }).toList(),
                  )
                  : const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
            ),
            const Divider(),
            Padding(
              child: BlocBuilder<SelectAddressStreamBloc, SelectAddressStreamState>(
                builder: (context, state){
                  return getConfirmationButton(
                    buttonName: "Add new address",
                    side: true,
                    buttonColor: Colors.transparent,
                    buttonNameColor: Colors.black87,
                    onPressed: (state is AddressState) ? (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => MultiBlocProvider(
                          providers: [
                            BlocProvider.value(
                              value: AddressBloc(),
                            ),
                            BlocProvider.value(
                              value: SelectAddressStreamBloc((BlocProvider.of<AuthBloc>(context).state as UserState).uid),
                            )
                          ],
                          child: AddAddressScreen(addressListLength: state.addressList.length)
                      )));
                    }
                    : null,
                  );
                },
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
            )
          ],
        ),
      ),
    );
  }
}


/*

Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child:  Row(
                          children: [
                            BlocBuilder<SelectAddressBloc, int>(
                              builder: (context, radioState){
                                return  Transform.scale(
                                  child: Radio(
                                    groupValue: radioState,
                                    value: index,
                                    onChanged: (val){
                                      log(val.toString());
                                      BlocProvider.of<SelectAddressBloc>(context).changeAddress(val as int);
                                    },
                                    activeColor: Colors.green,
                                  ),
                                  scale: 1.5,
                                );
                              },
                            ),
                            Padding(
                              child: CircleAvatar(
                                child: Icon(
                                  getIconList[address.addressIcon].icon,
                                  color: Colors.white,
                                ),
                                backgroundColor: getIconList[address.addressIcon].color,
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    address.addressName,
                                    style: const TextStyle(
                                        fontSize: 16.0
                                    ),
                                  ),
                                  Text(
                                    address.address,
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.grey
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
 */