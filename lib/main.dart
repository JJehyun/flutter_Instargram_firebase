import 'package:flutter/material.dart';
import './style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

//사진꺼내 사용하기!!
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
  var userImage;
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
          IconButton(onPressed: ()async{
            //갤러리에서 이미지를 가져오는 함수!!picker에 ImagePicker객체를 담아서 사용
            var picker = ImagePicker();
            var image = await picker.pickImage(source: ImageSource.gallery);
            //유저가 선택한 이미지를 userImage이라는 state에 저장한 것
            if(image !=null){
              setState(() {
                userImage = File(image.path);   //이미지의 경로를 저장한 것!!
              });
            }

            // Image.file(userImage);//state에 저장한 이미지 파일 경로를 사용해서 파일을 보여줌!!

            Navigator.push(context, 
              MaterialPageRoute(builder: (context){return Upload(userImage:userImage);})
            );
          }, icon: Icon(Icons.add_box_outlined),iconSize: 30,)
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
class Home extends StatefulWidget {
  const Home({Key? key,this.data}) : super(key: key);
  final data;

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  var scroll = ScrollController(); 

  @override
  void initState(){
    super.initState();
    scroll.addListener(() {
      if(scroll.position.pixels == scroll.position.maxScrollExtent){
        print("스크롤을 끝까지 내림");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
  if(widget.data.isNotEmpty){
    return ListView.builder(itemCount: 3,controller: scroll, itemBuilder: (c, i){
      return Column(
        children: [
          Image.network(widget.data[i]['image']),
          Container(
            constraints: BoxConstraints(maxWidth: 600),
            padding: EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("좋아요100개 ${widget.data[i]['likes']}"),
                Text(widget.data[i]['user']),
                Text(widget.data[i]['content']),
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


class Upload extends StatelessWidget {
  const Upload({Key? key , this.userImage}) : super(key: key);
  final userImage;
  @override

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.file(userImage),
            Text('이미지업로드화면'),
            IconButton(
                onPressed: (){Navigator.pop(context);},
                icon: Icon(Icons.close)
            ),
          ],
        )
    );

  }
}