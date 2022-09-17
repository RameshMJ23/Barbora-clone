

import 'package:barboraapp/data/models/address_icon_model.dart';
import 'package:barboraapp/data/models/pick_up_location_model.dart';
import 'package:barboraapp/data/models/product_type_model.dart';
import 'package:barboraapp/l10n/generated_files/app_localizations.dart';
import 'package:barboraapp/screeens/book_screen_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/auth_bloc/auth_state.dart';
import '../../bloc/cart_bloc/cart_bloc.dart';
import '../../data/models/product_model.dart';



List<PickupLocationModel> getAllLocation() => [
  PickupLocationModel(
      icon: Icons.map,
      locationName: "Pirkinių stotelė Ukmergės g. Circle K",
      locationAddress: "Ukmergės g. 231, 07156 Vilnius",
      value: 0
  ),
  PickupLocationModel(
      icon: Icons.map,
      locationName: "Pirkinių stotelė Geležinio Vilko g. Circle K",
      locationAddress: "Geležinio Vilko g. 39, 8104 Vilnius",
      value: 1
  ),
  PickupLocationModel(
      icon: Icons.map,
      locationName: "Pirkinių stotelė Ozo parkas",
      locationAddress: "J.Balčikonio g. 3, 08200 Vilnius",
      value: 2
  ),
  PickupLocationModel(
      icon: Icons.markunread_mailbox,
      locationName: "Alytaus Naujosios g. Express stotelė",
      locationAddress: "Naujoji g. 90-2, 62388 Alytus",
      value: 3
  ),
  PickupLocationModel(
      icon: Icons.markunread_mailbox,
      locationName: "Marijampolės Express stotelė",
      locationAddress: "V. Kudirkos g. 3, 68176 Marijampolė",
      value: 4
  ),
  PickupLocationModel(
      icon: Icons.markunread_mailbox,
      locationName: "Panevėžio Respublikos g. Express stotelė",
      locationAddress: "Respublikos g. 71, 35157 Panevėžys",
      value: 5
  ),
  PickupLocationModel(
      icon: Icons.markunread_mailbox,
      locationName: "Panevėžio Ukmergės g. Express stotelė",
      locationAddress: "J.Balčikonio g. 3, 08200 Vilnius",
      value: 6
  ),
  PickupLocationModel(
      icon: Icons.markunread_mailbox,
      locationName: "Pirkinių stotelė Ozo parkas",
      locationAddress: "Ukmergės g. 23, 35177 Panevėžys",
      value: 7
  ),
  PickupLocationModel(
      icon: Icons.markunread_mailbox,
      locationName: "Šiaulių Express stotelė",
      locationAddress: "Aido g. 8-1, 78322 Šiauliai",
      value: 8
  ),
  PickupLocationModel(
      icon: Icons.car_rental,
      locationName: "Klaipėdos PC Akropolis Drive-in",
      locationAddress: "Taikos pr. 61, 91182 Klaipėda",
      value: 9
  ),
  PickupLocationModel(
      icon:  Icons.car_rental,
      locationName: "Vilniaus PC Akropolis Drive-in",
      locationAddress: "Ozo g. 25, 7150 Vilnius",
      value: 10
  ),
  PickupLocationModel(
      icon:  Icons.car_rental,
      locationName: "Vilniaus PC Ozas Drive-in",
      locationAddress: "Ozo g. 18, 8243 Vilnius",
      value: 11
  ),
  PickupLocationModel(
      icon:  Icons.car_rental,
      locationName: "Vilniaus Maxima Bazė Drive-in",
      locationAddress: "Savanorių pr. 247, 2300 Vilnius",
      value: 12
  ),
  PickupLocationModel(
      icon:  Icons.car_rental,
      locationName: "Kauno Maxima Bazė Drive-in",
      locationAddress: "Veiverių g. 150B, 46391 Kaunas",
      value: 13
  ),
  PickupLocationModel(
      icon:  Icons.car_rental,
      locationName: "Kauno Hyper Maxima Drive-in",
      locationAddress: "Savanorių pr. 255, 8243 Kaunas",
      value: 14
  ),
  PickupLocationModel(
      icon:  Icons.car_rental,
      locationName: "Kauno Pramonės pr. Maxima Drive-in",
      locationAddress: "Pramonės pr. 29, 51270 Kaunas",
      value: 15
  ),
  PickupLocationModel(
      icon:  Icons.car_rental,
      locationName: "Klaipėdos Taikos pr. Maxima Drive-in",
      locationAddress: "Taikos pr. 141, 94284 Klaipėda",
      value: 16
  )
];


