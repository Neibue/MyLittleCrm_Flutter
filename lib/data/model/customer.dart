import './company.dart';

class Customer {
  int id;
  String name;
  String officePhone;
  String mobilePhone;
  String address;
  Company company;

  Customer(
      {this.id,
      this.name,
      String officePhone = '',
      String mobilePhone,
      String address,
      Company company})
      : this.officePhone = officePhone ?? '',
        this.mobilePhone = mobilePhone ?? '',
        this.address = address ?? '',
        this.company = company ?? new Company();

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
        id: json['id'],
        name: json['name'],
        officePhone: json['officePhone'],
        mobilePhone: json['mobilePhone'],
        address: json['address'],
        company: Company.fromJson(json['company']));
  }

  Customer copyWith(Customer c) {
    return Customer(
      address: c.address ?? this.address,
      name: c.name ?? this.name,
      company: c.company ?? this.company,
      id: c.id ?? this.id,
      mobilePhone: c.mobilePhone ?? this.mobilePhone,
      officePhone: c.officePhone ?? this.officePhone,
    );
  }
}
