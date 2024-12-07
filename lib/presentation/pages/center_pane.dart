import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haron_pos/presentation/blocs/product/product_bloc.dart';
import 'package:haron_pos/presentation/blocs/product/product_event.dart';
import 'package:haron_pos/presentation/blocs/product/product_state.dart';


class CenterPane extends StatefulWidget {
  const CenterPane({super.key});

  @override
  State<CenterPane> createState() => _CenterPaneState();
}

class _CenterPaneState extends State<CenterPane> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductLoaded) {
          final categories = ['All', ...state.categories.map((c) => c.name)];

          // Rebuild the TabController if the number of tabs changes
          if (_tabController.length != categories.length) {
            _tabController.dispose();
            _tabController = TabController(length: categories.length, vsync: this);
          }

          return Column(
            children: [
              TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                indicatorColor: Colors.orange,
                tabs: categories.map((name) => Tab(text: name)).toList(),
                onTap: (index) {
                  final category = categories[index];
                  context.read<ProductBloc>().add(FilterProductsByCategory(category));
                },
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return Card(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/${product.id}.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(product.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                Text('\$${product.price.toStringAsFixed(2)}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state is ProductError) {
          return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
        } else {
          return const Center(child: Text("Unknown state"));
        }
      },
    );
  }
}
