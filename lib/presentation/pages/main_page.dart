import 'package:flutter/material.dart';
import 'package:haron_pos/config/theme.dart';
import 'package:haron_pos/presentation/pages/categories_page.dart';
import 'package:haron_pos/presentation/pages/center_pane.dart';
import 'package:haron_pos/presentation/pages/left_pane.dart';
import 'package:haron_pos/presentation/pages/order_page.dart';
import 'package:haron_pos/presentation/pages/setting_page.dart';
import 'package:sidebarx/sidebarx.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final SidebarXController _controller = SidebarXController(selectedIndex: 0, extended: true);

  final List<Widget> _pages = [
    const CenterPane(), // Replace with your HomePage
    const OrdersPage(), // Replace with your OrdersPage
    const CategoriesPage(), // Replace with your CategoriesPage
    const SettingsPage(), // Replace with your SettingsPage
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.accentColor.withOpacity(0.5),
      appBar: AppBar(
        title: const Text('Haron POS'),
      ),
      body: Row(
        children: [
          // SidebarX navigation
          SizedBox(
            width: 250,
            child: LeftPaneDrawer(controller: _controller),
          ),
          // Display the selected page
          Expanded(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return _pages[_controller.selectedIndex];
              },
            ),
          ),
        ],
      ),
    );
  }
}
