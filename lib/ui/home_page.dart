
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("DASHBOARD PAGE"),
        elevation: 0.1,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          SizedBox(height: 100),
          ElevatedButton(
            onPressed: () {
              //Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text("Logout"),
            //color: Colors.lightBlueAccent,
          )
        ],
      ),
    );
  }
}