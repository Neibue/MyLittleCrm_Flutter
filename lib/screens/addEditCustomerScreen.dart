import 'package:flutter/material.dart';
import 'package:mylittlecrm/data/model/customer.dart';

typedef OnSaveCallback = Function(Customer customer);

class AddEditCustomer extends StatefulWidget {
  final bool isEditing;
  final Customer customer;
  final OnSaveCallback onSave;

  AddEditCustomer({
    Key key,
    @required this.isEditing,
    @required this.onSave,
    Customer customer,
  }) : this.customer = customer ?? new Customer();

  @override
  State<StatefulWidget> createState() => _AddEditCustomerState();
}

class _AddEditCustomerState extends State<AddEditCustomer> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Customer get _customer => widget.customer;

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Update Customer" : "Add Customer"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: isEditing ? widget.customer.name : '',
                decoration: InputDecoration(
                  hintText: "Name of the Customer",
                ),
                validator: (val) =>
                    val.trim().isEmpty ? "The name is required." : null,
                onSaved: (val) => _customer.name = val,
              ),
              TextFormField(
                initialValue: isEditing ? widget.customer.mobilePhone : '',
                decoration: InputDecoration(
                  hintText: "Mobile of the Customer",
                ),
                validator: (val) =>
                    val.trim().isEmpty ? "The Mobile is required." : null,
                onSaved: (val) => _customer.mobilePhone = val,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isEditing ? Icons.edit : Icons.add),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            widget.onSave(_customer);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
