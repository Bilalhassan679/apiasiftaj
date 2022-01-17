import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:apiasiftaj/Models/posts_model.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PostsModel> postList=[];

  Future<List<PostsModel>?> getPostApi() async
  {
    final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){
      postList.clear();
        for(Map i in data){
          postList.add(PostsModel.fromJson(i));
        }
        return postList;
    }
    else  {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Api'),),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPostApi(),
                builder: (context, snapshot)
                {
                  if(!snapshot.hasData){
                    return Text('Loading');
                  }
                  else
                  return ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (context,index){
                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Title :' + postList[index].title.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                          Text('Description :' + postList[index].body.toString())
                        ],
                      ),
                    );
                  });
            }),
          )
        ],
      ),
    );
  }
}
