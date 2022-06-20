import 'package:flutter/cupertino.dart';
import 'package:users_app/models/address.dart';

class AppData extends ChangeNotifier
{
  Address? pickUpLocation;

  void updatePickUpLocationAddress(Address pickUpAdress)
  {
    pickUpLocation = pickUpAdress;
    notifyListeners();
  }
}