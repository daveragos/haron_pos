part of 'categories_bloc.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoading extends CategoriesState {}

final class CategoriesLoadedState extends CategoriesState {
  const CategoriesLoadedState({required this.categories});

  final List<Category> categories;

  @override
  List<Object> get props => [categories];
}

final class CategoriesError extends CategoriesState {
  const CategoriesError({required this.error});
  final String error;

  @override
  List<Object> get props => [error];
}
