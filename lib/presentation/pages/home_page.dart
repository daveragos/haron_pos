import 'package:flutter/material.dart';
import 'package:haron_pos/config/theme.dart';
import 'package:haron_pos/presentation/pages/center_pane.dart';
import 'package:haron_pos/presentation/pages/left_pane.dart';
import 'package:haron_pos/presentation/pages/right_pane.dart';
import 'package:sidebarx/sidebarx.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final SidebarXController _controller = SidebarXController(selectedIndex: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.accentColor.withOpacity(0.5),
      appBar: AppBar(
        title: const Text('POS System'),

      ),
      // drawer: Drawer(
      //   child: LeftPaneDrawer(controller: _controller),
      // ),
      body: Row(
        children: [
          // Optional: If you want SidebarX fixed to the side, not as a drawer
          SizedBox(
            width: 250,
            child: LeftPaneDrawer(controller: _controller),
          ),
          Expanded(
            flex: 2,
            child: CenterPane(),
          ),
          Expanded(child:RightPane(),),
        ],
      ),
    );
  }
}

