
import 'package:barboraapp/bloc/register_bloc/city_phone_bloc/city_phone_bloc.dart';
import 'package:barboraapp/bloc/register_bloc/register_bloc.dart';
import 'package:barboraapp/screeens/widgets/deliver_to_home.dart';
import 'package:barboraapp/screeens/widgets/log_in_screen.dart';
import 'package:barboraapp/screeens/widgets/register_screen.dart';
import 'package:barboraapp/screeens/widgets/will_pickup_myself.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookScreenAuth extends StatelessWidget {

  int startingIndex;

  BookScreenAuth({required this.startingIndex});

  TabBar get _tabBar => const TabBar(
    indicatorWeight: 3.5,
    indicatorColor: Colors.green,
    unselectedLabelColor: Colors.black54,
    labelColor: Colors.green,
    tabs: [
      Padding(
        padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
        child: Text(
          "REGISTER",
          style: TextStyle(
            fontSize: 15.0,
            //color: Colors.black
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
        child: Text(
          "LOG IN",
          style: TextStyle(
            fontSize: 15.0,
            //color: Colors.black
          )
        ),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: startingIndex,
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.white70,
            elevation: 0.0,
            bottom: PreferredSize(
              preferredSize: Size(double.infinity, 58.0),
              child: ColoredBox(
                color: Colors.white,
                child: _tabBar,
              ),
            ),
            actions: [
              GestureDetector(
                child: Padding(
                  child: GestureDetector(
                    child: CircleAvatar(
                      radius: 14.0,
                      backgroundColor: Colors.grey.shade300,
                      child: const Icon(
                        Icons.close,
                        color: Colors.black87,
                        size: 15.0,
                      ),
                    ),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                ),
                onTap: (){

                },
              )
            ],
          ),
          body: TabBarView(
            children: [
              MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: RegisterBloc()
                  ),
                  BlocProvider<CityPhoneBloc>.value(
                    value: CityPhoneBloc()
                  )
                ],
                child: RegisterScreen()
              ),
              LogInScreen()
            ],
          )
        )
    );
  }
}