List<String> cityDropdown = const [
  "Vilniaus miestas / rajonas",
  "Kauno miestas / rajonas",
  "Klaipėdos miestas / rajonas",
  "Kretinga / Kretingalė",
  "Palanga / Šventoji",
  "Trakų miestas / rajonas",
  "Neringos miestas / rajonas",
  "Jonavos miestas / rajonas",
  "Birštono miestas / rajonas",
  "Prienų miestas / rajonas",
  "Rumšiškių seniūnija",
  "Vievio miestas / rajonas",
  "Elektrėnų miestas / rajonas",
  "Šiaulių miestas",
  "Marijampolės miestas / rajonas",
  "Panevėžio miestas",
  "Alytaus miestas",
  "Kėdainių miestas",
  "Radviliškio miestas",
  "Šilutės miestas / rajonas",
];

enum ProgressWidgetStatus{
  cart,
  bookSlot,
  payment
}

enum RadioOptions{
  Lietuvis,
  English,
  Russian
}

enum Updatable{
  similar,
  add,
  subtract
}

enum DiscountOptionsEnum{
  withDiscount,
  withoutAciuOffers,
  withoutDiscount,
  none
}


List<String> getTimingList() =>
["08 - 09" , "09 - 10", "10 - 11", "11 - 12", "12 - 13", "13 - 14", "14 - 15", "15 - 16", "16 - 17", "17 - 18", "19 - 20", "20 - 21"];


List<String> getShowingTimingList() =>
["08:00 - 09:00" , "09:00 - 10:00", "10:00 - 11:00", "11:00 - 12:00", "12:00 - 13:00", "13:00 - 14:00",
  "14:00 - 15:00", "15:00 - 16:00", "16:00 - 17:00", "17:00 - 18:00", "19:00 - 20:00", "20:00 - 21:00"];

Widget buildTextField(
    String hintText,
    IconData icon,
    TextEditingController controller,
    String validateText,
    GlobalKey<FormFieldState>? key,
    {bool obscureText = false,
    Function(String)? onTextChange}
){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: TextFormField(
      key: key,
      onChanged: onTextChange,
      validator: (val) => val!.isEmpty ? validateText : null,
      controller: controller,
      decoration: InputDecoration(
          enabledBorder: _generalBorder(Colors.grey.shade300),
          focusedBorder: _generalBorder(Colors.grey.shade700),
          border: _generalBorder(Colors.grey.shade300),
          errorBorder: _generalBorder(Colors.red.shade400),
          prefixIcon: Icon(icon, color: Colors.grey.shade500),
          hintText: hintText,
          prefixIconColor: Colors.grey.shade500
      ),
      obscureText: obscureText,
    ),
  );
}

OutlineInputBorder _generalBorder(Color color){
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(color: color)
  );
}

Widget getLoginButton({
  required VoidCallback? onPressed,
  required Widget content,
  required Color color,
}){
  return SizedBox(
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 10.0
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0)
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: content,
        ),
        color: color,
        elevation: 0.0,
        highlightElevation: 0.0,
        disabledColor: Colors.green.withOpacity(0.7),
        disabledTextColor: Colors.white70,
      ),
    ),
  );
}

BoxDecoration getContainerDecoration() => BoxDecoration(
  color: Colors.white,
  boxShadow: [
    BoxShadow(
        color: Colors.grey.shade300,
        offset: const Offset(1,1),
        blurRadius: 8.0
    )
  ],
);



