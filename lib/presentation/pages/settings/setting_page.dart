import 'package:flutter/material.dart';
import 'package:haron_pos/presentation/pages/settings/list_settings_page.dart';
import 'package:sidebarx/sidebarx.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SidebarXController _controller = SidebarXController(selectedIndex: 0, extended: true);

  final List<Widget> settings = [
    Container(color: Colors.yellow), // Index 0
    Container(color: Colors.blue),   // Index 1
    Container(color: Colors.red),    // Index 2
    Container(color: Colors.green), // Index 3
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: ListSetting(controller: _controller)),
        // Use AnimatedBuilder to rebuild when the controller changes
        Expanded(
          flex: 3,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return settings[_controller.selectedIndex];
            },
          ),
        ),
      ],
    );
  }
}
