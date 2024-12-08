part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class LoadOrders extends OrderEvent {}

class LoadOrderDetails extends OrderEvent {
  final String orderId;

  LoadOrderDetails(this.orderId);

  @override
  List<Object> get props => [orderId];
}

class OrderDetails extends OrderEvent {
  final Order order;

  OrderDetails(this.order);

  @override
  List<Object> get props => [order];
}

class UpdateOrderStatus extends OrderEvent {
  final String orderId;
  final String status;

  UpdateOrderStatus(this.orderId, this.status);

  @override
  List<Object> get props => [orderId, status];
}

class UpdateOrderDate extends OrderEvent {
  final String orderId;
  final DateTime date;

  UpdateOrderDate(this.orderId, this.date);

  @override
  List<Object> get props => [orderId, date];
}

class UpdateOrderTotalAmount extends OrderEvent {
  final String orderId;
  final double totalAmount;

  UpdateOrderTotalAmount(this.orderId, this.totalAmount);

  @override
  List<Object> get props => [orderId, totalAmount];
}

class UpdateOrderPaymentMethod extends OrderEvent {
  final String orderId;
  final String paymentMethod;

  UpdateOrderPaymentMethod(this.orderId, this.paymentMethod);

  @override
  List<Object> get props => [orderId, paymentMethod];
}

class UpdateOrderIsPaid extends OrderEvent {
  final String orderId;
  final bool isPaid;

  UpdateOrderIsPaid(this.orderId, this.isPaid);

  @override
  List<Object> get props => [orderId, isPaid];
}

class UpdateOrderCustomer extends OrderEvent {
  final String orderId;
  final String name;
  final String phone;
  final String address;
  final String gender;

  UpdateOrderCustomer(this.orderId, this.name, this.phone, this.address, this.gender);

  @override
  List<Object> get props => [orderId, name, phone, address, gender];
}

class UpdateOrderItems extends OrderEvent {
  final String orderId;
  final List<Order> items;

  UpdateOrderItems(this.orderId, this.items);

  @override
  List<Object> get props => [orderId, items];
}

