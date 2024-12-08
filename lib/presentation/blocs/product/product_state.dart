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

class ProductDetails extends ProductState {
  final Product product;

  ProductDetails(this.product);

  @override
  List<Object> get props => [product];
}

class ProductCart extends ProductState {
  final List<Product> products;

  ProductCart(this.products);

  @override
  List<Object> get props => [products];
}

class ProductCheckout extends ProductState {
  final List<Product> products;

  ProductCheckout(this.products);

  @override
  List<Object> get props => [products];
}

class ProductOrder extends ProductState {

  final List<Product> products;

  ProductOrder(this.products);

  @override
  List<Object> get props => [products];
}