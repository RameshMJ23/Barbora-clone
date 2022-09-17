
import 'package:barboraapp/bloc/web_view_bloc/web_view_bloc.dart';
import 'package:barboraapp/screeens/help_web_view.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class NeedHelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
        centerTitle: true,
        backgroundColor: const Color(0xffE32323),
        leading: getAppLeadingWidget(context),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Contact us",
              style: TextStyle(
                fontSize: 16.0
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)
                ),
                child: ListTile(
                  leading: Icon(Icons.call),
                  title: Text("(8 5)230 9309"),
                  subtitle: Text("Daily from 8 AM to 9 PM"),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () async{
                    if(await canLaunchUrl(Uri.parse("tel:852309309"))){
                      await launchUrl(Uri.parse("tel:852309309"));
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)
                ),
                child: ListTile(
                  leading: Icon(Icons.email_outlined),
                  title: Text("pagalba@barbora.lt"),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () async{
                    if(await canLaunchUrl(Uri.parse("mailto:pagalba@barabora.lt?subject=''&body=''"))){
                      await launchUrl(Uri.parse("mailto:pagalba@barabora.lt?subject=''&body=''"));
                    }
                  },
                ),
              ),
            ),
            Text(
              "More information",
                style: TextStyle(
                    fontSize: 16.0
                )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: GestureDetector(
                child: Card(
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)
                  ),
                  child: ListTile(
                    leading: Icon(Icons.car_rental),
                    title: Text("Order delivery types"),
                    trailing: Icon(Icons.arrow_forward)
                  ),
                ),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => BlocProvider.value(
                    value: WebViewBloc(),
                    child: WebViewScreen(
                      screenName: "Delivery of goods",
                      url: "https://barbora.lt/info/prekiu-pristatymas"
                    ),
                  )));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
