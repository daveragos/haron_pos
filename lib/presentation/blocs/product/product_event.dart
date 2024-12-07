// product_event.dart
import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadProducts extends ProductEvent {}

class FilterProductsByCategory extends ProductEvent {
  final String category;

  FilterProductsByCategory(this.category);

  @override
  List<Object> get props => [category];
}

class DetailsOfProduct extends ProductEvent {
  final String productId;

  DetailsOfProduct(this.productId);

  @override
  List<Object> get props => [productId];
}

class AddToCart extends ProductEvent {
  final String productId;

  AddToCart(this.productId);

  @override
  List<Object> get props => [productId];
}

class RemoveFromCart extends ProductEvent {
  final String productId;

  RemoveFromCart(this.productId);

  @override
  List<Object> get props => [productId];
}

class UpdateQuantity extends ProductEvent {
  final String productId;
  final int quantity;

  UpdateQuantity(this.productId, this.quantity);

  @override
  List<Object> get props => [productId, quantity];
}

class ClearCart extends ProductEvent {}

class Checkout extends ProductEvent {}

class ClearCheckout extends ProductEvent {}

class UpdateShippingAddress extends ProductEvent {
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String country;

  UpdateShippingAddress(this.address, this.city, this.state, this.zipCode, this.country);

  @override
  List<Object> get props => [address, city, state, zipCode, country];
}

class UpdatePaymentMethod extends ProductEvent {
  final String paymentMethod;

  UpdatePaymentMethod(this.paymentMethod);

  @override
  List<Object> get props => [paymentMethod];
}

class UpdateOrderType extends ProductEvent {
  final String orderType;

  UpdateOrderType(this.orderType);

  @override
  List<Object> get props => [orderType];
}

class UpdateCustomer extends ProductEvent {
  final String name;
  final String phone;
  final String address;
  final String gender;

  UpdateCustomer(this.name, this.phone, this.address, this.gender);

  @override
  List<Object> get props => [name, phone, address, gender];
}

class UpdateTotalAmount extends ProductEvent {
  final double totalAmount;

  UpdateTotalAmount(this.totalAmount);

  @override
  List<Object> get props => [totalAmount];
}

class UpdateIsPaid extends ProductEvent {
  final bool isPaid;

  UpdateIsPaid(this.isPaid);

  @override
  List<Object> get props => [isPaid];
}

class UpdateOrderDate extends ProductEvent {
  final DateTime orderDate;

  UpdateOrderDate(this.orderDate);

  @override
  List<Object> get props => [orderDate];
}
