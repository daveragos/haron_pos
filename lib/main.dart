import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haron_pos/config/theme.dart';
import 'package:haron_pos/presentation/blocs/product/product_bloc.dart';
import 'package:haron_pos/presentation/blocs/product/product_event';
import 'package:haron_pos/presentation/pages/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: BlocProvider(
        create: (context) => ProductBloc()..add(LoadProducts()),
        child: HomePage(),
      ),
    );
  }
}
