
import 'package:barboraapp/bloc/payment_bloc/payment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentBloc extends Cubit<PaymentState>{

  PaymentBloc():super(
    PaymentState(
      paymentOption: PaymentOption.electronicBanking,
      bank: Bank.swed
    )
  );

  changePaymentOption(PaymentOption paymentOption){
    emit(PaymentState(paymentOption: paymentOption, bank: state.bank));
  }

  changeBank(Bank bank){
    emit(PaymentState(paymentOption: state.paymentOption, bank: bank));
  }
}