
import 'package:barboraapp/data/models/address_model.dart';
import 'package:equatable/equatable.dart';

class SelectAddressStreamState extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingAddressState extends SelectAddressStreamState{

}

class AddressState extends SelectAddressStreamState{

  List<AddressModel> addressList;

  AddressState({required this.addressList});

  @override
  // TODO: implement props
  List<Object?> get props => [addressList];
}