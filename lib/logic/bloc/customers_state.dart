part of 'customers_bloc.dart';

@immutable
abstract class CustomersState extends Equatable {
  const CustomersState();

  @override
  List<Object> get props => [];
}

class CustomersLoadInProgress extends CustomersState {}

class CustomersLoadSuccess extends CustomersState {
  final List<Customer> customers;

  const CustomersLoadSuccess([this.customers = const []]);

  @override
  List<Object> get props => [customers];
}

class CustomersLoadFailure extends CustomersState {}
