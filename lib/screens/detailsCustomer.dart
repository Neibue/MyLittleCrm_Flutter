import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylittlecrm/logic/bloc/customers_bloc.dart';
import 'package:mylittlecrm/screens/addEditCustomerScreen.dart';

class DetailCustomer extends StatelessWidget {
  final int id;

  DetailCustomer({Key key, @required this.id})
      : super(key: key ?? Key("__detailsscreen__"));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomersBloc, CustomersState>(
      builder: (context, state) {
        final customer = (state as CustomersLoadSuccess).customers.firstWhere(
              (element) => element.id == id,
              orElse: () => null,
            );
        return Scaffold(
          appBar: AppBar(
            title: Text("Details"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(customer.name),
                SizedBox(
                  height: 25,
                ),
                Text(customer.mobilePhone),
                SizedBox(
                  height: 25,
                ),
                Text(customer.officePhone),
                SizedBox(
                  height: 25,
                ),
                Text(customer.company.name),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.edit),
            onPressed: customer == null
                ? null
                : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return AddEditCustomer(
                            isEditing: true,
                            onSave: (c) {
                              BlocProvider.of<CustomersBloc>(context)
                                  .add(CustomerUpdated(customer.copyWith(c)));
                            },
                            customer: customer,
                          );
                        },
                      ),
                    );
                  },
          ),
        );
      },
    );
  }
}
