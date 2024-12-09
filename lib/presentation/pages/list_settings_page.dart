import 'package:flutter/material.dart';
import 'package:haron_pos/config/theme.dart';
import 'package:sidebarx/sidebarx.dart';

class ListSetting extends StatefulWidget {
  final SidebarXController controller;

  const ListSetting({super.key, required this.controller});

  @override
  State<ListSetting> createState() => _ListSettingState();
}

class _ListSettingState extends State<ListSetting> {
  @override
  Widget build(BuildContext context) {
    return SidebarX(
      showToggleButton: false,

      controller: widget.controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppTheme.secondaryColor,
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
      items:  [
        SidebarXItem(icon: Icons.looks, label: 'Appereance',),        // Index 0
        SidebarXItem(icon: Icons.payment, label: 'Payment'), // Index 1
        SidebarXItem(icon: Icons.store, label: 'Products'), // Index 2
        SidebarXItem(icon: Icons.person, label: 'Profile'), // Index 3
      ],
    );
  }
}