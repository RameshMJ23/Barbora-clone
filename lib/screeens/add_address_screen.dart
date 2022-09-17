
import 'dart:developer';

import 'package:barboraapp/bloc/address_bloc/address_bloc.dart';
import 'package:barboraapp/bloc/address_bloc/address_state.dart';
import 'package:barboraapp/bloc/address_bloc/select_address_bloc/select_address_stream_bloc.dart';
import 'package:barboraapp/bloc/address_bloc/select_address_bloc/select_address_stream_state.dart' as addStream;
import 'package:barboraapp/bloc/auth_bloc/auth_bloc.dart';
import 'package:barboraapp/bloc/auth_bloc/auth_state.dart';
import 'package:barboraapp/data/models/address_icon_model.dart';
import 'package:barboraapp/data/models/address_model.dart';
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAddressScreen extends StatefulWidget {

  int addressListLength;

  bool update;

  AddressModel? addressModel;

  AddAddressScreen({required this.addressListLength, this.update = false, this.addressModel});

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {


  final GlobalKey<FormState> _formKey = GlobalKey();

  late final TextEditingController _addressController;
  late final TextEditingController _addressNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _apartmentController;
  late final TextEditingController _entranceController;
  late final TextEditingController _floorController;
  late final TextEditingController _doorCodeController ;
  late final TextEditingController _noteController ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

     _addressController = TextEditingController();
     _addressNameController = TextEditingController();
    _phoneController = TextEditingController();
    _apartmentController = TextEditingController();
     _entranceController = TextEditingController();
    _floorController = TextEditingController();
     _doorCodeController = TextEditingController();
     _noteController = TextEditingController();


    if(widget.addressModel != null){
      _addressController.text = widget.addressModel!.address;
      _addressNameController.text = widget.addressModel!.addressName;
      _phoneController.text = widget.addressModel!.phoneNumber;
      _apartmentController.text = widget.addressModel!.apartment ?? "";
      _entranceController.text = widget.addressModel!.entrance ?? "";
      _floorController.text = widget.addressModel!.floor ?? "";
      _doorCodeController.text = widget.addressModel!.doorCode ?? "";
      _noteController.text = widget.addressModel!.note ?? "";
      BlocProvider.of<AddressBloc>(context).changeCitySelected(widget.addressModel!.city);

    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("New address"),
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
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                child: DropdownButtonFormField(
                    validator: (val){
                      if(val == null){
                        return "This field is required";
                      }else{
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.location_city),
                      hintText: "City",
                    ),
                    items: cityDropdown.map((city){
                      return DropdownMenuItem<String>(
                        child: Text(city),
                        value: city,
                      );
                    }).toList(),
                    onChanged: (val){
                      BlocProvider.of<AddressBloc>(context).changeCitySelected(val as String);
                    }
                ),
                padding: const EdgeInsets.symmetric(vertical: 8.0),
              ),
              BlocBuilder<AddressBloc, AddressState>(
                builder: (context, state){
                  return _buildTextField(
                    "Address",
                    Icons.location_on,
                    controller: _addressController,
                    enabled: state.citySelected != null,
                    validate: true
                  );
                },
              ),
              _buildTextField("Address name", Icons.home, controller: _addressNameController, validate: true, enabled: !widget.update),
              _buildTextField("Phone", Icons.phone, controller: _phoneController, validate: true, keyboardType: TextInputType.phone),
              _buildTextFieldRow(context, "Apartment", "Entrance", _apartmentController, _entranceController),
              _buildTextFieldRow(context, "Floor", "Door code", _floorController, _doorCodeController),
              _buildTextField("Note", Icons.note, controller: _noteController),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: getIconList.mapIndexed((index, icon){
                    return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: BlocBuilder<AddressBloc, AddressState>(
                          builder: (context, state){
                            return IconButton(
                              icon: CircleAvatar(
                                child: Icon(icon.icon, color: Colors.white,),
                                backgroundColor: index == state.iconIndex
                                    ? icon.color : icon.color.withOpacity(0.3),
                                radius: 25.0,
                              ),
                              iconSize: 40.0,
                              onPressed: (){
                                BlocProvider.of<AddressBloc>(context).changeIconIndex(index);
                              },
                            );
                          },
                        )
                    );
                  }).toList(),
                ),
              ),
              getConfirmationButton(
                buttonName: widget.update ? "Save" : "Add an address",
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                    if(_phoneController.text.startsWith("+370")){
                      Navigator.pop(context);
                      if(widget.update){
                        BlocProvider.of<AddressBloc>(context).updateUserAddress(
                            uid: _getUserUid(context),
                            addressId: widget.addressModel!.firebaseName,
                            address: AddressModel(
                                city: BlocProvider.of<AddressBloc>(context).state.citySelected!,
                                address: _addressController.text,
                                addressName: _addressNameController.text,
                                phoneNumber: _phoneController.text,
                                apartment: _apartmentController.text,
                                entrance: _entranceController.text,
                                floor: _floorController.text,
                                doorCode: _doorCodeController.text,
                                note: _noteController.text,
                                addressIcon: BlocProvider.of<AddressBloc>(context).state.iconIndex,
                                firebaseName: widget.addressModel!.firebaseName,
                            )
                        );
                      }else{
                        BlocProvider.of<AddressBloc>(context).addUserAddress(
                            uid: _getUserUid(context),
                            addressId: "address ${(widget.addressListLength + 1).toString()}",
                            address: AddressModel(
                              city: BlocProvider.of<AddressBloc>(context).state.citySelected!,
                              address: _addressController.text,
                              addressName: _addressNameController.text,
                              phoneNumber: _phoneController.text,
                              apartment: _apartmentController.text,
                              entrance: _entranceController.text,
                              floor: _floorController.text,
                              doorCode: _doorCodeController.text,
                              note: _noteController.text,
                              addressIcon: BlocProvider.of<AddressBloc>(context).state.iconIndex,
                              firebaseName: "address ${(widget.addressListLength + 1).toString()}"
                            )
                        );
                      }
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        getSnackBar(
                          context,
                          "Please enteryour phone number in this format: +370xxxxxxxx"
                        )
                      );
                    }
                  }
              }),
              widget.update ? BlocBuilder<SelectAddressStreamBloc, addStream.SelectAddressStreamState>(
                builder: (context, state){
                  return getConfirmationButton(
                    buttonName: "Remove",
                    onPressed: state is addStream.AddressState ? (){
                      if(state.addressList.length <= 1){
                        ScaffoldMessenger.of(context).showSnackBar(
                          getSnackBar(
                            context,
                            "Address cannot be deleted, becasue it is assigned to your current cart. Try to change cart delivery address and then try again"
                          )
                        );
                      }else{
                        Navigator.pop(context);
                        BlocProvider.of<AddressBloc>(context).removeUserAddress(
                            (BlocProvider.of<AuthBloc>(context).state as UserState).uid,
                            widget.addressModel!.firebaseName
                        );
                      }
                    } : null,
                    buttonColor: Colors.grey.shade300,
                    buttonNameColor: Colors.black87
                  );
                },
              ): const SizedBox(height: 0.0, width: 0.0,)
            ],
          ),
        ),
      ),
    );
  }

  String _getUserUid(BuildContext context){
    return (BlocProvider.of<AuthBloc>(context).state as UserState).uid;
  }

  _buildTextField(
      String fieldName,
      IconData icon, {
        bool validate = false,
        required TextEditingController controller,
        bool enabled = true,
        TextInputType keyboardType = TextInputType.text
      }
    ) => Padding(
        child: TextFormField(
          keyboardType: keyboardType,
          validator: (val) => (validate && (val == null || val.isEmpty))
              ? "This field is required" : null,
          decoration: InputDecoration(
              prefixIcon: Padding(
                child: Icon(icon),
                padding: const EdgeInsets.only(right: 5.0),
              ),
              hintText: fieldName,
              //contentPadding: EdgeInsets.symmetric(horizontal: 5.0)
              enabled: enabled
          ),
          controller: controller,
        ),
    padding: const EdgeInsets.symmetric(vertical: 8.0),
  );

  _buildTextFieldRow(
      BuildContext context,
      String field1Name,
      String field2Name,
      TextEditingController controller1,
      TextEditingController controller2
    ) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
        children: [
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: field1Name,
                  contentPadding: const EdgeInsets.only(left: 5.0)
                ),
                controller: controller1,
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: field2Name,
                  contentPadding: const EdgeInsets.only(left: 5.0)
                ),
                controller: controller2,
              ),
            ),
          )
        ],
      ),
  );
}
