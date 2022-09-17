
import 'dart:developer';

import 'package:barboraapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:barboraapp/bloc/auth_bloc/auth_state.dart';
import 'package:barboraapp/data/services/auth/auth_service.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_loading_widget.dart';

class LogInScreen extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormFieldState> _emailState = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
          child: Column(
            children: [
              buildTextField(
                "Email address",
                Icons.alternate_email, _emailController,
                "Enter valid email",
                _emailState
              ),
              buildTextField(
                "Password",
                Icons.lock_outline, _passwordController,
                "Enter valid password",
                null,
                obscureText: true
              ),
              BlocListener<AuthBloc, AuthState>(
                child: getLoginButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      BlocProvider.of<AuthBloc>(context).signInWithEmailAndPassBl(
                        _emailController.text,
                        _passwordController.text
                      );
                    }
                  },
                  content: const Text(
                    "Log in",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0
                    ),
                  ),
                  color: const Color(0xffE32323)
                ),
                listener: (context, state){
                  if(state is LoadingState){
                    Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(
                      builder: (_) => AuthLoadingWidget(),
                    ));
                  }
                },
              ),
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if(state is LoadingState){
                    Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(
                      builder: (_) => AuthLoadingWidget(),
                    ));
                  }
                },
                child: getLoginButton(
                  onPressed: (){
                    BlocProvider.of<AuthBloc>(context).singInWithGoogleBl();
                    /*
                    if(value == null){
                        ScaffoldMessenger.of(context).showSnackBar(
                          getSnackBar(
                            context,
                            "The google account selected is not registered to BARBORA. Please try with different account or register"
                          )
                        );
                      }
                     */
                  },
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          height: 25.0,
                          width: 25.0,
                          child: Image.asset(
                              "assets/google.png"
                          ),
                        ),
                      ),
                      const Text(
                          "Sign In with Google",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0
                          )
                      )
                    ],
                  ),
                  color: Colors.grey.shade200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextButton(
                    onPressed: (){
                      if(_emailState.currentState!.validate()){
                        ScaffoldMessenger.of(context).showSnackBar(
                          getSnackBar(context, "The information has been sent to the email mentioned by you")
                        );
                      }
                    },
                    child: const Text(
                      "Forgot your password?",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.w700
                      )
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }





}
