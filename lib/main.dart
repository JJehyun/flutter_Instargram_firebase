import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(
          //전체적으로 스타일 주기!!
          theme: ThemeData(
            iconTheme : IconThemeData(color: Colors.blue),
            appBarTheme: AppBarTheme(color: Colors.grey , actionsIconTheme: IconThemeData(color: Colors.red)),
            textTheme: TextTheme(bodyText2: TextStyle(color : Colors.red))
          ),
          home: MyAPP())
  );
}

class MyAPP extends StatelessWidget {
  const MyAPP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [Icon(Icons.star)],),
      body: Icon(Icons.star)
    );

  }
}
