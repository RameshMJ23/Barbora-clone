
import 'package:equatable/equatable.dart';

class RegisterState extends Equatable{

  bool personalOffers;
  bool privacyPolicy;
  bool byEmail;
  bool byApp;
  bool viaSms;

  RegisterState({
    required this.personalOffers,
    required this.privacyPolicy,
    required this.byEmail,
    required this.byApp,
    required this.viaSms
  });

  @override
  // TODO: implement props
  List<Object?> get props => [personalOffers, privacyPolicy, byEmail, byApp, viaSms];
}