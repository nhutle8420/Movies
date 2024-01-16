import 'package:flutter/material.dart';
import 'package:path/path.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
        body: Center(
        child: Text('Chat Screen',style: TextStyle(fontSize: 50)) ,
    ),

    );
  }
}
