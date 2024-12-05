import 'package:flutter/material.dart';

class RightPane extends StatefulWidget {
  const RightPane({super.key});

  @override
  State<RightPane> createState() => _RightPaneState();
}

class _RightPaneState extends State<RightPane> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).secondaryHeaderColor,
      child: const Column(
        children:[
          Center(
            child: Text('right pane')
          )
        ]
      ),
    );
  }
}