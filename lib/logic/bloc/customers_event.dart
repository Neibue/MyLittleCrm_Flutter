part of 'customers_bloc.dart';

@immutable
abstract class CustomersEvent extends Equatable {
  const CustomersEvent();

  @override
  List<Object> get props => [];
}

class CustomersLoaded extends CustomersEvent {}

class CustomerAdded extends CustomersEvent {
  final Customer customer;

  const CustomerAdded(this.customer);

  @override
  List<Object> get props => [customer];

  @override
  String toString() => 'CustomerAdded : { $customer }';
}

class CustomerUpdated extends CustomersEvent {
  final Customer customer;

  const CustomerUpdated(this.customer);

  @override
  List<Object> get props => [customer];

  @override
  String toString() => 'CustomerUpdated : { $customer }';
}
