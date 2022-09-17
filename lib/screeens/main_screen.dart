
import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:barboraapp/bloc/booking_bloc/booking_process_bloc/booking_process_bloc.dart';
import 'package:barboraapp/bloc/bottom_nav_bloc/bottom_nav_bloc.dart';
import 'package:barboraapp/bloc/cart_bloc/cart_bloc.dart';
import 'package:barboraapp/bloc/cart_bloc/cart_state.dart';
import 'package:barboraapp/bloc/internet_bloc/internet_bloc.dart';
import 'package:barboraapp/bloc/internet_bloc/internet_state.dart';
import 'package:barboraapp/bloc/timer_bloc/timer_bloc.dart';
import 'package:barboraapp/bloc/timer_bloc/timer_state.dart';
import 'package:barboraapp/l10n/generated_files/app_localizations.dart';
import 'package:barboraapp/screeens/fonts/custom_icons_icons.dart';
import 'package:barboraapp/screeens/tab_navigator.dart';
import 'package:barboraapp/screeens/widgets/internet_loading_widget.dart';
import 'package:barboraapp/screeens/widgets/no_internet_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  //int _currentIndex = 0;

  //String currentPage = "home";

  List<String> pageKey = ["home", "products", "cart", "book", "more"];

  bool searchOn = true;

  final Map<String, GlobalKey<NavigatorState>> _navigatorKey = {
    'home': GlobalKey<NavigatorState>(),
    'products': GlobalKey<NavigatorState>(),
    'cart': GlobalKey<NavigatorState>(),
    'book': GlobalKey<NavigatorState>(),
    'more': GlobalKey<NavigatorState>(),
  };

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<BottomNavBloc, int>(
      builder: (context, state){
        return BlocBuilder<InternetBloc, InternetState>(
          builder: (context, internetState){
            return (internetState is YesInternetState) ? WillPopScope(
              onWillPop: () async{
                if(!await _navigatorKey[pageKey[state]]!.currentState!.maybePop()){
                  showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          content: const Text("Do you want to close the app"),
                          actions: [
                            TextButton(
                                onPressed: (){
                                  SystemNavigator.pop();
                                },
                                child: const Text("Yes")
                            ),
                            TextButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: const Text("No")
                            )
                          ],
                        );
                      }
                  );
                  return false;
                }else{
                  return false;
                }
              },
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  bottomNavigationBar: Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildBottomNavigationItem(
                          context,
                          Icons.access_time,
                          0,
                          AppLocalizations.of(context)!.homeBottomNav,
                          widget: Container(
                            //margin: const EdgeInsets.symmetric(vertical: 2.0),
                            height: 32.0,
                            width: 32.0,
                            child: SvgPicture.asset(
                              state == 0
                                ? "assets/B2_svg.svg"
                                : "assets/B2_svg_unselected.svg",
                              //height: 35.0,
                            ),
                          ),
                          padding: 0.0,
                          textPadding: 5.0
                        ),
                        _buildBottomNavigationItem(context, CustomIcons.search, 1, AppLocalizations.of(context)!.productBottomNav),
                        _buildBottomNavigationItem(
                            context,
                            CustomIcons.cart,
                            2,
                            AppLocalizations.of(context)!.cartBottomNav,
                            widget: BlocBuilder<CartBloc, CartState>(
                              builder: (context, cartState){
                                return (cartState is CartFetchedState && cartState.cartProducts.isNotEmpty)
                                  ? Badge(
                                    badgeContent: Text(
                                      "€" + BlocProvider.of<CartBloc>(context).finalPrice(cartState.cartProducts),
                                      style: const TextStyle(fontSize: 9.0, color: Colors.white)
                                    ),
                                    // alignment: Alignment.topRight,
                                    borderRadius: BorderRadius.circular(5.0),
                                    padding: const EdgeInsets.all(2.0),
                                    shape: BadgeShape.square,
                                    position: BadgePosition.topEnd(top: -2.0, end: -25.0),
                                    child: Icon(
                                      CustomIcons.cart,
                                      size: 28.0,
                                      color: state == 2 ? Colors.black87 : Colors.grey.shade500
                                    ),
                                  )
                                  : Icon(
                                    CustomIcons.cart,
                                    size: 28.0,
                                    color: state == 2 ? Colors.black87 : Colors.grey.shade500
                                  );
                              },
                            )
                        ),
                        BlocBuilder<TimerBloc, TimerState>(
                          builder: (context, timerState){

                            log("From timer Blocbuilder : ${timerState.time}");
                            return _buildBottomNavigationItem(
                                context,
                                CustomIcons.calendar,
                                3,
                                timerState.time.isEmpty ? AppLocalizations.of(context)!.bookBottomNav :  AppLocalizations.of(context)!.booked,
                                widget: timerState.time.isEmpty
                                  ? Icon(
                                    CustomIcons.calendar,
                                    size: 28.0,
                                    color: state == 3 ? Colors.black87 : Colors.grey.shade500,
                                ): Container(
                                  //margin: const EdgeInsets.symmetric(vertical: 5.0),
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                                  decoration: BoxDecoration(
                                      color: timerState.lastMinutes ? Colors.red.shade200 : Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(15.0)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 2.0),
                                        child: Icon(
                                          Icons.calendar_today,
                                          size: 14.0,
                                        ),
                                      ),
                                      BlocListener<TimerBloc, TimerState>(
                                        child: Text(
                                          timerState.time,
                                          style: const TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w600
                                          ),
                                        ),
                                        listener: (context, timerListenerState){
                                          log("From timer state listener" + timerListenerState.isFinished.toString());
                                          if(timerListenerState.isFinished){
                                            log("From timer state listener" + timerListenerState.isFinished.toString());
                                            BlocProvider.of<BookingProcessBloc>(context).changeReservation(0, 0);
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              width: 4.4
                            );
                          },
                        ),
                        _buildBottomNavigationItem(
                          context,
                          Icons.more_horiz, 4,  AppLocalizations.of(context)!.moreBottomNav
                        )
                      ],
                    ),
                    //height: 60.0,
                  ),
                  body: TabNavigator(
                    navigatorKey: _navigatorKey[pageKey[state]]!,
                    tabName: pageKey[state],
                  )
              ),
            )
            : (state is InternetState)
            ? InternetLoadingWidget()
            : NoInternetScreen();
          },
        );
      },
    );
  }

  _buildBottomNavigationItem(
      BuildContext context,
      IconData icon,
      int value,
      String tabName,{
      Widget? widget,
      double padding = 2.0,
      double textPadding = 0.0,
      double width = 6.6
    }
  ) => BlocBuilder<BottomNavBloc, int>(
    builder: (context, state){
      return GestureDetector(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / width,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: padding),
            child:  Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  child: widget ?? Icon(icon, size: 28.0, color: state == value ? Colors.black87 : Colors.grey.shade500,),
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: textPadding),
                  child: Text(
                    tabName,
                    style: TextStyle(
                      fontWeight: state == value ? FontWeight.w600 : FontWeight.w400,
                      fontSize: 11.0,
                      color: state == value ? Colors.black87 : Colors.grey.shade500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: (){
          BlocProvider.of<BottomNavBloc>(context).changeBottomNavIndex(value);
        },
      );
    },
  );

  Future<bool> willPopFunc(){
    if(searchOn){
      setState(() {
        searchOn = false;
      });
      return Future.value(false);
    }else{
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              content: const Text("Do you want to close the app"),
              actions: [
                TextButton(
                  onPressed: (){
                    SystemNavigator.pop();
                  },
                  child: const Text("Yes")
                ),
                TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Text("No")
                )
              ],
            );
          }
      );

      return Future.value(false);

    }
  }
}