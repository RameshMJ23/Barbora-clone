
import 'dart:developer';

import 'package:barboraapp/bloc/address_bloc/address_bloc.dart';
import 'package:barboraapp/bloc/address_bloc/select_address_bloc/select_address_bloc.dart';
import 'package:barboraapp/bloc/address_bloc/select_address_bloc/select_address_stream_bloc.dart';
import 'package:barboraapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:barboraapp/bloc/auth_bloc/auth_state.dart';
import 'package:barboraapp/bloc/booking_bloc/booking_bloc.dart';
import 'package:barboraapp/bloc/booking_bloc/booking_note_bloc/booking_note_bloc.dart';
import 'package:barboraapp/bloc/booking_bloc/booking_process_bloc/booking_process_bloc.dart';
import 'package:barboraapp/bloc/booking_bloc/booking_process_bloc/booking_process_state.dart';
import 'package:barboraapp/bloc/booking_bloc/booking_state.dart';
import 'package:barboraapp/bloc/booking_bloc/reservation_bloc/reservation_bloc.dart';
import 'package:barboraapp/bloc/booking_bloc/reservation_bloc/reservation_state.dart';
import 'package:barboraapp/bloc/bottom_nav_bloc/bottom_nav_bloc.dart';
import 'package:barboraapp/bloc/cart_bloc/cart_bloc.dart';
import 'package:barboraapp/bloc/timer_bloc/timer_bloc.dart';
import 'package:barboraapp/l10n/generated_files/app_localizations.dart';
import 'package:barboraapp/screeens/fonts/custom_icons_icons.dart';
import 'package:barboraapp/screeens/payment_screen.dart';
import 'package:barboraapp/screeens/widgets/book_slot_selected_screen.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:barboraapp/screeens/widgets/deliver_to_home.dart';
import 'package:barboraapp/screeens/widgets/progress_widget.dart';
import 'package:barboraapp/screeens/widgets/will_pickup_myself.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart_bloc/cart_state.dart';

class BookScreenLoggedIn extends StatefulWidget {

  bool showProgressBar;
  int defaultTab;

  BookScreenLoggedIn(this.showProgressBar, {this.defaultTab = 0});

  @override
  _BookScreenLoggedInState createState() => _BookScreenLoggedInState();
}

class _BookScreenLoggedInState extends State<BookScreenLoggedIn> {

  late BookingBloc _bookingBloc;

