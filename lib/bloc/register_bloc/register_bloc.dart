

import 'package:barboraapp/bloc/register_bloc/register_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RegisterBloc extends Cubit<RegisterState>{

  RegisterBloc():super(
    RegisterState(
      personalOffers: false,
      privacyPolicy: false,
      byApp: false,
      byEmail: false,
      viaSms: false
    )
  );

  selectPersonalOffers(bool value){
    emit(
      RegisterState(
        personalOffers: value,
        privacyPolicy: state.privacyPolicy,
        byApp: state.byApp,
        byEmail: state.byEmail,
        viaSms: state.viaSms
      )
    );
  }

  selectPrivacyPolicy(bool value){
    emit(
      RegisterState(
        personalOffers: state.personalOffers,
        privacyPolicy: value,
        byApp: state.byApp,
        byEmail: state.byEmail,
        viaSms: state.viaSms
      )
    );
  }

  selectByApp(bool value){
    emit(
        RegisterState(
            personalOffers: state.personalOffers,
            privacyPolicy: state.privacyPolicy,
            byApp: value,
            byEmail: state.byEmail,
            viaSms: state.viaSms
        )
    );
  }

  selectByEmail(bool value){
    emit(
        RegisterState(
          personalOffers: state.personalOffers,
          privacyPolicy: state.privacyPolicy,
          byApp: state.byApp,
          byEmail: value,
          viaSms: state.viaSms
        )
    );
  }

  selectViaSms(bool value){
    emit(
        RegisterState(
          personalOffers: state.personalOffers,
          privacyPolicy: state.privacyPolicy,
          byApp: state.byApp,
          byEmail: state.byEmail,
          viaSms: value
        )
    );
  }
}