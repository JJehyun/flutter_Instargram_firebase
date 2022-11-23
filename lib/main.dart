import 'package:flutter/material.dart';
import './style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(
      MaterialApp(
          theme: theme,
          home: MyAPP())
  );
}
//서버에서 데이터 가져오기!!!!
class MyAPP extends StatefulWidget {
  const MyAPP({Key? key}) : super(key: key);

  @override
  State<MyAPP> createState() => _MyAPPState();
}

class _MyAPPState extends State<MyAPP> {
  var tab = 0; //탭 정보 저장
  
//데이터를 받아오는 함수 데이터를 받아오기 전까지 기다라는 뜻
  getDate() async{
    var result = await http.get( Uri.parse('https://codingapple1.github.io/app/data.json'));
    var result2 = jsonDecode(result.body);
  }
//앱이 처음 로드되었을때 시작되는 것
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
      body: [Home(),Text("샵페이지")][tab],
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
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return ListView.builder(itemCount: 3, itemBuilder: (c, i){
      return Column(
        children: [
          Image.network('https://codingapple1.github.io/kona.jpg'),
          Container(
            constraints: BoxConstraints(maxWidth: 600),
            padding: EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('좋아요 100'),
                Text('글쓴이'),
                Text('글내용'),
              ],
            ),
          )
        ],
      );
    });

  }
}

