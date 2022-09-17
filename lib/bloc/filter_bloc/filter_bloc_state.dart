
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:equatable/equatable.dart';

enum FilterScreenEnum{
  startScreen,
  discount,
  country,
  brand
}

class FilterBlocState extends Equatable{

  FilterScreenEnum filterScreenEnum;

  DiscountOptionsEnum discountOptionsEnum;

  int country;

  int brand;

  FilterBlocState({
    required this.filterScreenEnum,
    this.discountOptionsEnum = DiscountOptionsEnum.none,
    this.brand = -1,
    this.country = -1
  });

  @override
  // TODO: implement props
  List<Object?> get props => [filterScreenEnum, discountOptionsEnum, country, brand];
}