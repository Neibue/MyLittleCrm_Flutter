import 'package:flutter/services.dart';

class CustomerLocalData {
  Future<String> getRawCustomerLocalData() async {
    try {
      var rawData = await rootBundle.loadString("assets/data.json");
      return rawData;
    } catch (_) {
      return _.toString();
    }
  }
}
