import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:flutter/material.dart';

class MyAciuCardScreen extends StatelessWidget {

  final GlobalKey<FormFieldState> _textFieldKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("My AČIŪ card"),
        centerTitle: true,
        backgroundColor: const Color(0xffE32323),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20.0,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                children: [
                  TextFormField(
                    key: _textFieldKey,
                    decoration: InputDecoration(
                      hintText: "Enter your AČIŪ card details",
                    ),
                    keyboardType: TextInputType.number,
                    validator: (val) => val!.isEmpty ? "This field is required" : null,
                  ),
                  Padding(
                    child: getButton(
                        buttonName: "Add AČIŪ card",
                        icon: Icons.add_circle_outline,
                        buttonColor: Colors.green,
                        onTap: (){
                          if(_textFieldKey.currentState!.validate()){
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Incorrect card number. Please check and try again"),
                                )
                            );
                          }
                        },
                        textColor: Colors.white,
                        iconColor: Colors.white
                    ),
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Image.asset(
                  "assets/aciu_card.JPG"
              ),
              width: double.infinity,
            )
          ],
        ),
        decoration: getContainerDecoration(),
      )
    );
  }
}
