import 'package:flutter/material.dart';

class AddressProvider with ChangeNotifier {
  final List<Map<String, String>> _addresses = [
    {'label': 'Home', 'address': '123 Main Street, Apt 4B\nNew York, NY 10001'},
    {
      'label': 'Work',
      'address': '456 Business Blvd, Suite 200\nSan Francisco, CA 94107',
    },
  ];

  List<Map<String, String>> get addresses => [..._addresses];

  void addAddress(String label, String address) {
    _addresses.add({'label': label, 'address': address});
    notifyListeners();
  }

  void removeAddress(int index) {
    _addresses.removeAt(index);
    notifyListeners();
  }
}
