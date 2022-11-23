import 'package:flutter/material.dart';
import './style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


//데이터 도착전에 로딩중 창 띄우기
void main() {
  runApp(
      MaterialApp(
          theme: theme,
          home: MyAPP())
  );
}

class MyAPP extends StatefulWidget {
  const MyAPP({Key? key}) : super(key: key);

  @override
  State<MyAPP> createState() => _MyAPPState();
}

class _MyAPPState extends State<MyAPP> {
  var tab = 0;
  var data = [];

  getDate() async{
    var result = await http.get( Uri.parse('https://codingapple1.github.io/app/data.json'));
    var result2 = jsonDecode(result.body);
    setState(() {
      data = result2;
    });
  }

  @override
  void initState(){
    super.initState();
    getDate();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add_box_outlined),iconSize: 30,)
        ],
      ),
      body: [Home(data : data),Text("샵페이지")][tab],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index){
          setState(() {
            tab = index;
          });
        },//
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined),label: '샵') //
        ],
      )
    );
  }
}











//커스텀 위젯
class Home extends StatelessWidget {
  const Home({Key? key,this.data}) : super(key: key);
  final data;


  @override
  Widget build(BuildContext context) {
  if(data.isNotEmpty){
    return ListView.builder(itemCount: 3, itemBuilder: (c, i){
      return Column(
        children: [
          Image.network(data[i]['image']),
          Container(
            constraints: BoxConstraints(maxWidth: 600),
            padding: EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("좋아요100개"),
                Text(data[i]['user']),
                Text(data[i]['content']),
              ],
            ),
          )
        ],
      );
    });
  }else{
    return Text("로딩 중이에요!");
  }


  }
}

