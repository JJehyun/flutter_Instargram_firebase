import 'package:flutter/material.dart';
import './style.dart';
void main() {
  runApp(
      MaterialApp(
          theme: theme,
          home: MyAPP())
  );
}

class MyAPP extends StatelessWidget {
  const MyAPP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add_box_outlined),iconSize: 30,)
        ],
      ),
      body: TextButton(onPressed: (){},child:Text("버튼"))
    );
  }
}
