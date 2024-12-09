import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haron_pos/presentation/blocs/order/order_bloc.dart';
import 'package:haron_pos/presentation/pages/order_page/order_details_page.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrderLoaded) {
          return Column(
            children: [
              const Text("Orders"),
              Expanded(
                child: ListView.builder(
                  itemCount: state.orders.length,
                  itemBuilder: (context, index) {
                    final order = state.orders[index];
                    return ListTile(

                      leading: const Icon(Icons.shopping_cart),
                      title: Text('Order #${order.id.toString().substring(order.id.toString().length - 4)}'),
                      subtitle: Text(order.totalAmount.toString()),
                      onTap: () {
                        showModalBottomSheet(

                          context: context,
                          builder: (context) {
                            return OrderDetailsPage(order: order);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        }
        if (state is OrderError) {
          return Center(
              child: Text(state.message,
                  style: const TextStyle(color: Colors.red)));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}