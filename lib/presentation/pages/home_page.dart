import 'package:flutter/material.dart';
import 'package:haron_pos/config/theme.dart';
import 'package:haron_pos/presentation/pages/center_pane.dart';
import 'package:haron_pos/presentation/pages/left_pane.dart';
import 'package:haron_pos/presentation/pages/right_pane.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.accentColor,
      body: const Row(
        children: [
          // Left Pane
          Expanded(
            flex: 1,
            child: LeftPane(),
          ),

          // Center Pane
          Expanded(
            flex: 7,
            child: CenterPane(),
          ),

          // Right Pane
          Expanded(
            flex: 3,
            child: RightPane()
          ),
        ],
      ),
    );
  }
}
