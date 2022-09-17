
import 'dart:developer';

import 'package:barboraapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:barboraapp/bloc/auth_bloc/auth_state.dart';
import 'package:barboraapp/bloc/recipe_bloc/recipe_bloc.dart';
import 'package:barboraapp/bloc/register_bloc/city_phone_bloc/city_phone_state.dart';
import 'package:barboraapp/bloc/register_bloc/register_bloc.dart';
import 'package:barboraapp/bloc/register_bloc/register_state.dart';
import 'package:barboraapp/data/models/address_model.dart';
import 'package:barboraapp/data/models/flag_model.dart';
import 'package:barboraapp/data/services/auth/auth_service.dart';
import 'package:barboraapp/screeens/widgets/auth_loading_widget.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/register_bloc/city_phone_bloc/city_phone_bloc.dart';

class RegisterScreen extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailAddController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _streetAndHouseNumController = TextEditingController();
  final TextEditingController _appartmentController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _phoneNumController = TextEditingController();



  final List<FlagModel> flagList = [
    FlagModel(image: "assets/lithuania.png", code: "+370", countyName: "Lithuania"),
    FlagModel(image: "assets/latvia.png", code: "+371", countyName: "Latvia"),
    FlagModel(image: "assets/estonia.png", code: "+372", countyName: "Estonia"),
    FlagModel(image: "assets/denmark.png", code: "+45", countyName: "Denmark"),
    FlagModel(image: "assets/czechia.png", code: "+420", countyName: "Czech republic"),
    FlagModel(image: "assets/finland.png", code: "358", countyName: "Finland"),
    FlagModel(image: "assets/france.png", code: "+33", countyName: "France"),
    FlagModel(image: "assets/luxembourg.png", code: "+352", countyName: "Luxembourg"),
  ];

  @override
  Widget build(BuildContext context) {

    final CityPhoneBloc cityPhoneBloc = BlocProvider.of<CityPhoneBloc>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      child: ListView(
        children: [
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField("Email address *", validatorText: "Enter your email", controller: _emailAddController),
                      _buildTextField(
                        "Password *",
                        validatorText: "Password must contain at least 8 characters, atleast one lowercase and uppercase letter and atleast one symbol",
                        controller: _passwordController,
                        obscureText: true,
                        validatorFunc: _passwordValidator
                      ),
                      GestureDetector(
                        child: DropdownButtonFormField(
                          items: null,
                          onChanged: (val){

                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 10.0)
                          ),
                          validator: (val){
                            if(BlocProvider.of<CityPhoneBloc>(context).state.city == null){
                              return "This field is required";
                            }else{
                              return null;
                            }
                          },
                          hint: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0.0),
                            child: BlocBuilder<CityPhoneBloc, CityPhoneState>(
                              builder: (context, state){
                                return Text(
                                  state.city ?? "City",
                                  style: TextStyle(
                                    color: state.city == null
                                      ? Colors.grey.shade600
                                      : Colors.black87,
                                  )
                                );
                              },
                            ),
                          ),
                          iconDisabledColor: Colors.black87,
                          iconEnabledColor: Colors.black87,
                          icon: Icon(Icons.keyboard_arrow_down),
                        ),
                        onTap: (){
                          FocusManager.instance.primaryFocus!.unfocus();
                          showCityBottomSheet(context, cityPhoneBloc);
                        },
                      ),
                      BlocBuilder<CityPhoneBloc, CityPhoneState>(
                        builder: (context, state){
                          return _buildTextField(
                              "Street and house number *",
                              controller: _streetAndHouseNumController,
                              enable: state.city != null,
                              validatorText: "This field is required"
                          );
                        }
                      ),
                      _buildTextField("Apartment *", controller: _appartmentController),
                      _buildTextField("Name *", validatorText: "Enter you name", controller: _nameController),
                      _buildTextField("Surname *", validatorText: "Enter your surname", controller: _surnameController),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 15.0),
                            child: GestureDetector(
                              child: DropdownButtonFormField(
                                items: null,
                                onChanged: (val){

                                },
                                hint: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: BlocBuilder<CityPhoneBloc, CityPhoneState>(
                                    builder: (context, state){
                                      return Text(
                                        state.phoneNum,
                                        style: const TextStyle(
                                          color: Colors.black87,
                                        )
                                      );
                                    },
                                  ),
                                ),
                                iconDisabledColor: Colors.black87,
                                iconEnabledColor: Colors.black87,
                                icon: const Icon(Icons.keyboard_arrow_down),
                              ),
                              onTap: (){
                                FocusManager.instance.primaryFocus!.unfocus();
                                showPhoneNUmBottomSheet(context, cityPhoneBloc);
                              },
                            ),
                            width: 100.0,
                          ),
                          Expanded(child:  _buildTextField(
                            "Phone number *",
                            validatorText: "This field is requied",
                            controller: _phoneNumController,
                            validatorFunc: _phoneNumberValidator,
                            keyboardType: TextInputType.phone
                          ),)
                        ] ,
                      ),
                      _bottomCheckBoxes(context)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: BlocBuilder<RegisterBloc, RegisterState>(
              builder: (context, state){
                return BlocListener<AuthBloc, AuthState>(
                  child: MaterialButton(
                    disabledColor: const Color(0xffE32323).withOpacity(0.5),
                    child: const Text(
                      "Register",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0
                      ),
                    ),
                    onPressed: (state.privacyPolicy && state.personalOffers)
                      ? () async{
                        FocusManager.instance.primaryFocus!.unfocus();
                        if(_formKey.currentState!.validate()){
                          BlocProvider.of<AuthBloc>(context).registerUserWithEmailAndPassBl(
                              _emailAddController.text,
                              _passwordController.text,
                              "Default address",
                              AddressModel(
                                  city: BlocProvider.of<CityPhoneBloc>(context).state.city!,
                                  address: _streetAndHouseNumController.text,
                                  addressName: "Default address",
                                  phoneNumber: _phoneNumController.text,
                                  apartment: _appartmentController.text,
                                  firebaseName: "Default address"
                              )
                          ).then((value){

                            if(value == null){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  getSnackBar(context, "This email is already registered to BARBORA. Log in or enter a different email address")
                              );
                            }
                          });
                        }
                      }
                      : null,
                    color: const Color(0xffE32323),
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                  ),
                  listener: (context, authState){
                    if(authState is LoadingState){
                      Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(
                        builder: (_) => AuthLoadingWidget(),
                      ));
                    }
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  String? _phoneNumberValidator(String? enteredNumber){
    if(enteredNumber == null || enteredNumber.isEmpty){
      return "This field is required";
    }else if(enteredNumber.length < 8){
      return "Enter phone number in the correct format, e.g.: +370XXXXXXXX";
    }else{
      return null;
    }
  }

  String? _passwordValidator(String? enteredPassword){
    if(
      enteredPassword != null &&
      enteredPassword.contains(RegExp(r'[a-z]'))&&
      enteredPassword.contains(RegExp(r'[0-9]'))&&
      enteredPassword.contains(RegExp(r'[A-Z]'))
    ){
      return null;
    }else{
      return "Password must contain at least 8 characters, atleast one lowercase and uppercase letter and atleast one number";
    }
  }

  Widget _bottomCheckBoxes(BuildContext context){
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state){
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Column(
            children: [
              _buildCheckBox(
                value: state.personalOffers,
                onChanged: (val){
                  BlocProvider.of<RegisterBloc>(context).selectPersonalOffers(val!);
                },
                content: const Text(
                  "I would like to receive personal offers based on my purchase history",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16.0
                  )
                ),
                context: context
              ),
              state.personalOffers
                  ? Column(
                    children: [
                      _buildCheckBox(
                        value: state.byEmail,
                        onChanged: (val){
                          BlocProvider.of<RegisterBloc>(context).selectByEmail(val!);
                        },
                        content: const Text(
                          "By email",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16.0
                          )
                        ),
                        context: context
                      ),
                      _buildCheckBox(
                          value: state.byApp,
                          onChanged: (val){
                            BlocProvider.of<RegisterBloc>(context).selectByApp(val!);
                          },
                          content: const Text(
                            "In the app",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16.0
                            )
                          ),
                          context: context
                      ),
                      _buildCheckBox(
                          value: state.viaSms,
                          onChanged: (val){
                            BlocProvider.of<RegisterBloc>(context).selectViaSms(val!);
                          },
                          content: const Text(
                            "Via SMS",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16.0
                            )
                          ),
                          context: context
                      )
                    ],
                  )
                  : const SizedBox(height: 0.0,),
              _buildCheckBox(
                value: state.privacyPolicy,
                onChanged: (val){
                  BlocProvider.of<RegisterBloc>(context).selectPrivacyPolicy(val!);
                },
                content: RichText(
                  text: const TextSpan(
                      text: "I read and agree with ",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16.0
                      ),
                      children: [
                        TextSpan(
                            text: "Purchase Terms and Conditions  ",
                            style: TextStyle(
                                decoration: TextDecoration.underline
                            )
                        ),
                        TextSpan(
                            text: "and "
                        ),
                        TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(
                                decoration: TextDecoration.underline
                            )
                        )
                      ]
                  ),
                ),
                context: context
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildCheckBox({
    required bool value,
    required Function(bool?) onChanged,
    required Widget content,
    required BuildContext context
  }){
    return Padding(
      child: Row(
        children: [
          Transform.scale(
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              side: BorderSide(
                color: Colors.grey.shade500,
                width: 2
              ),
            ),
            scale: 1.2,
          ),
          Expanded(
            child:  Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: content,
            )
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
    );
  }

  Widget _buildTextField(
      String fieldName, {
      String? validatorText,
      IconData? suffixData,
      TextEditingController? controller,
      bool enable = true,
      bool obscureText = false,
      String? Function(String?)? validatorFunc,
      TextInputType keyboardType = TextInputType.text
  }){
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0 ),
        hintText: fieldName,
        suffix: suffixData == null ? null : Icon(suffixData),
        enabled: enable,
        errorMaxLines: 2
      ),
      obscureText: obscureText,
      validator: validatorFunc ?? (validatorText != null ? ((val) => val!.isEmpty ?  validatorText : null): null)
    );
  }

  showCityBottomSheet(BuildContext context, CityPhoneBloc cityPhoneBloc){
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))
        ),
        isScrollControlled: true,
        context: context,
        builder: (context){
          return BlocProvider.value(
            value: cityPhoneBloc,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildBottomSheetHeader("City", Icons.close, context),
                  Expanded(
                    child: ListView.separated(
                      itemCount: cityDropdown.length,
                      itemBuilder: (context, index){
                        return GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                            child: BlocBuilder<CityPhoneBloc, CityPhoneState>(
                              builder: (context, state){
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      cityDropdown[index],
                                      style: const TextStyle(
                                          fontSize: 16.0
                                      ),
                                    ),
                                    state.city == cityDropdown[index]
                                        ? const Icon(Icons.check, color: Colors.green,)
                                        : const SizedBox(height: 0.0,width: 0.0,)
                                  ],
                                );
                              },
                            ),
                          ),
                          onTap: (){
                            Navigator.pop(context);
                            BlocProvider.of<CityPhoneBloc>(context).selectCity(cityDropdown[index]);
                          },
                        );
                      },
                      separatorBuilder: (context, index){
                        return const Divider();
                      },
                    ),
                  )
                ],
              ),
              height: MediaQuery.of(context).size.height * 0.75,
            ),
          );
        }
    );
  }

  showPhoneNUmBottomSheet(BuildContext context, CityPhoneBloc cityPhoneBloc){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))
        ),
        builder: (context){
          return BlocProvider.value(
            value: cityPhoneBloc,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Column(
                children: [
                  buildBottomSheetHeader("Country code", Icons.close, context),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          _buildTextField("Phone number *"),
                          Expanded(
                            child: ListView.builder(
                              itemCount: flagList.length,
                              itemBuilder: (context, index){
                                return ListTile(
                                  leading: CircleAvatar(
                                    child: Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                flagList[index].image,
                                              ),
                                              fit: BoxFit.fill
                                          )
                                      ),
                                    ),
                                    radius: 25.0,
                                  ),
                                  title: Text(flagList[index].countyName),
                                  subtitle: Text(flagList[index].code),
                                  onTap: (){

                                    Navigator.pop(context);
                                    BlocProvider.of<CityPhoneBloc>(context).changePhoneCode(flagList[index].code);
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }

}
