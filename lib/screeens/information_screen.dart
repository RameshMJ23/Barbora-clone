import 'package:barboraapp/bloc/web_view_bloc/web_view_bloc.dart';
import 'package:barboraapp/data/models/info_model.dart';
import 'package:barboraapp/screeens/help_web_view.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InformationScreen extends StatelessWidget {

  final List<InfoModel> _infoOptions = [
    InfoModel(
        optionName: "Terms for goods purchase-sale contract in online store Barbora",
        url: "https://barbora.lt/info/pirkimo-pardavimo-taisykles"
    ),
    InfoModel(
        optionName: "Returning the goods",
        url: "https://barbora.lt/info/prekiu-grazinimas"
    ),
    InfoModel(
        optionName: "Social responsibility",
        url: "https://barbora.lt/info/korupcijos-prevencija"
    ),
    InfoModel(
        optionName: "My products",
        url: "https://barbora.lt/info/mano-prekes"
    ),
    InfoModel(
        optionName: "Use of substitutes",
        url: "https://barbora.lt/info/pakaitalu-naudojimas"
    ),
    InfoModel(
        optionName: "Career",
        url: "https://karjera.barbora.lt/"
    ),
    InfoModel(
        optionName: "Privacy policy",
        url: "https://barbora.lt/info/privatumo-politika"
    ),
    InfoModel(
        optionName: "BARBORA BONUS",
        url: "https://barbora.lt/info/barbora-bonus"
    ),
    InfoModel(
        optionName: "Coupon rules",
        url: "https://barbora.lt/info/kuponu-taisykles"
    ),
    InfoModel(
        optionName: "Payments",
        url: "https://barbora.lt/info/atsiskaitymas"
    ),
    InfoModel(
        optionName: "Important information",
        url: "https://barbora.lt/info/svarbi-informacija"
    ),
    InfoModel(
        optionName: "Delivery of goods",
        url: "https://barbora.lt/info/prekiu-pristatymas"
    ),
    InfoModel(
        optionName: "Locker pickup points",
        url: "https://barbora.lt/info/pirkiniu-stoteliu-vietos"
    ),
    InfoModel(
        optionName: "Mobile application",
        url: "https://barbora.lt/info/mobili-aplikacija"
    ),
    InfoModel(
        optionName: "Product freshness",
        url: "https://barbora.lt/info/produktu-kokybes-uztikrinimas"
    ),
    InfoModel(
        optionName: "Packaging of products",
        url: "https://barbora.lt/info/prekiu-pakavimas"
    ),
    InfoModel(
        optionName: "Frequently Asked Questions",
        url: "https://barbora.lt/info/duk"
    ),
    InfoModel(
        optionName: "AČIŪ discount card rules",
        url: "https://barbora.lt/info/aciu-paskyros-taisykles"
    ),
    InfoModel(
        optionName: "Rules of campaigns and lotteries",
        url: "https://barbora.lt/info/akciju-zaidimu-taisykles"
    ),
    InfoModel(
        optionName: "Product arrangement",
        url: "https://barbora.lt/info/prekiu-isdestymas"
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Information"),
        centerTitle: true,
        backgroundColor: const Color(0xffE32323),
        leading: getAppLeadingWidget(context),
      ),
      body: ListView.builder(
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: ListTile(
              title: Text(_infoOptions[index].optionName,style: TextStyle(fontSize: 17.0), ),
              trailing: const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Icon(Icons.arrow_forward_ios, size: 15.0, color: Colors.black87,)
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => BlocProvider.value(
                  value: WebViewBloc(),
                  child: WebViewScreen(
                    screenName: _infoOptions[index].optionName,
                    url: _infoOptions[index].url
                  ),
                )));
              },
            ),
          );
        },
        itemCount: _infoOptions.length,
      ),
    );
  }
}
