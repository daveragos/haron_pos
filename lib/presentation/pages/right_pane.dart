import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haron_pos/presentation/blocs/product/product_bloc.dart';
import 'package:haron_pos/presentation/blocs/product/product_state.dart';

class RightPane extends StatelessWidget {
  const RightPane({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey.withOpacity(0.2),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Item'),
                Text('Quantity'),
                Text('Price'),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoaded) {
                  return ListView.builder(
                    itemCount: context.read<ProductBloc>().cartProducts.length,
                    itemBuilder: (context, index) {
                      final product =
                          context.read<ProductBloc>().cartProducts[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(product.name),
                          Text(product.quantity.toString()),
                          Text('\$${(product.price * product.quantity).toStringAsFixed(2)}'),
                        ],
                      );
                    },
                  );
                }
                return const Center(child: Text("Cart is empty"));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoaded) {
                  final total = context
                      .read<ProductBloc>()
                      .cartProducts
                      .fold(0.0, (sum, product) => sum + product.price * product.quantity);
                  return Text('Total: \$${total.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold));
                }
                return const SizedBox();
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // context.read<ProductBloc>().add(Checkout());
            },
            child: const Text('Checkout'),
          ),
        ],
      ),
    );
  }
}
