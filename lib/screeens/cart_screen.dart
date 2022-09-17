import 'package:barboraapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:barboraapp/bloc/auth_bloc/auth_state.dart';
import 'package:barboraapp/bloc/cart_bloc/cart_bloc.dart';
import 'package:barboraapp/bloc/home_bloc/search_bloc/search_bloc.dart';
import 'package:barboraapp/screeens/common_loggedout_screen.dart';
import 'package:barboraapp/screeens/widgets/cart_order_screen.dart';
import 'package:barboraapp/screeens/widgets/expandable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {

  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state){
        if(state is UserState){
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: CartBloc(),
              ),
              BlocProvider.value(
                value: SearchBloc(),
              )
            ],
            child: CartOrderScreen()
          );
        }else{
          return CommonLoggedOutScreen(
              content: "To view the cart, register or log in",
              icon: Icons.shopping_cart
          );
        }
      },
    );
  }
}