Widget getAuthButtons(BuildContext context, {Color logInTextColor = Colors.black87, double registerRadius = 5.0,
  Color registerButtonColor = Colors.green,
  Color registerTextColor = Colors.white
}) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 5.0),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      noInfoButton(context, "Register", radius: registerRadius, buttonColor: registerButtonColor, textColor: registerTextColor),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.transparent,
        ),
        child: Center(
          child: TextButton(
            child: Text(
              "Log in",
              style: TextStyle(
                  color: logInTextColor,
                  fontWeight: FontWeight.w500
              ),
            ),
            onPressed: (){
              Navigator.of(
                  context,
                  rootNavigator: true
              ).push(
                  MaterialPageRoute(builder: (_) => BookScreenAuth(startingIndex: 1,))
              );
            },
          ),
        ),
      )
    ],
  ),
);

Widget noInfoButton(
    BuildContext context,
    String buttonName,
    {double radius = 5.0,
    Color buttonColor = Colors.green,
    Color textColor = Colors.white,
    VoidCallback? onTap
}) => SizedBox(
  width: double.infinity,
  child: MaterialButton(
    color: buttonColor,
    padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius)
    ),
    child: Text(
      buttonName,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w500
      ),
    ),
    onPressed: onTap ?? (){
      Navigator.of(
          context,
          rootNavigator: true
      ).push(
          MaterialPageRoute(builder: (_) => BookScreenAuth(startingIndex: 0,))
      );
    },
  ),
);

Widget noInfoWidget({required BuildContext context,required String buttonName,required IconData icon, required String content}) => Center(
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
          content,
          textAlign: TextAlign.center,
        ),
      ),
      const SizedBox(
        height: 10.0,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: noInfoButton(context, buttonName),
      )
    ],
  ),
);

Widget buildBottomSheetHeader(String title, IconData icon, BuildContext context, {bool leadingIcon = false, VoidCallback? onLeadingTap}){
  return Container(
    height: 75.0,
    //padding: const EdgeInsets.symmetric(vertical: 25.0),
    child: Stack(
      children: [
        Center(
          child: Text(
            title,
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.black87
            ),
          ),
        ),
        Positioned(
          child:  IconButton(
            icon: Icon(
              icon,
              color: Colors.grey.shade500,
            ),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          right: 10.0,
          top: 16.0,
        ),
        Positioned(
          child: leadingIcon ? IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey.shade800,
              size: 15.0,
            ),
            onPressed: onLeadingTap,
          ): Text(""),
          left: 10.0,
          top: 16.0,
        )
      ],
    ),
    decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))
    ),
  );
}

Widget getButton({ required String buttonName, required IconData icon, required VoidCallback onTap, Color iconColor = Colors.black87, Color? buttonColor, Color? textColor}) => Padding(
  child: SizedBox(
    width: double.infinity,
    child: MaterialButton(
      elevation: 0.0,
      highlightElevation: 0.0,
      focusElevation: 0.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
      ),
      color: buttonColor ?? Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 5.0),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              buttonName,
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: textColor ?? Colors.black87
              ),
            ),
            Icon(icon, color: iconColor,),
          ],
        ),
      ),
      onPressed: onTap,
    ),
  ),
  padding: const EdgeInsets.symmetric(vertical: 2.0),
);

Widget getConfirmationButton({
  required String buttonName,
  bool side = false,
  Color buttonNameColor = Colors.white,
  Color buttonColor = Colors.green,
  required VoidCallback? onPressed,
  double vertPadding = 15.0,
  double fontSize = 16.0
}) => Padding(
    child: SizedBox(
      width: double.infinity,
      child: MaterialButton(
        elevation: 0.0,
        focusElevation: 0.0,
        highlightElevation: 0.0,
        padding: EdgeInsets.symmetric(vertical: vertPadding),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side : side ? BorderSide(color: Colors.grey.shade400) : const BorderSide(color: Colors.transparent)
        ),
        onPressed: onPressed,
        child: Text(
          buttonName,
          style: TextStyle(
            color: buttonNameColor,
            fontSize: fontSize
          ),
          textAlign: TextAlign.center,
        ),
        color: buttonColor,
      ),
    ),
    padding: const EdgeInsets.symmetric(vertical: 5.0)
);



