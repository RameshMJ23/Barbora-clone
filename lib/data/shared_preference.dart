

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference{

  static late SharedPreferences _preference;
  static const _addressKey = "addressKey";
  static const _pickUpLocationKey = "pickUpLocationKey";
  static const _dayValue = "dayValue";
  static const _timeValue = "timeValue";

  static Future initPreference() async{
    return _preference = await SharedPreferences.getInstance();
  }

  static setAddressIndex(int index) async{
    await _preference.setInt(_addressKey, index);
  }

  static setPickupLocationIndex(int index) async{
    await _preference.setInt(_pickUpLocationKey, index);
  }

  static getAddressIndex() => _preference.getInt(_addressKey);

  static getPickUpLocationIndex() => _preference.getInt(_pickUpLocationKey);

  static setReservationValue(int dayValue, int timeValue) async{
    await _preference.setInt(_dayValue, dayValue);
    await _preference.setInt(_timeValue, timeValue);
  }

  static getReservationDayValue() => _preference.getInt(_dayValue);

  static getReservationTimeValue() => _preference.getInt(_timeValue);


}