import 'package:flutter/material.dart';
import 'package:haron_pos/config/theme.dart';
import 'package:sidebarx/sidebarx.dart';

class LeftPaneDrawer extends StatelessWidget {
  final SidebarXController controller;

  const LeftPaneDrawer({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppTheme.accentColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: Colors.black,
        textStyle: const TextStyle(color: Colors.white),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 20),
        selectedItemDecoration: BoxDecoration(
          color: Colors.blueGrey.shade700,
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
      extendedTheme: SidebarXTheme(
        width: 200,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppTheme.accentColor,
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      items: const [
        SidebarXItem(
          icon: Icons.home,
          label: 'Home',
        ),
        SidebarXItem(
          icon: Icons.shopping_cart,
          label: 'Orders',
        ),
        SidebarXItem(
          icon: Icons.category,
          label: 'Categories',
        ),
        SidebarXItem(
          icon: Icons.settings,
          label: 'Settings',
        ),
      ],
      footerItems: const [
        SidebarXItem(
          icon: Icons.logout,
          label: 'Logout',
        ),
      ],
    );
  }
}
