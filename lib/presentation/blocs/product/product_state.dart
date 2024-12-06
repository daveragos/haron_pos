// product_state.dart
import 'package:equatable/equatable.dart';
import 'package:haron_pos/data/model/category.dart';
import 'package:haron_pos/data/model/product.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final List<Category> categories;

  ProductLoaded(this.products, this.categories);

  @override
  List<Object> get props => [products, categories];
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);

  @override
  List<Object> get props => [message];
}
