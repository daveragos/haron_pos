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

  List<Widget> settings = [
    Container(color: Colors.yellow),
    Container(color: Colors.blue),
    Container(color: Colors.red),
    Container(color: Colors.green),
  ];
  @override
  Widget build(BuildContext context) {
    return Row(
      children:[
        Expanded(flex: 1, child: ListSetting(controller: _controller)),
        Expanded(flex: 3, child: settings[_controller.selectedIndex]),
      ]
    );
  }
}
