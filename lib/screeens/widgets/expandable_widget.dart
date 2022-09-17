
import 'package:barboraapp/bloc/cart_bloc/discount_field_bloc/discount_field_bloc.dart';
import 'package:barboraapp/l10n/generated_files/app_localizations.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscountExpandable extends StatelessWidget {

  final GlobalKey<FormFieldState> _discountKey = GlobalKey<FormFieldState>();
  final TextEditingController _discountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      header: Padding(
        child: Text(
          AppLocalizations.of(context)!.discountAndCoupon,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black87,
            fontWeight: FontWeight.w600
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      ),
      collapsed: const SizedBox(),
      expanded: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "You currently have no coupons",
              style: TextStyle(
                color: Colors.grey.shade700
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(),
            ),
            buildTextField(
              "Discount code",
              Icons.edit,
              _discountController,
              "Coupon doesn't exist!",
              _discountKey,
              onTextChange: (String val){
                if(val.isEmpty){
                  BlocProvider.of<DiscountFieldBloc>(context).enableButton(false);
                }else{
                  BlocProvider.of<DiscountFieldBloc>(context).enableButton(true);
                }
              }
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                'If you have a coupon code for a gift, make sure you have not opted out of receiving a gift in the "My settings" section',
                style: TextStyle(
                  color: Colors.grey.shade700
                ),
              ),
            ),
            BlocBuilder<DiscountFieldBloc, bool>(
              builder: (context, enabled){
                return getLoginButton(
                  onPressed:  enabled ? (){}: null,
                  content: const Text("Activate the discount code", style: TextStyle(color: Colors.white),),
                  color: Colors.green
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
