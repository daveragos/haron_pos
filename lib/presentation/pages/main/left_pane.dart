import 'package:flutter/material.dart';
import 'package:haron_pos/config/theme.dart';
import 'package:sidebarx/sidebarx.dart';

class LeftPaneDrawer extends StatelessWidget {
  final SidebarXController controller;

  const LeftPaneDrawer({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      showToggleButton: false,
      controller: controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppTheme.highlightColor,
          borderRadius: BorderRadius.circular(20),
        ),
        textStyle: const TextStyle(color: Colors.white),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 20),
        selectedItemDecoration: BoxDecoration(
          color: AppTheme.accentColor,
          borderRadius: BorderRadius.circular(10),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 24,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 28,
        ),
      ),
      items: const [
        SidebarXItem(icon: Icons.home, label: 'Home'),         // Index 0
        SidebarXItem(icon: Icons.shopping_cart, label: 'Orders'), // Index 1
        SidebarXItem(icon: Icons.category, label: 'Categories'), // Index 2
        SidebarXItem(icon: Icons.settings, label: 'Settings'), // Index 3
      ],
    );
  }
}

