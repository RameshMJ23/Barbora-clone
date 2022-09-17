import 'package:barboraapp/bloc/payment_bloc/payment_bloc.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:barboraapp/screeens/widgets/payment_tab.dart';
import 'package:barboraapp/screeens/widgets/progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentScreen extends StatelessWidget {

  TabBar get _paymentTabBar => TabBar(

    indicatorWeight: 3.5,
    indicatorColor: Colors.green,
    unselectedLabelColor: Colors.black,
    labelColor: Colors.green,
    tabs: [
      Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                Icons.person_outline,
              ),
            ),
            Text(
              "PERSONAL",
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                Icons.work_outline,
              ),
            ),
            Text(
              "BUSINESS",
              style: TextStyle(
                fontSize: 11,
                letterSpacing: 0.0,
                wordSpacing: 0.0,
                fontWeight: FontWeight.bold
              )
            )
          ],
        ),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            elevation: 0.0,
            title: const Text("Payment"),
            centerTitle: true,
            backgroundColor: const Color(0xffE32323),
            bottom: PreferredSize(
              preferredSize: const Size(double.infinity,  135.0),
              child: ColoredBox(
                color: Colors.white,
                child: Column(
                  children: [
                    ProgressWidget(status: ProgressWidgetStatus.payment),
                    const Divider(thickness: 1.5,),
                    ColoredBox(
                      color: Colors.white,
                      child: _paymentTabBar,
                    )
                  ],
                ),
              ),
            ),
            leading: getAppLeadingWidget(context),
          ),
          body: TabBarView(
            children: [
              BlocProvider(
                create: (context) => PaymentBloc(),
                child: PaymentTab(),
              ),
              BlocProvider(
                create: (context) => PaymentBloc(),
                child: PaymentTab(business: true,),
              )
            ],
          ),
          persistentFooterButtons: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
              margin: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: const Color(0xffE32323),
              ),
              child: const Center(
                child: Text(
                  "Continue",
                  style:  TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}
