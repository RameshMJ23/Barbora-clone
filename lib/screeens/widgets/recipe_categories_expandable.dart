import 'package:collection/collection.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class RecipeCategoriesExpandable extends StatelessWidget {

  final List<String> pagList = [
    "Pagrindinis ingredientas",
    "Makaronai",
    "Kiaušinių patiekalai",
    "Mėsos patiekalai",
    "Daržovių patiekalai",
    "Žuvies ir jūros gėrybių patiekalai",
    "Pieno gaminių patiekalai",
    "Paukštienos patiekalai",
    "Miltiniai patiekalai",
    "Kruopų patiekalai",
    "Vaisių patiekalai"
  ];

  final List<String> patiekaloList = [
    "Patiekalo tipas",
    "Salotos",
    "Desertai",
    "Pusryčiams",
    "Užkandžiai",
    "Sriubos",
    "Nealkoholiniai kokteiliai",
    "Gėrimai",
    "Patiekalai su poliarine duonele",
    "Pagrindiniai patiekalai",
    "Pietų dėžutės",
    "Patiekalai su poliarine duonele"
  ];

  final List<String> paruList = [
    "Paruošimo tipas",
    "Grilio patiekalai",
    "Kepta keptuvėje",
    "Kepta orkaitėje",
    "Virta",
    "Troškinta",
    "Šalti patiekalai",
  ];

  final List<String> imgList = [
    "assets/beatos_virtue_img.jpg",
    "assets/gardesis_img.jpg",
    "assets/hellman_img.jpg",
    "assets/mantinga_img.jpg",
    "assets/maggi_img.jpg",
    "assets/snata_img.jpg",
    "assets/vmg_img.jpg"
  ];


  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      header: const Text(
        "Recipe catergories",
        style: TextStyle(
          color: Colors.black87,
          fontSize: 18.0,
        ),
      ),
      collapsed: const SizedBox(),
      expanded: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildList(pagList),
          const SizedBox(height: 10.0),
          _buildList(patiekaloList),
          const SizedBox(height: 10.0),
          _buildList(paruList),
          const SizedBox(height: 10.0),
          const Text(
            "Rekomenduojami receptai",
            style: TextStyle(
                color:  Colors.grey,
                fontSize: 16.0
            ),
          ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            child: Column(
              children: imgList.map((url){
                return Center(
                  child: Container(
                    //alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Center(
                      child: Image.asset(
                        url,
                        width: double.infinity,
                        //height: 100.0,
                        //height: 200,
                      ),
                    ),
                    color: Colors.grey.shade300,
                    height: 100.0,
                    width: double.infinity,
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildList(List list) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: list.mapIndexed((index, categoryName){
      return Padding(
        child: Text(
          categoryName,
          style: TextStyle(
              color: index == 0 ? Colors.grey : Colors.black87,
              fontSize: 16.0
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 6.0),
      );
    }).toList(),
  );
}
