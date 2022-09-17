import 'package:barboraapp/bloc/address_bloc/select_address_bloc/select_address_bloc.dart';
import 'package:barboraapp/bloc/booking_bloc/booking_bloc.dart';
import 'package:barboraapp/data/models/pick_up_location_model.dart';
import 'package:barboraapp/screeens/widgets/common_bookin_loading_screen.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/booking_bloc/booking_process_bloc/booking_process_bloc.dart';

class SelectLocationScreen extends StatelessWidget {

  final List<PickupLocationModel> lockerLocations = [
    PickupLocationModel(
      icon: Icons.map,
      locationName: "Pirkinių stotelė Ukmergės g. Circle K",
      locationAddress: "Ukmergės g. 231, 07156 Vilnius",
      value: 0
    ),
    PickupLocationModel(
      icon: Icons.map,
      locationName: "Pirkinių stotelė Geležinio Vilko g. Circle K",
      locationAddress: "Geležinio Vilko g. 39, 8104 Vilnius",
      value: 1
    ),
    PickupLocationModel(
      icon: Icons.map,
      locationName: "Pirkinių stotelė Ozo parkas",
      locationAddress: "J.Balčikonio g. 3, 08200 Vilnius",
      value: 2
    )
  ];

  final List<PickupLocationModel> inStoreLocations = [
    PickupLocationModel(
      icon: Icons.markunread_mailbox,
      locationName: "Alytaus Naujosios g. Express stotelė",
      locationAddress: "Naujoji g. 90-2, 62388 Alytus",
      value: 3
    ),
    PickupLocationModel(
      icon: Icons.markunread_mailbox,
      locationName: "Marijampolės Express stotelė",
      locationAddress: "V. Kudirkos g. 3, 68176 Marijampolė",
      value: 4
    ),
    PickupLocationModel(
      icon: Icons.markunread_mailbox,
      locationName: "Panevėžio Respublikos g. Express stotelė",
      locationAddress: "Respublikos g. 71, 35157 Panevėžys",
      value: 5
    ),
    PickupLocationModel(
      icon: Icons.markunread_mailbox,
      locationName: "Panevėžio Ukmergės g. Express stotelė",
      locationAddress: "J.Balčikonio g. 3, 08200 Vilnius",
      value: 6
    ),
    PickupLocationModel(
      icon: Icons.markunread_mailbox,
      locationName: "Pirkinių stotelė Ozo parkas",
      locationAddress: "Ukmergės g. 23, 35177 Panevėžys",
      value: 7
    ),
    PickupLocationModel(
      icon: Icons.markunread_mailbox,
      locationName: "Šiaulių Express stotelė",
      locationAddress: "Aido g. 8-1, 78322 Šiauliai",
      value: 8
    )
  ];


  final List<PickupLocationModel> driveInLocations = [
    PickupLocationModel(
      icon: Icons.car_rental,
      locationName: "Klaipėdos PC Akropolis Drive-in",
      locationAddress: "Taikos pr. 61, 91182 Klaipėda",
      value: 9
    ),
    PickupLocationModel(
      icon:  Icons.car_rental,
      locationName: "Vilniaus PC Akropolis Drive-in",
      locationAddress: "Ozo g. 25, 7150 Vilnius",
      value: 10
    ),
    PickupLocationModel(
      icon:  Icons.car_rental,
      locationName: "Vilniaus PC Ozas Drive-in",
      locationAddress: "Ozo g. 18, 8243 Vilnius",
      value: 11
    ),
    PickupLocationModel(
      icon:  Icons.car_rental,
      locationName: "Vilniaus Maxima Bazė Drive-in",
      locationAddress: "Savanorių pr. 247, 2300 Vilnius",
      value: 12
    ),
    PickupLocationModel(
      icon:  Icons.car_rental,
      locationName: "Kauno Maxima Bazė Drive-in",
      locationAddress: "Veiverių g. 150B, 46391 Kaunas",
      value: 13
    ),
    PickupLocationModel(
      icon:  Icons.car_rental,
      locationName: "Kauno Hyper Maxima Drive-in",
      locationAddress: "Savanorių pr. 255, 8243 Kaunas",
      value: 14
    ),
    PickupLocationModel(
      icon:  Icons.car_rental,
      locationName: "Kauno Pramonės pr. Maxima Drive-in",
      locationAddress: "Pramonės pr. 29, 51270 Kaunas",
      value: 15
    ),
    PickupLocationModel(
      icon:  Icons.car_rental,
      locationName: "Klaipėdos Taikos pr. Maxima Drive-in",
      locationAddress: "Taikos pr. 141, 94284 Klaipėda",
      value: 16
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Select location"),
          centerTitle: true,
          backgroundColor: const Color(0xffE32323),
          leading: getAppLeadingWidget(context),
        ),
        persistentFooterButtons: [
          SizedBox(
            width: double.infinity,
            child: BlocBuilder<SelectAddressBloc, int>(
              builder: (context, state){
                return MaterialButton(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: const Text(
                    "Select",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0
                    ),
                  ),
                  color: Colors.green,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))
                  ),
                  onPressed: (){
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
                    BlocProvider.of<BookingBloc>(context).changeToPickUpMyself();
                    BlocProvider.of<SelectAddressBloc>(context).savePickLocationIndex(state);
                  },
                );
              },
            ),
          )
        ],
      body: ListView(
        children: [
          _buildTitle("From grocery locker"),
          const Divider(thickness: 1.5,),
          _buildRadioOption(lockerLocations),
          _buildTitle("In store"),
          const Divider(thickness: 1.5,),
          _buildRadioOption(inStoreLocations),
          const Divider(thickness: 1.5,),
          _buildTitle("At drive-in"),
          const Divider(thickness: 1.5,),
          _buildRadioOption(driveInLocations)
        ],
      ),
    );
  }

  Widget _buildRadioOption(List<PickupLocationModel> list) => Column(
      children: list.map((location){
        return Column(
          children: [
            BlocBuilder<SelectAddressBloc, int>(
              builder: (context, state){
                return RadioListTile(
                  activeColor: Colors.green,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        child: Icon(
                          location.icon,
                          color: Colors.red,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              location.locationName,
                              style: const TextStyle(
                                fontSize: 16.0
                              ),
                            ),
                            Text(
                              location.locationAddress,
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  groupValue: state,
                  onChanged: (val){

                    BlocProvider.of<SelectAddressBloc>(context).changeAddress(val as int);
                  },
                  value: location.value,
                );
              },
            ),
            const Divider(thickness: 1.5,)
          ],
        );
      }).toList()
  );

  Widget _buildTitle(String title) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15.0,),
        Text(
          title,
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold
          ),
        )
      ],
    ),
  );
}
