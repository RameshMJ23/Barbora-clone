import 'package:barboraapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:barboraapp/bloc/booking_bloc/booking_process_bloc/booking_process_bloc.dart';
import 'package:barboraapp/bloc/bottom_nav_bloc/bottom_nav_bloc.dart';
import 'package:barboraapp/bloc/cart_bloc/cart_bloc.dart';
import 'package:barboraapp/bloc/internet_bloc/internet_bloc.dart';
import 'package:barboraapp/bloc/lang_bloc/lang_bloc.dart';
import 'package:barboraapp/bloc/lang_bloc/lang_state.dart';
import 'package:barboraapp/bloc/timer_bloc/timer_bloc.dart';
import 'package:barboraapp/data/shared_preference.dart';
import 'package:barboraapp/l10n/generated_files/app_localizations.dart';
import 'package:barboraapp/screeens/book_screen_auth.dart';
import 'package:barboraapp/screeens/intro_screen.dart';
import 'package:barboraapp/screeens/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreference.initPreference();
  await SharedPreference.setAddressIndex(0);
  await SharedPreference.setPickupLocationIndex(0);
  await SharedPreference.setReservationValue(0, 0);
  await Firebase.initializeApp();

  final storage = await HydratedStorage.build(storageDirectory: await getApplicationDocumentsDirectory());
  HydratedBlocOverrides.runZoned(
        () => runApp(const MyApp()),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(), lazy: false),
        BlocProvider(create: (context) => LangBloc()),
        BlocProvider(create: (context) => InternetBloc(), lazy: false,),
        BlocProvider(create: (context) => BottomNavBloc(), lazy: false,),
        BlocProvider(create: (context) => CartBloc()),
        BlocProvider(create: (context) => TimerBloc(), lazy: false,),
        BlocProvider(create: (context) =>  BookingProcessBloc()),
      ] ,
      child: BlocBuilder<LangBloc, LangState>(
        builder: (context, state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Barbora clone',
            home: IntroScreen(),
            supportedLocales: const [
              Locale("en"),
              Locale("lt"),
              Locale("ru")
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              AppLocalizations.delegate
            ],
            locale: state.locale,
          );
        },
        buildWhen: (prevState, currentState){
          return prevState.locale == currentState.locale ? false: true;
        },
      ),
    );
  }
}
