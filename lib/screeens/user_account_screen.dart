
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:flutter/material.dart';

class UserAccountScreen extends StatelessWidget {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    _nameController.text = "Ramesh";
    _surNameController.text = "Krish";

    return WillPopScope(
      onWillPop: (){
        Navigator.of(context,rootNavigator: true).pop();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My account"),
          centerTitle: true,
          backgroundColor: const Color(0xffE32323),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 20.0,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          child: ListView(
            children: [
              Container(
                decoration: getContainerDecoration(),
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      child: Row(
                        children: [
                          SizedBox(
                            child: Padding(
                              child: TextField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                    labelText: "Name"
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            ),
                            width: MediaQuery.of(context).size.width / 2,
                          ),
                          Expanded(
                            child: Padding(
                              child: TextField(
                                controller: _surNameController,
                                decoration: const InputDecoration(
                                    labelText: "Surname"
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      child: RichText(
                        text: const TextSpan(
                            text: "Email address: ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16.0
                            ),
                            children: [
                              TextSpan(
                                  text: "abc@gmail.com",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0
                                  )
                              )
                            ]
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                    ),
                    getButton(
                      buttonName: "Change password",
                      icon: Icons.lock,
                      onTap: (){

                      },
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                decoration: getContainerDecoration(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _getTitleText("Use of substitutes"),
                    _getCheckBox("Allow substites for all unavailable ordered products"),
                    const Text(
                      "Similar items are products of the same or very similar composition and price. Similar items shall be added to your shopping cart only if there is no product specified by you or the quantity you need is not available when preparing your order.",
                    ),
                    getButton(
                        buttonName: "Learn more",
                        icon: Icons.more_horiz,
                        onTap: (){

                        }
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                decoration: getContainerDecoration(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _getTitleText("Gift consents"),
                    _getCheckBox("I refuse to receive any gifts, discount coupons issued by partners, product samples, promotional publications"),
                    const Padding(
                      child: Text(
                          "By refusing, you agree that no additional products will be added to your shopping cart: various gifts, special discouunt coupons, exclusive offer flyers, information about games and lotteries, various information and promotional publications."
                      ),
                      padding: EdgeInsets.symmetric(vertical: 3.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                decoration: getContainerDecoration(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _getTitleText("Offer subscription"),
                    const Padding(
                      child: Text(
                          "Dear customers, you will receive offers selected for you only by choosing specific delivery methods."
                      ),
                      padding: EdgeInsets.symmetric(vertical: 3.0),
                    ),
                    _getCheckBox("I agree to receive personal offers based on my purchase history"),
                    const Padding(
                      child: Text(
                          "You agree to receive discount coupons specially selected for you, free delivery, exclusive promotions relevent to you, invitations to participate in games and lotteries."
                      ),
                      padding: EdgeInsets.symmetric(vertical: 3.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                decoration: getContainerDecoration(),
                child: Column(
                  children: [
                    _getTitleText("My account"),
                    getButton(
                        buttonName: "Remove",
                        icon: Icons.delete_forever,
                        onTap: (){
                          showModalBottomSheet(
                              useRootNavigator: true,
                              shape:  const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))
                              ),
                              context: context,
                              builder: (context){
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    buildBottomSheetHeader("Attention", Icons.close, context),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "Your account will be deleted and you will no longer be able to use the service provided by BARBORA. Do you want to continue?",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          getConfirmationButton(buttonName: "Confirm", onPressed: (){}),
                                          getConfirmationButton(
                                            buttonName: "Cancel",
                                            buttonNameColor: Colors.black87,
                                            side: true,
                                            buttonColor: Colors.transparent,
                                            onPressed: (){

                                            }
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }
                          );
                        },
                        iconColor: Colors.red
                    ),
                    getConfirmationButton(buttonName: "Save", onPressed: (){

                    })
                  ],
                ),
              )
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 10.0),
        ),
      ),
    );
  }

  Widget _getTitleText(String title) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Text(
      title,
      style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w700
      ),
    ),
  );

  Widget _getCheckBox(String content) => Padding(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Checkbox(
            fillColor: MaterialStateProperty.all(Colors.black87),
            checkColor: Colors.white,
            value: true,
            onChanged: (val){

            }
        ),
        Expanded(
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w700
            ),
          ),
        ),
      ],
    ),
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
  );


}