Widget buildProductItems(ProductTypeModel productTypeModel, BuildContext context) => Material(
  child: InkWell(
    child: Ink(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: Text(
                      productTypeModel.typeName,
                      style: TextStyle(
                          fontWeight: productTypeModel.isBold ? FontWeight.bold : FontWeight.normal
                      )
                  ),
                ),
                productTypeModel.otherWidgets ?? const SizedBox(height: 0.0,width: 0.0,),
              ],
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.black87,size: 16.0,),
          ],
        ),
      ),
    ),
    onTap: (){
      if(productTypeModel.nextScreen != null){
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => productTypeModel.nextScreen!));
      }
    },
  ),
);

Widget itemCountButton({
  double height = 30.0,
  double radius = 5.0,
  double horizontalPad = 10.0,
  double verticalPad = 0.0,
  Color textColor = Colors.black87,
  required VoidCallback addButton,
  required VoidCallback subButton,
  required String unit,
  required String quantity
}) => Container(
  height: height,
  margin: EdgeInsets.symmetric(horizontal: horizontalPad, vertical: verticalPad),
  decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: Colors.grey.shade300)
  ),
  child:  Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 3.0),
                  child: Center(
                    child: Icon(Icons.add, color: Colors.black.withOpacity(0.65),),
                  ),
                ),
              )
            ],
          ),
          onTap: addButton,
        ),
      ),
      const VerticalDivider(thickness: 1.0, color: Colors.grey,),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              quantity + " " + unit,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: textColor
              ),
            ),
          )
        ],
      ),
      const VerticalDivider(thickness: 1.0, color: Colors.grey,),
      Expanded(
        child: GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 3.0),
                  child: Icon(Icons.remove, color: Colors.black.withOpacity(0.65)),
                ),
              )
            ],
          ),
          onTap: subButton,
        ),
      ),
    ],
  ),
  alignment: Alignment.topCenter,
);

SnackBar getSnackBar(BuildContext context, String content, {double topPadding = 200.0}){
  return SnackBar(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0)
    ),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.fromLTRB(15.0, topPadding, 15.0, 20.0),
    content: Row(
      children: [
        Expanded(
          child:  Text(
            content
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white70,
          ),
          onPressed: (){
            ScaffoldMessenger.of(context).clearSnackBars();
          },
        )
      ],
    ),
  );
}

Widget getShimmerWidget({double height = 18.0, double borderRadius = 20.0, double width = double.infinity}) => Shimmer.fromColors(
  child: Container(
    height: height,
    width: width,
    margin: const EdgeInsets.symmetric(vertical: 5.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Colors.grey.shade300
    ),
    child: SizedBox(
      height: height,
      child: Text("asfdsfas", style: TextStyle(color: Colors.grey.shade300),),
    ),
  ),
  baseColor: Colors.grey.shade300,
  highlightColor: Colors.grey.shade100,
  period: Duration(seconds: 1),
);


Widget informationWidget({
  required String content,
  double fontSize = 13.0,
  double height = 100.0
}) => Container(
  decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5.0),
      color: Colors.orange.shade100
  ),
  height: height,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 10.0,
        decoration: const BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), bottomLeft: Radius.circular(5.0)),
        ),
        height: double.infinity,
      ),
      Expanded(
        child: Padding(
          child: Text(
            content,
            style: TextStyle(
                fontSize: fontSize,
                color: Colors.grey.shade700,
                //wordSpacing: 2.0,
                height: 1.5
            ),
            textAlign: TextAlign.justify,
          ),
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
      )
    ],
  ),
);

List<AddressIconModel> get getIconList => [
  AddressIconModel(icon: Icons.home, color: Colors.red),
  AddressIconModel(icon: Icons.home, color: Colors.yellow.shade800),
  AddressIconModel(icon: Icons.home, color: Colors.green),
  AddressIconModel(icon: Icons.home, color: Colors.blue.shade800),
  AddressIconModel(icon: Icons.home, color: Colors.lightBlue),
];

