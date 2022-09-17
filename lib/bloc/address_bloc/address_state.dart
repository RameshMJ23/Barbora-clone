
import 'package:equatable/equatable.dart';

class AddressState extends Equatable{

  String? citySelected;

  int iconIndex;

  AddressState({required this.citySelected, required this.iconIndex});

  @override
  // TODO: implement props
  List<Object?> get props => [citySelected, iconIndex];
}
