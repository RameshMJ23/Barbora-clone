enum SortEnum{
  defaultSort,
  ascendingOrder,
  descendingOrder,
  priceFromLowest,
  priceFromHighest,
  withoutDiscountFirst,
  withDiscountFirst
}

class SortModel{

  String sortTitle;

  SortEnum sortValue;

  SortModel({required this.sortTitle, required this.sortValue});

}