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
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
              //Logo
              Container(
                color: Colors.white,
                child: Expanded(
                  child: Text('H', style: TextStyle(
                    fontSize: 80,
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    height: 1.5,
                    shadows: [
                      Shadow(
                        color: Colors.white,
                        offset: Offset(0, 0.5),
                        blurRadius: 0.5,
                      ),
                    ],
                    decoration: TextDecoration.none,
                    decorationColor: Colors.white,
                    decorationStyle: TextDecorationStyle.double,
                    decorationThickness: 1,

                  ),),
                ),
              ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                //home
                IconButton(
                  icon: Icon(Icons.home, size: 40,),
                  onPressed: () {},

                  color: Colors.black,
                ),

                //dashboard
                IconButton(
                  icon: Icon(Icons.dashboard, size: 40,),
                  onPressed: () {},
                  color: Colors.black,
                ),

                //notifications
                IconButton(
                  icon: Icon(Icons.notifications, size: 40,),
                  onPressed: () {},
                  color: Colors.black,
                ),


                //messages
                IconButton(
                  icon: Icon(Icons.message, size: 40,),
                  onPressed: () {},
                  color: Colors.black,
                ),


                //settings
                IconButton(
                  icon: Icon(Icons.settings, size: 40,),
                  onPressed: () {},
                  color: Colors.black,
                ),

              ]
            ),
          ),
              //logout
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {},
                color: Colors.black,
              ),
        ],
      ),
    );
  }
}