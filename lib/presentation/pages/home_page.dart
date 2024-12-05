import 'package:flutter/material.dart';
import 'package:haron_pos/presentation/pages/center_pane.dart';
import 'package:haron_pos/presentation/pages/left_pane.dart';
import 'package:haron_pos/presentation/pages/right_pane.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('POS System'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Transactions'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (index) {
          // Handle navigation logic here
        },
      ),
      body: const Row(
        children: [
          // Left Pane
          Expanded(
            flex: 1,
            child: LeftPane(),
          ),

          // Center Pane
          Expanded(
            flex: 3,
            child: CenterPane(),
          ),

          // Right Pane
          Expanded(
            flex: 1,
            child: RightPane()
          ),
        ],
      ),
    );
  }
}
