import 'package:flutter/material.dart';

class CenterPane extends StatefulWidget {
  const CenterPane({super.key});

  @override
  State<CenterPane> createState() => _CenterPaneState();
}

class _CenterPaneState extends State<CenterPane> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: const Column(
        children: [
          Center(
            child: Text('Center Pane')
          )
        ]
      ),
    );
  }
}