  TabBar get _tabBar => TabBar(
    indicatorWeight: 3.5,
    indicatorColor: Colors.green,
    unselectedLabelColor: Colors.black87,
    labelColor: Colors.green,
    tabs: [
      Padding(
        padding: const EdgeInsets.only(top: 25.0, bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 8.0, left: 5.0),
              child: Icon(
                CustomIcons.car_side,
                size: 15.0,
              ),
            ),
            Text(
              AppLocalizations.of(context)!.deliverToHome,
              style: TextStyle(
                fontSize: AppLocalizations.of(context)!.localeName.toLowerCase() == "ru"?  11.0 : 12.0,
                fontWeight: FontWeight.bold
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 30.0, bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 8.0, left: 5.0),
              child: Icon(
                CustomIcons.shopping_bag,
                size: 15.0,
              ),
            ),
            Text(
              AppLocalizations.of(context)!.willPickupMyself,
              style: const TextStyle(
                fontSize: 11.5,
                letterSpacing: 0.0,
                wordSpacing: 0.0,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      )
    ],
  );

  @override
  void initState() {
    // TODO: implement initState
    _bookingBloc = BlocProvider.of<BookingBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<BookingProcessBloc, BookingProcessState>(
      builder: (context, state){

        return (state is ToBookState)
          ? BlocProvider.value(
            value: BlocProvider.of<BookingProcessBloc>(context),
            child: defaultBookingScreen(context, false),
          )
          : (state is BookedState)
          ? MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SelectAddressStreamBloc((BlocProvider.of<AuthBloc>(context).state as UserState).uid),
              ),
              BlocProvider(
                create: (context) => BookingNoteBloc(),
              )
            ],
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              appBar:  AppBar(
                title: Text(AppLocalizations.of(context)!.bookASlot),
                centerTitle: true,
                elevation: 0.0,
                backgroundColor: const Color(0xffE32323),
                leading: BlocBuilder<BottomNavBloc, int>(
                  builder: (context, bottomIndex){
                    return bottomIndex == 2
                      ? getAppLeadingWidget(context)
                      : const SizedBox(height: 0.0,width: 0.0,);
                  },
                ),
              ),
              persistentFooterButtons: [
                BlocBuilder<BottomNavBloc, int>(
                  builder: (context, navIndex){
                    if(navIndex == 3){
                      return BlocBuilder<CartBloc, CartState>(
                        builder: (context, cartState){
                          return (cartState is CartFetchedState && cartState.cartProducts.isNotEmpty)
                            ? MaterialButton(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                              onPressed: (){
                                BlocProvider.of<BottomNavBloc>(context).changeBottomNavIndex(2);
                              },
                              elevation: 0.0,
                              highlightElevation: 0.0,
                              color: const Color(0xffE32323),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("View cart", style: TextStyle(color: Colors.white, fontSize: 16.0),),
                                  Text(
                                    "€" + BlocProvider.of<CartBloc>(context).finalPrice(cartState.cartProducts),
                                    style: const TextStyle(color: Colors.white, fontSize: 16.0)
                                  )
                                ],
                              ),
                            )
                            : getConfirmationButton(
                              buttonName: "Choose products" ,
                              onPressed: (){
                                BlocProvider.of<BottomNavBloc>(context).changeBottomNavIndex(0);
                              },
                              buttonColor: const Color(0xffE32323)
                            );
                        },
                      );
                    }else{
                      return getConfirmationButton(
                        buttonName: "Select payment method",
                        buttonColor: const Color(0xffE32323),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PaymentScreen()
                            )
                          );
                        }
                      );
                    }
                  },
                )
              ],
              body: MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: BlocProvider.of<BookingProcessBloc>(context)
                  ),
                  BlocProvider.value(
                    value: BlocProvider.of<BookingBloc>(context)
                  ),
                  BlocProvider.value(
                    value: SelectAddressBloc(AddressBlocEnum.pickUpLocation)
                  )
                ],
                child: BookSlotSelectedScreen(widget.showProgressBar),
              )
            ),
          )
          : BlocProvider.value(
            value: BlocProvider.of<BookingProcessBloc>(context),
            child: defaultBookingScreen(context, true),
          );
      },
    );
  }

  Widget defaultBookingScreen(BuildContext context, bool rebook) => DefaultTabController(
      initialIndex: widget.defaultTab,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title:  Text(rebook ?  AppLocalizations.of(context)!.changeTimeLocation : AppLocalizations.of(context)!.bookASlot),
          centerTitle: true,
          backgroundColor: const Color(0xffE32323),
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, widget.showProgressBar ? 135.0 : 60.0),
            child: !widget.showProgressBar
                ? _getTabBar()
                : ColoredBox(
                  color: Colors.white,
                  child: Column(
                    children: [
                      ProgressWidget(status: ProgressWidgetStatus.bookSlot),
                      const Divider(thickness: 1.5,),
                      _getTabBar()
                    ],
                ),
            ),
          ),
          leading: BlocBuilder<BottomNavBloc, int>(
            builder: (context, bottomIndex){
              return bottomIndex == 2
                ? getAppLeadingWidget(context)
                : const SizedBox(height: 0.0,width: 0.0);
            },
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => SelectAddressStreamBloc(
                      (BlocProvider.of<AuthBloc>(context).state as UserState).uid
                    )
                  ),
                  BlocProvider.value(
                    value: _bookingBloc,
                  ),
                  BlocProvider.value(
                    value: BlocProvider.of<BookingProcessBloc>(context),
                  ),
                ],
                child: DeliverToHome()
            ),
            MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: _bookingBloc,
                  ),
                  BlocProvider.value(
                    value: BlocProvider.of<BookingProcessBloc>(context),
                  ),
                  BlocProvider.value(
                    value: SelectAddressBloc(AddressBlocEnum.pickUpLocation),
                  ),
                ],
                child:  WillPickupMySelf()
            )
          ],
        ),
        persistentFooterButtons: [
          BlocBuilder<BookingProcessBloc, BookingProcessState>(
            builder: (context, state){
              if(state is ReBookState){
                return (state.dayValue != state.newDayVal || state.timeValue != state.newTimeVal)
                 ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: getCancelButton(context, state.dayValue, state.timeValue),
                      ),
                    ),
                    Expanded(
                      child: getConfirmationButton(
                        buttonName: "Renew \n reservation",
                        onPressed: (){
                          BlocProvider.of<TimerBloc>(context).restartTimer();
                          BlocProvider.of<BookingProcessBloc>(context).changeToBooked(
                            state.newDayVal,
                            state.newTimeVal
                          );
                        },
                        vertPadding: 8.0,
                        fontSize: 14.0
                      ),
                    )
                  ],
                ) : getCancelButton(context, state.dayValue, state.timeValue);
              }else{
                return getConfirmationButton(
                    buttonName: AppLocalizations.of(context)!.select,
                    onPressed: (){
                      if((state as ToBookState).timeValue != 0 &&
                          (state as ToBookState).dayValue != 0){
                        BlocProvider.of<BookingProcessBloc>(context).changeToBooked(state.dayValue, state.timeValue);
                        BlocProvider.of<TimerBloc>(context).startTimer();
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          getSnackBar(context, "Choose your delivery time!")
                        );
                      }
                    },
                    buttonColor: Colors.red,
                );
              }
            },
          )
        ],
      )
  );

  getCancelButton(BuildContext context, int dayValue, int timeValue) => getConfirmationButton(
      buttonName: AppLocalizations.of(context)!.cancel,
      onPressed: (){
        BlocProvider.of<BookingProcessBloc>(context).changeToBooked(
          dayValue,
          timeValue
        );
      },
      buttonNameColor: Colors.grey.shade800,
      side: true,
      buttonColor: Colors.transparent
  );

  Widget _getTabBar() => ColoredBox(
    color: Colors.white,
    child: _tabBar,
  );

}
