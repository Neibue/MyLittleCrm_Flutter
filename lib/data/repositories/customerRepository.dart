import 'dart:convert';

import 'package:mylittlecrm/data/model/customer.dart';
import 'package:mylittlecrm/data/providers/customerLocalData.dart';

class CustomerRepository {
  final CustomerLocalData customerProvider = new CustomerLocalData();

  CustomerRepository();

  Future<List<Customer>> getCustomers() async {
    var rawData = await customerProvider.getRawCustomerLocalData();

    var jsonData = jsonDecode(rawData) as List;

    final List<Customer> customers =
        jsonData.map((c) => new Customer.fromJson(c)).toList();

    return customers;
  }
}
