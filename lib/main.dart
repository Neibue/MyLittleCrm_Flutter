import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylittlecrm/data/repositories/customerRepository.dart';
import 'package:mylittlecrm/logic/bloc/customers_bloc.dart';
import 'package:mylittlecrm/screens/addEditCustomerScreen.dart';
import 'package:mylittlecrm/screens/detailsCustomer.dart';

void main() {
  runApp(BlocProvider(
    create: (context) {
      return CustomersBloc(customerRepository: CustomerRepository())
        ..add(CustomersLoaded());
    },
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Little CRM",
      routes: {
        "/": (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text("My Little CRM"),
            ),
            body: MyHomePage(),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => Navigator.pushNamed(context, "/addCustomer"),
            ),
          );
        },
        "/addCustomer": (context) {
          ///
          ///
          return AddEditCustomer(
            isEditing: false,
            key: Key("__addEditCustomer__"),
            onSave: (c) =>
                BlocProvider.of<CustomersBloc>(context).add(CustomerAdded(c)),
          );
        }
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomersBloc, CustomersState>(
      builder: (context, state) {
        if (state is CustomersLoadSuccess) {
          final customers = state.customers;
          return ListView.builder(
            key: Key("test"),
            itemCount: customers.length,
            itemBuilder: (BuildContext context, int index) {
              final customer = customers[index];
              return ListTile(
                title: Text(customer.name),
                onTap: () async {
                  await Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) {
                    return DetailCustomer(id: customer.id);
                  }));
                },
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
