import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:mylittlecrm/data/model/customer.dart';
import 'package:mylittlecrm/data/repositories/customerRepository.dart';

part 'customers_event.dart';
part 'customers_state.dart';

class CustomersBloc extends Bloc<CustomersEvent, CustomersState> {
  final CustomerRepository customerRepository;

  CustomersBloc({@required this.customerRepository})
      : super(CustomersLoadInProgress());

  @override
  Stream<CustomersState> mapEventToState(
    CustomersEvent event,
  ) async* {
    if (event is CustomersLoaded) {
      yield* _mapCustomersLoadedToState();
    } else if (event is CustomerAdded) {
      yield* _mapCustomersAddedToState(event);
    } else if (event is CustomerUpdated) {
      yield* _mapCustomersUpdatedToState(event);
    }
  }

  Stream<CustomersState> _mapCustomersLoadedToState() async* {
    try {
      final customers = await this.customerRepository.getCustomers();
      yield CustomersLoadSuccess(customers);
    } catch (_) {
      print(_.toString());
      yield CustomersLoadFailure();
    }
  }

  Stream<CustomersState> _mapCustomersAddedToState(CustomerAdded event) async* {
    if (state is CustomersLoadSuccess) {
      event.customer.id =
          List.from((state as CustomersLoadSuccess).customers).length + 1;
      final List<Customer> updatedCustomers =
          List.from((state as CustomersLoadSuccess).customers)
            ..add(event.customer);
      yield CustomersLoadSuccess(updatedCustomers);
      //_saveCustomers(updatedCustomers);
    }
  }

  Stream<CustomersState> _mapCustomersUpdatedToState(
      CustomerUpdated event) async* {
    if (state is CustomersLoadSuccess) {
      final List<Customer> updatedCustomers =
          (state as CustomersLoadSuccess).customers.map((customer) {
        return customer.id == event.customer.id ? event.customer : customer;
      }).toList();
      yield CustomersLoadSuccess(updatedCustomers);
      //_saveCustomers(updatedCUstomers);
    }
  }
}
