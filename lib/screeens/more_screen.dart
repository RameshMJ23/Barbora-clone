

import 'package:barboraapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:barboraapp/bloc/auth_bloc/auth_state.dart';
import 'package:barboraapp/bloc/lang_bloc/lang_bloc.dart';
import 'package:barboraapp/bloc/lang_bloc/lang_state.dart';
import 'package:barboraapp/bloc/recipe_bloc/saved_recipe_bloc/saved_recipe_bloc.dart';
import 'package:barboraapp/bloc/timer_bloc/timer_bloc.dart';
import 'package:barboraapp/l10n/generated_files/app_localizations.dart';
import 'package:barboraapp/screeens/donations_screen.dart';
import 'package:barboraapp/screeens/fonts/custom_icons_icons.dart';
import 'package:barboraapp/screeens/information_screen.dart';
import 'package:barboraapp/screeens/my_account_screen.dart';
import 'package:barboraapp/screeens/my_orders_screen.dart';
import 'package:barboraapp/screeens/need_help.dart';
import 'package:barboraapp/screeens/recipe_screen.dart';
import 'package:barboraapp/screeens/widgets/auth_loading_widget.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/booking_bloc/booking_process_bloc/booking_process_bloc.dart';

class MoreScreen extends StatefulWidget {
  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {

  RadioOptions radioVal = RadioOptions.Lietuvis;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: SizedBox(
                  height: 100.0,
                  width: MediaQuery.of(context).size.width * 0.60,
                  child:Image.asset(
                    "assets/barbora_img.png"
                  ),
                ),
              ),
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state){
                return (state is UserState)
                  ? Column(
                    children: [
                      _optionsBuilder(iconData: Icons.notes, name: AppLocalizations.of(context)!.myOrders, onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => MyOrdersScreen()));
                      }),
                      _optionsBuilder(iconData: Icons.person, name: AppLocalizations.of(context)!.myAccount, onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => MyAccountScreen()));
                      }),
                    ],
                  )
                  : const SizedBox(height: 0.0,);
              },
            ),
            _optionsBuilder(iconData: CustomIcons.hard_hat, name: AppLocalizations.of(context)!.recipes, onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => BlocProvider.value(
                value: SavedRecipeBloc(),
                child: RecipeScreen(),
              )));
            }),
            _optionsBuilder(iconData: Icons.info_outline, name: AppLocalizations.of(context)!.information, onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => InformationScreen()));
            }),
            _optionsBuilder(iconData: Icons.favorite_border, name: AppLocalizations.of(context)!.donation, onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => DonationsScreen()));
            }),
            _optionsBuilder(iconData: Icons.help_outline, name: AppLocalizations.of(context)!.needHelp, onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => NeedHelpScreen()));
            }),
            BlocBuilder<LangBloc, LangState>(
              builder: (context, state){
                late RadioOptions radioVal;
                late String flagVal;
                late String langName;

                if(state.locale.languageCode == "lt"){
                  radioVal = RadioOptions.Lietuvis;
                  flagVal = "🇱🇹";
                  langName = "Lietuvių";
                }else if(state.locale.languageCode == "ru"){
                  radioVal = RadioOptions.Russian;
                  flagVal = "🇷🇺";
                  langName = "Русский";
                }else{
                  radioVal = RadioOptions.English;
                  flagVal = "🇺🇸";
                  langName = "English";
                }

                return _optionsBuilder(
                    iconData: Icons.flag,
                    name: langName,
                    flagVal: flagVal,
                    isText: true,
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (context){
                          return _getLangDialogue(context);
                        },
                      );
                    }
                );
              },
            ),
            _buildAuthButtons(context),
            const Spacer(),
            const Text("v2.11.4 (567)")
          ],
        ),
      ),
    );
  }

  Widget _buildAuthButtons(BuildContext context){
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state){
        return (state is UserState)
          ? _logoutButton(context)
          : getAuthButtons(context);
      },
    );
  }

  Widget _optionsBuilder({
    required IconData iconData,
    required String name,
    required VoidCallback onTap,
    bool isText = false,
    String flagVal = ""
  }){
    return GestureDetector(
      child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
          ),
          elevation: 1.5,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 13.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: !isText
                        ? Icon(
                          iconData,
                          color: Colors.black.withOpacity(0.7),
                          size: 18.0,
                        )
                        :  Text(
                          flagVal
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        name,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7)
                        ),
                      ),
                    )
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.black.withOpacity(0.7),
                    size: 18.0,
                  ),
                )
              ],
            ),
          )
      ),
      onTap: onTap,
    );
  }

  Widget _logoutButton(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
      child: Row(
        //mainAxisAlignment: MainAxisAlig,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Icon(
              CustomIcons.power_settings_new,
              color: Colors.black.withOpacity(0.7),
              size: 18.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextButton(
              child: Text(
                " ${AppLocalizations.of(context)!.logOut}",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.w400
                ),
              ),
              onPressed: (){
                showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)
                        ),
                        title: const Text("Log Out", textAlign: TextAlign.center,),
                        content: const Text(
                          "Are your sure, you want to log out?",
                        ),
                        actions: [
                          BlocListener<AuthBloc, AuthState>(
                            child: TextButton(
                              onPressed: (){
                                BlocProvider.of<TimerBloc>(context).stopTimerForLeavingOut();
                                BlocProvider.of<AuthBloc>(context).logOut();
                              },
                              child: const Text(
                                "yes",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18.0
                                ),
                              ),
                            ),
                            listener: (context, state){
                              if(state is LoadingState){

                                //BlocProvider.of<BookingProcessBloc>(context).changeReservation(0, 0);
                                Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(
                                  builder: (_) => AuthLoadingWidget(),
                                ));
                              }
                            },
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: const Text(
                                "No",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18.0
                                )
                            ),
                          )
                        ],
                      );
                    }
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _getLangDialogue(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
        child: BlocBuilder<LangBloc, LangState>(
          builder: (context, optionState){

            //RadioOptions initOption = BlocProvider.of<OptionBloc>(context).get;
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  child: Text(
                    AppLocalizations.of(context)!.chooseLang,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                ),
                RadioListTile(
                    title: const Text(
                      " 🇱🇹  Lietuvių"
                    ),
                    activeColor: Colors.green,
                    value: RadioOptions.Lietuvis,
                    groupValue: optionState.radioOption,
                    onChanged: (val){
                      BlocProvider.of<LangBloc>(context).changeOption(val as RadioOptions);
                    }
                ),
                RadioListTile(
                    title: const Text(
                        " 🇺🇸 English"
                    ),
                    activeColor: Colors.green,
                    value:  RadioOptions.English,
                    groupValue: optionState.radioOption,
                    onChanged: (val){
                      BlocProvider.of<LangBloc>(context).changeOption(val as RadioOptions);
                    }
                ),
                RadioListTile(
                    title: const Text(
                      " 🇷🇺 Русский"
                    ),
                    activeColor: Colors.green,
                    value:  RadioOptions.Russian,
                    groupValue: optionState.radioOption,
                    onChanged: (val){
                      BlocProvider.of<LangBloc>(context).changeOption(val as RadioOptions);
                    }
                ),
                SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      AppLocalizations.of(context)!.save,
                      style: const TextStyle(
                        color: Colors.white
                      ),
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                      BlocProvider.of<LangBloc>(context).changeLang(optionState.radioOption);
                    },
                    color: Colors.green,
                  ),
                )
              ],
            );
          },
        ),
      ),
    ),
  );

}
