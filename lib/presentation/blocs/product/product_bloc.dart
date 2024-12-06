import 'dart:convert';
import 'package:flutter/services.dart'; // For rootBundle
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haron_pos/data/model/category.dart';
import 'package:haron_pos/data/model/product.dart';
import 'package:haron_pos/presentation/blocs/product/product_event';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  List<Product> allProducts = [];
  List<Category> allCategories = [];

  ProductBloc() : super(ProductLoading()) {

    on<LoadProducts>(_onLoadProducts);

    on<FilterProductsByCategory>(_onFilterProductsByCategory);

  }

  Future<void> _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
    try {
      emit(ProductLoading());

      // Load data from JSON
      final String response = await rootBundle.loadString('assets/dummy.json');
      final Map<String, dynamic> data = json.decode(response);

      // Parse categories and products
      allCategories = (data['categories'] as List)
          .map((category) => Category.fromJson(category))
          .toList();
      allProducts = (data['products'] as List)
          .map((product) => Product.fromJson(product))
          .toList();

      emit(ProductLoaded(allProducts, allCategories));
    } catch (e) {
      emit(ProductError("Failed to load data: ${e.toString()}"));
    }
  }

  void _onFilterProductsByCategory(FilterProductsByCategory event, Emitter<ProductState> emit) {
    final filteredProducts = allProducts
        .where((product) =>
            event.category == 'All' || product.category == event.category)
        .toList();
    emit(ProductLoaded(filteredProducts, allCategories));
  }
}
