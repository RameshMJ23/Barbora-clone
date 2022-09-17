import 'package:barboraapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:barboraapp/bloc/auth_bloc/auth_state.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/address_bloc/address_bloc.dart';
import '../bloc/address_bloc/select_address_bloc/select_address_bloc.dart';
import '../bloc/address_bloc/select_address_bloc/select_address_stream_bloc.dart';
import '../bloc/address_bloc/select_address_bloc/select_address_stream_state.dart';
import 'add_address_screen.dart';

class OrderAddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order delivery address"),
        centerTitle: true,
        backgroundColor: const Color(0xffE32323),
        leading: getAppLeadingWidget(context),
      ),
      persistentFooterButtons: [
        BlocBuilder<SelectAddressStreamBloc, SelectAddressStreamState>(
          builder: (context, state){
            return getConfirmationButton(
              buttonName: "Add new address",
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
              }: null,
            );
          },
        )
      ],
      body: Padding(
        child: BlocBuilder<SelectAddressStreamBloc, SelectAddressStreamState>(
          builder: (context, state){
            return state is AddressState
            ? ListView.separated(
              itemBuilder: (context, index){
                return ListTile(
                  visualDensity: const VisualDensity(vertical: -4.0),
                  leading: CircleAvatar(
                    child: Icon(
                      getIconList[state.addressList[index].addressIcon].icon,
                      color: Colors.white,
                    ),
                    backgroundColor: getIconList[state.addressList[index].addressIcon].color,
                  ),
                  title: Text(
                    state.addressList[index].addressName,
                    style: const TextStyle(
                        fontSize: 16.0
                    ),
                  ),
                  subtitle: Text(
                    state.addressList[index].address,
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 15.0,
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => MultiBlocProvider(
                        providers: [
                          BlocProvider.value(
                            value: AddressBloc(),
                          ),
                          BlocProvider.value(
                            value: SelectAddressStreamBloc((BlocProvider.of<AuthBloc>(context).state as UserState).uid),
                          )
                        ],
                      child: AddAddressScreen(addressListLength: state.addressList.length, update: true, addressModel: state.addressList[index],),
                    )));
                  },
                );
              },
              separatorBuilder: (context, index){
                return const Divider(thickness: 1.50,);
              },
              itemCount: state.addressList.length
            )
            : const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
      ),
    );
  }
}

/*
Column(
                  children: state.addressList.mapIndexed((index, address){
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                          child: Row(
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
                        ),
                        const Divider()
                      ],
                    );
                  }).toList(),
            )
 */
