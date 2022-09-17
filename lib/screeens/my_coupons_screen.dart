import 'dart:developer';

import 'package:barboraapp/bloc/web_view_bloc/web_view_bloc.dart';
import 'package:barboraapp/screeens/help_web_view.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCouponsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My coupons"),
        centerTitle: true,
        backgroundColor: const Color(0xffE32323),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20.0,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            decoration: getContainerDecoration(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  height: 80.0,
                  width: 160.0,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage(
                        "assets/barbora_bonus.JPG"
                      ),
                      fit: BoxFit.fill
                    ),
                    borderRadius: BorderRadius.circular(15.0)
                  ),
                ),
                const Text(
                    "This is a discount coupon programme based on the accumulation principle. Every time you shop, a discount coupon is accumulated. If you shop for a certain amount in a month, you will receive a coupon that you can use on your next shopping.",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14.0
                    )
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  "Below you can see the accumulation offer for this month. The amount of the accumulation may vary from month to month.",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14.0
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                RichText(
                  text: const TextSpan(
                      text: "The discount coupon appears in this section when the accumulation conditions are met and the last order meeting the accumulation conditions is delivered.",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16.0
                      ),
                      children: [
                        TextSpan(
                          text: "If you have just registered at BARBORA, your coupon will start to accumulate on the first day of the following month, provided you have made at least one purchase at BARBORA before that date.",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                              fontSize: 16.0
                          )
                        )
                      ]
                  ),
                ),
                Padding(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: const Padding(
                      child: Center(
                        child: Text(
                          "You currently have no coupons",
                          style: TextStyle(
                              fontSize: 16.0
                          ),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 25.0),
                    ),
                    elevation: 0.0,
                    color: Colors.grey.shade200,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10.0) ,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            decoration: getContainerDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  child: Text(
                    "Instant",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17.0
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                ),
                Padding(
                  child:  Text(
                    "We often give loyal customers instant free delivery, percentage and flat rate discount coupons for purchases at BARBORA during the specified period. Follow the information in your BARBORA account and find out about the instant discount coupons given to you!",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            decoration: getContainerDecoration(),
            child: Column(
              children: [
                getConfirmationButton(
                  buttonName: "Coupon notification subscription",
                  side: true,
                  buttonColor: Colors.transparent,
                  buttonNameColor: Colors.black87,
                  onPressed: (){

                  }
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: RichText(
                      text: TextSpan(
                        text: "To get acquainted with the terms and conditions of coupons, click ",
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black54
                        ),
                        children: [
                          TextSpan(
                              text: "here",
                              style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.red,
                                  fontSize: 14.0
                              ),
                              recognizer: TapGestureRecognizer()..onTap = (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (_) => BlocProvider.value(
                                  value: WebViewBloc(),
                                  child: WebViewScreen(
                                      screenName: "Coupon rules",
                                      url: "https://barbora.lt/info/kuponu-taisykles"
                                  ),
                                )));
                              }
                          )
                        ],
                      )
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
