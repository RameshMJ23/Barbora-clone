import 'package:barboraapp/bloc/address_bloc/select_address_bloc/select_address_stream_bloc.dart';
import 'package:barboraapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:barboraapp/bloc/auth_bloc/auth_state.dart';
import 'package:barboraapp/data/models/my_account_option_model.dart';
import 'package:barboraapp/screeens/my_aciu_card_screen.dart';
import 'package:barboraapp/screeens/my_coupons_screen.dart';
import 'package:barboraapp/screeens/order_address_screen.dart';
import 'package:barboraapp/screeens/payment_cards_screen.dart';
import 'package:barboraapp/screeens/saved_cart_screen.dart';
import 'package:barboraapp/screeens/user_account_screen.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MyAccountScreen extends StatefulWidget {
  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {

  late final List<MyAccountsOptionModel> _listOfOptions;

  @override
  void initState() {
    // TODO: implement initState
    _listOfOptions = [
      MyAccountsOptionModel(optionName: "User account", onTap: UserAccountScreen()),
      MyAccountsOptionModel(optionName: "My AČIŪ card", onTap: MyAciuCardScreen()),
      MyAccountsOptionModel(optionName: "Order delivery addresses", onTap: BlocProvider.value(
        value: SelectAddressStreamBloc((BlocProvider.of<AuthBloc>(context).state as UserState).uid),
        child: OrderAddressScreen(),
      )),
      MyAccountsOptionModel(optionName: "Select saved cart", onTap: SavedCartScreen()),
      MyAccountsOptionModel(optionName: "Payment cards", onTap: PaymentCardScreen()),
      MyAccountsOptionModel(optionName: "My coupons", onTap: MyCouponsScreen()),
    ];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text("My account"),
        centerTitle: true,
        backgroundColor: const Color(0xffE32323),
        leading: getAppLeadingWidget(context),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        child: ListView.builder(
          itemBuilder: (context, index){
            return Padding(
              child: Card(
                  child: ListTile(
                    title: Text(_listOfOptions[index].optionName),
                    trailing: const Icon(Icons.arrow_forward, color: Colors.black87,),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => _listOfOptions[index].onTap));
                    },
                  )
              ),
              padding: const EdgeInsets.symmetric(vertical: 2.0),
            );
          },
          itemCount: _listOfOptions.length,
        ),
      ),
    );
  }
}
