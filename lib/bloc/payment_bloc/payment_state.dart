

import 'package:equatable/equatable.dart';

enum PaymentOption{
  preInvoice,
  electronicBanking,
  cardUponDelivery,
  creditOrDebitCard
}

enum Bank{
  swed,
  seb,
  luminor
}

class PaymentState extends Equatable{

  PaymentOption paymentOption;
  Bank bank;

  PaymentState({required this.paymentOption, required this.bank});

  @override
  // TODO: implement props
  List<Object?> get props => [paymentOption, bank];
}





