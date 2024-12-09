import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:haron_pos/data/model/order.dart';
import 'package:haron_pos/data/repository/order_repo.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  List<Order> allOrders = [];
  List<Order> orders = [];
  List<Order> items = [];

  OrderBloc() : super(OrderInitial()) {
    on<OrderEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LoadOrders>(_onLoadOrders);

    // on<LoadOrderDetails>(_onLoadOrderDetails);

    // on<UpdateOrderStatus>(_onUpdateOrderStatus);

    // on<UpdateOrderDate>(_onUpdateOrderDate);

    // on<UpdateOrderTotalAmount>(_onUpdateOrderTotalAmount);

    // on<UpdateOrderPaymentMethod>(_onUpdateOrderPaymentMethod);

    // on<UpdateOrderIsPaid>(_onUpdateOrderIsPaid);

    // on<UpdateOrderCustomer>(_onUpdateOrderCustomer);

    // on<UpdateOrderItems>(_onUpdateOrderItems);
  }


  Future<void> _onLoadOrders(LoadOrders event, Emitter<OrderState> emit) async {
    try {
      emit(OrderLoading());
      final List<Order> orders = await getAllOrders();
      allOrders = orders;


      emit(OrderLoaded(allOrders));
    } catch (e) {
      emit(OrderError("Failed to load data: ${e.toString()}"));
    }
  }

  // Future<void> _onLoadOrderDetails(LoadOrderDetails event, Emitter<OrderState> emit) async {
  //   try {
  //     emit(OrderLoading());

  //     // Load data from JSON
  //     final String response = await rootBundle.loadString('assets/dummy.json');
  //     final Map<String, dynamic> data = json.decode(response);

  //     // Parse orders
  //     final List<Order> orders = (data['orders'] as List)
  //         .map((order) => Order.fromJson(order))
  //         .toList();

  //     // Find the order with the given ID
  //     final order = orders.firstWhere((order) => order.id == event.orderId);

  //     // Parse items
  //     final List<Order> items = (data['transactions'] as List)
  //         .map((item) => Order.fromJson(item))
  //         .toList();

  //     emit(LoadOrderDetails(order.id.toString(), order, items));
  //   } catch (e) {
  //     emit(OrderError("Failed to load data: ${e.toString()}"));
  //   }
  // }

  // void _onUpdateOrderStatus(UpdateOrderStatus event, Emitter<OrderState> emit) {
  //   final order = allOrders.firstWhere((order) => order.id == event.orderId);
  //   order.status = event.status;
  //   emit(OrderLoaded(allOrders));
  // }

  // void _onUpdateOrderDate(UpdateOrderDate event, Emitter<OrderState> emit) {
  //   final order = allOrders.firstWhere((order) => order.id == event.orderId);
  //   order.date = event.date;
  //   emit(OrderLoaded(allOrders));
  // }

  // void _onUpdateOrderTotalAmount(UpdateOrderTotalAmount event, Emitter<OrderState> emit) {
  //   final order = allOrders.firstWhere((order) => order.id == event.orderId);
  //   order.totalAmount = event.totalAmount;
  //   emit(OrderLoaded(allOrders));
  // }


}
