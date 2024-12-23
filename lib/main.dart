import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haron_pos/config/theme.dart';
import 'package:haron_pos/data/model/order.dart';
import 'package:haron_pos/data/model/product.dart';
import 'package:haron_pos/presentation/blocs/bloc/categories_bloc.dart';
import 'package:haron_pos/presentation/blocs/bloc_observer.dart';
import 'package:haron_pos/presentation/blocs/order/order_bloc.dart';
import 'package:haron_pos/presentation/blocs/product/product_bloc.dart';
import 'package:haron_pos/presentation/blocs/product/product_event.dart';
import 'package:haron_pos/presentation/pages/main/main_page.dart';
import 'package:hive_flutter/adapters.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(OrderAdapter());
  Hive.registerAdapter(ProductAdapter());
  Bloc.observer = MyBlocObserver();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProductBloc()..add(LoadProducts()),
          ),
          BlocProvider(
            create: (context) => OrderBloc()..add(LoadOrders()),
          ),
          BlocProvider(
            create: (context) => CategoriesBloc()..add(LoadCategories()),
          ),
        ],
        child: MainPage(),
      ),
    );
  }
}
