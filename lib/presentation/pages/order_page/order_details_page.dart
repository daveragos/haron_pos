import 'package:flutter/material.dart';
import 'package:haron_pos/data/model/order.dart';
class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key, required this.order});
  final Order order;

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min, // Allow the column to shrink-wrap its children
        children: [
          Text(widget.order.totalAmount.toString()),
          const Divider(),
          // Wrap ListView.builder with Flexible or SizedBox
          SizedBox(
            height: 400, // Adjust the height as needed
            child: ListView.builder(
              itemCount: widget.order.products.length,
              itemBuilder: (context, index) {
                final item = widget.order.products[index];
                return ListTile(
                  leading: Image.asset(
                    'assets/pictures/${item.id}.jpg',
                    width: 50,
                    height: 50,
                  ),
                  title: Text(item.name),
                  subtitle: Text(item.price.toString()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
