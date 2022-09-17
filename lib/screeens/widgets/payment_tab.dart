import 'package:barboraapp/bloc/payment_bloc/payment_bloc.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/payment_bloc/payment_state.dart';

class PaymentTab extends StatelessWidget {

  bool business;

  PaymentTab({this.business = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListView(
        children: [
          const Padding(
            child: Text("Select your payment method",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.0
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          ),
          const Divider(thickness: 1.5),
          business
            ? BlocBuilder<PaymentBloc, PaymentState>(
              builder: (context, state){
                return state.paymentOption == PaymentOption.preInvoice ? Column(
                  children: [
                    _buildOptions("Pre-invoice", PaymentOption.preInvoice),
                    _buildSplButton(_generalbusinessWidget(),  sideColor: Colors.grey.shade500)
                  ],
                ): _buildOptions("Pre-invoice", PaymentOption.preInvoice);
              },
            )
            : const SizedBox(),
          BlocBuilder<PaymentBloc, PaymentState>(
            builder: (context, state){
              return Column(
                children: [
                  _buildOptions("Electronic banking", PaymentOption.electronicBanking),
                  state.paymentOption == PaymentOption.electronicBanking ? Column(
                    children: [
                      business
                        ? _businessWidget(context)
                        : const SizedBox(),
                      _buildButtons(
                        "assets/bank_swed.png",
                        Bank.swed
                      ),
                      _buildButtons(
                        "assets/bank_seb.jpg",
                        Bank.seb,
                        height: 40.0,
                        width: 120.0,
                      ),
                      _buildButtons(
                        "assets/bank_luminor.png",
                        Bank.luminor
                      )
                    ],
                  )
                  : const SizedBox(),
                ],
              );
            },
          ),
          const Divider(thickness: 1.5),
          BlocBuilder<PaymentBloc, PaymentState>(
            builder: (context, state){
              return Column(
                children: [
                  _buildOptions("I'll pay by card upon delivery", PaymentOption.cardUponDelivery),
                  (business && state.paymentOption == PaymentOption.cardUponDelivery)
                    ? _businessWidget(context)
                    : const SizedBox()
                ],
              );
            },
          ),
          const Divider(thickness: 1.5),
          BlocBuilder<PaymentBloc, PaymentState>(
            builder: (context, state){
              return Column(
                children: [
                  _buildOptions("Credit or debit card", PaymentOption.creditOrDebitCard),
                  state.paymentOption == PaymentOption.creditOrDebitCard
                    ? business
                    ? Column(
                      children: [
                        _businessWidget(context),
                        _buildSplButton(_generalAddCardWidget())
                      ],
                    )
                    : _buildSplButton(_generalAddCardWidget())
                    : const SizedBox()
                ],
              );
            },
          ),
          const Divider(thickness: 1.5)
        ],
      ),
    );
  }

  Widget _businessWidget(BuildContext context) => Column(
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          "In order to place an order as a legal entity, it is necessay to enter company data.",
          style: TextStyle(
            color: Colors.red
          ),
        ),
      ),
      _buildSplButton(
        _generalbusinessWidget(),
        sideColor: Colors.grey.shade500,
        onPressed: (){
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useRootNavigator: true,
            isDismissible: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0)
              )
            ),
            builder: (context){
              return SizedBox(
                //height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildBottomSheetHeader(
                      "Add account details",
                      Icons.close,
                      context
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          informationWidget(
                            content: "If you need to change the invoice due to incorrectly specified detailsm please contact us by "
                                "e-mail at pagalba@barbora.lt within 3 working days from the date of receipt of the invoice. If we "
                                "recive your request later, we won't be able to change the invoice",
                            height: 160.0
                          ),
                          _buildTextField("Legal entity name"),
                          _buildTextField("Legal entity code"),
                          _buildTextField("VAT code"),
                          _buildTextField("Address"),
                          getConfirmationButton(
                            buttonName: "Save",
                            onPressed: (){

                            }
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          );
        }
      ),
      const Divider()
    ],
  );

  Widget _buildTextField(String fieldName) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Colors.grey.shade400)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Colors.grey.shade700)
          ),
          hintText: fieldName,
          hintStyle: const TextStyle(
              fontSize: 14.0
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0)
      ),
      style: const TextStyle(
          fontSize: 14.0
      ),

      cursorColor: Colors.blue,
      cursorWidth: 2.0,
      cursorHeight: 20.0,
    ),
  );

  Widget _buildSplButton(Widget contentWidget, {Color sideColor = Colors.green, VoidCallback? onPressed}) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
    child: SizedBox(
      height: 55.0,
      width: double.infinity,
      child: MaterialButton(
        elevation: 0.0,
        highlightElevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(color: sideColor)
        ),
        color: Colors.grey.shade200,
        child: contentWidget,
        padding: EdgeInsets.zero,
        onPressed: onPressed ?? (){

        },
      ),
    ),
  );

  Widget _generalbusinessWidget() => Row(
    children: const [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Icon(Icons.add),
      ),
      Text(
        "Add account details",
        style: TextStyle(
            fontSize: 13.0
        )
      )
    ],
  );

  Widget _generalAddCardWidget() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        children: const [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                child: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                alignment: Alignment.centerLeft,
              )
          ),
          Text(
            "Add card and pay with it",
            style: TextStyle(
                fontSize: 13.0
            ),
          )
        ],
      ),
      const Padding(
        child: Icon(
            Icons.add
        ),
        padding: EdgeInsets.only(right: 15.0),
      )
    ],
  );

  Widget _buildButtons(
    String image,
    Bank value,
    {double height = 75.0,
    double width = 150.0}
  ) => BlocBuilder<PaymentBloc, PaymentState>(
    builder: (context, state){
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: SizedBox(
          height: 55.0,
          width: double.infinity,
          child: MaterialButton(
            elevation: 0.0,
            highlightElevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side:  value == state.bank ? BorderSide(color: Colors.green):BorderSide(color: Colors.grey.shade400)
            ),
            color: Colors.grey.shade200,
            child: Stack(
              children: [
                value == state.bank
                  ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Align(
                      child: Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                      alignment: Alignment.centerLeft,
                  )
                )
                : const SizedBox(),
                Center(
                  child: Image.asset(
                    image,
                    height: height,
                    width: width,
                  ),
                )
              ],
            ),
            padding: EdgeInsets.zero,
            onPressed: (){
              BlocProvider.of<PaymentBloc>(context).changeBank(value);
            },
          ),
        ),
      );
    },
  );

  Widget _buildOptions(String optionName, PaymentOption value) => BlocBuilder<PaymentBloc, PaymentState>(
    builder: (context, state){
      return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
        leading: Radio(
          value: value,
          groupValue: state.paymentOption,
          onChanged: (val){
            BlocProvider.of<PaymentBloc>(context).changePaymentOption(value);
          },
          activeColor: Colors.green,
        ),
        title: Text(
          optionName,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w600
          ),
        ),
        onTap: (){
          BlocProvider.of<PaymentBloc>(context).changePaymentOption(value);
        },
      );
    },
  );
}