Widget productAppBar({
  required AnimationController controller,
  required bool searchState,
  required VoidCallback textFieldFunc,
  required VoidCallback cancelFunc,
  required Tween<double>? widthValue,
  required Function(String query) queryFunc,
  required TextEditingController textEditingController,
  required VoidCallback iconButtonFunc,
  required bool showIcon,
  required String hintText,
  required String cancelText,
  bool autoFocus = false
}) => AnimatedBuilder(
  animation: controller,
  child: TextField(
    controller: textEditingController,
    autofocus: autoFocus,
    onChanged: queryFunc,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(color: Colors.transparent)
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(color: Colors.transparent)
      ),
      contentPadding: const EdgeInsets.all(0.0),
      filled: true,
      fillColor: Colors.white,
      prefixIcon: Icon(
        Icons.search,
        color: searchState ? Colors.grey :Colors.black87
      ),
      hintText: hintText,
      suffixIcon: showIcon ? IconButton(
        icon: CircleAvatar(
          child: Icon(Icons.close, color: Colors.grey.shade800, size: 15.0,),
          backgroundColor: Colors.grey.shade300,
        ),
        onPressed: iconButtonFunc,
      ): null
    ),
    onTap: textFieldFunc,
    enabled: true,
    //cursorHeight: 10.0,
  ),
  builder: (context, widget){
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 40.0,
            child: widget
          ),
        ),
        SizedBox(
          width: widthValue == null ? 60.0: widthValue.animate(controller).value,
          child: Center(
            child: GestureDetector(
              child: Padding(
                child: Text(
                  cancelText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13.0
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
              ),
              onTap: cancelFunc,
            ),
          ),
        )
      ],
    );
  },
);


Widget getAppLeadingWidget(BuildContext context, {double horizontalPadding = 20.0}) => IconButton(
  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
  icon: const Icon(Icons.arrow_back_ios, size: 20.0,),
  onPressed: (){
    Navigator.pop(context);
  },
);

Widget addToCartButton(
  BuildContext context,
  ProductModel product,
  {double radius = 20.0,
  double padding = 0.0
}
) => BlocBuilder<AuthBloc, AuthState>(
  builder: (context, authState){
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius)
      ),
      color: const Color(0xffE32323),
      onPressed: () async{
        //UserService().storeCartData(uid, productModel);
        if(authState is UserState){
          BlocProvider.of<CartBloc>(context).addProductToCart(authState.uid, product);
        }else{
          showAuthBottomSheet(context);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: padding),
        child: const Text(
          "Add to cart",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400
          ),
        ),
      ),
    );
  },
);

showAuthBottomSheet(BuildContext context){
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))
      ),
      builder: (context){
        return Container(
          decoration: const BoxDecoration(
            borderRadius:  BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
            color: Color(0xffE22E39),
          ),
          height: MediaQuery.of(context).size.height *0.65,
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius:  BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                  color: Colors.white,
                ),
                //height: 100.0,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Center(
                          child: SizedBox(
                            height: 80.0,
                            width: MediaQuery.of(context).size.width * 0.50,
                            child: Image.asset(
                              "assets/barbora_img.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const Padding(
                          child: Text(
                            "Groceries delivered straight to your door",
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffE22E39)
                            ),
                          ),
                          padding: const EdgeInsets.only(bottom: 10.0),
                        )
                      ],
                    ),
                    Positioned(
                      top: 20.0,
                      right: 20.0,
                      child: GestureDetector(
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          radius: 12.0,
                          child: const Icon(Icons.close, color: Colors.black87,),
                        ),
                        onTap: (){
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: Align(
                    child: Image.asset(
                      "assets/barbora_home_register.jpg",
                      fit: BoxFit.contain,
                    ),
                    alignment: Alignment.centerRight,
                  ),
                ),
              ),
              const Padding(
                child: Text(
                  "To shop, register or log in",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 5.0),
              ),
              Padding(
                child: getAuthButtons(
                    context,
                    logInTextColor : Colors.white,
                    registerButtonColor: Colors.white,
                    registerRadius: 20.0,
                    registerTextColor: Colors.black87
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
              )
            ],
          ),
        );
      }
  );
}