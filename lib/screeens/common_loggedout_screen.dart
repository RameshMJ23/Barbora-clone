import 'package:barboraapp/screeens/book_screen_auth.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:flutter/material.dart';

class CommonLoggedOutScreen extends StatelessWidget {

  String content;
  IconData icon;

  CommonLoggedOutScreen({required this.content, required this.icon});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 85.0,
              color: Colors.grey.shade400,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                content
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: getAuthButtons(context),
            )
          ],
        ),
      ),
    );
  }
}
