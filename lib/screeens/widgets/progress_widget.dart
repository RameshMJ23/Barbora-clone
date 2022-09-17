import 'package:barboraapp/l10n/generated_files/app_localizations.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:flutter/material.dart';


class ProgressWidget extends StatelessWidget {

  ProgressWidgetStatus status;

  ProgressWidget({required this.status});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        clipBehavior: Clip.none,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        //color: Colors.grey.shade200,
        height: 40.0,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: Row(
                    children: [
                      SizedBox(
                        width: (MediaQuery.of(context).size.width * 0.80)/2,
                        child: Divider(
                          color: (status == ProgressWidgetStatus.bookSlot || status == ProgressWidgetStatus.payment)
                            ? Colors.green
                            : Colors.grey,
                          thickness: (status == ProgressWidgetStatus.bookSlot || status == ProgressWidgetStatus.payment)
                            ? 2.0
                            : 1.0,
                        ),
                      ),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width * 0.75)/2,
                        child: Divider(
                          color: (status == ProgressWidgetStatus.payment)
                            ? Colors.green
                            : Colors.grey,
                          thickness: (status == ProgressWidgetStatus.payment)
                              ? 2.0
                              : 1.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 15.0,
                child: Column(
                  children:  [
                    const CircleAvatar(
                      radius: 8.0,
                      backgroundColor: Colors.green,
                    ),
                    Text(
                      AppLocalizations.of(context)!.cart,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: (status == ProgressWidgetStatus.cart)
                          ? Colors.black87
                          : Colors.grey
                      ),
                    )
                  ],
                ),
              ),
              Center(
                //left: 2.0,
                child: Column(
                  children:  [
                    CircleAvatar(
                      radius: 8.0,
                      backgroundColor: (status == ProgressWidgetStatus.bookSlot || status == ProgressWidgetStatus.payment)
                        ? Colors.green
                        : Colors.grey,
                    ),
                    Text(
                      AppLocalizations.of(context)!.bookASlot,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: (status == ProgressWidgetStatus.bookSlot)
                          ? Colors.black87
                          : Colors.grey
                      )
                    )
                  ],
                ),
              ),
              Positioned(
                right: 15.0,
                child: Column(
                  children:  [
                    CircleAvatar(
                      radius: 8.0,
                      backgroundColor: (status == ProgressWidgetStatus.payment)
                      ? Colors.green : Colors.grey,
                    ),
                    Text(
                      AppLocalizations.of(context)!.payment,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: (status == ProgressWidgetStatus.payment)
                          ? Colors.black87
                          : Colors.grey
                      )
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
