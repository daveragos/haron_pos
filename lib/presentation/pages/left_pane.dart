import 'package:flutter/material.dart';

class LeftPane extends StatefulWidget {
  const LeftPane({super.key});

  @override
  State<LeftPane> createState() => _LeftPaneState();
}

class _LeftPaneState extends State<LeftPane> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).secondaryHeaderColor,
      child: const Column(
        children:[
          Center(
            child: Text('left pane')
          )
        ]
      ),
    );
  }
}