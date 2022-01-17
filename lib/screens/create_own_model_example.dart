import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class CreateOwnModelExample extends StatefulWidget {
  const CreateOwnModelExample({Key? key}) : super(key: key);

  @override
  _CreateOwnModelExampleState createState() => _CreateOwnModelExampleState();
}

class _CreateOwnModelExampleState extends State<CreateOwnModelExample> {

  List<PhotosModels> postList=[];

  Future<List<PhotosModels>?> getPostApi() async
  {
    final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){
      postList.clear();
      for(Map i in data){
        postList.add(PhotosModels(title: i['title'], url: i['url'],id: i['id']));
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
      appBar: AppBar(title: Text('CreateOwnModelExample'),),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPostApi(),
                builder: (context,AsyncSnapshot<List<PhotosModels>?>  snapshot)
                {
                  if(!snapshot.hasData){
                    return Text('Loading');
                  }
                  else
                    return ListView.builder(
                        itemCount: postList.length,
                        itemBuilder: (context,index){

                          return ListTile(
                              leading: CircleAvatar(
                                radius: 35,
                                backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                              ),
                              title:Text('ID :'+snapshot.data![index].id.toString()),
                              subtitle:Text(snapshot.data![index].title.toString()));
                        });
                }),
          )
        ],
      ),
    );
  }
}

class PhotosModels{
   String title;
   String url;
   int id;

   PhotosModels({
     required this.title,
     required this.url,
     required this.id,
});
}