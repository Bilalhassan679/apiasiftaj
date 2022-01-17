import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:apiasiftaj/Models/users_model.dart';

class ComplexModelExample extends StatefulWidget {
  const ComplexModelExample({Key? key}) : super(key: key);

  @override
  _ComplexModelExampleState createState() => _ComplexModelExampleState();
}

class _ComplexModelExampleState extends State<ComplexModelExample> {
  List<UsersModel> userList = [];

  Future<List<UsersModel>?> getUserapi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(UsersModel.fromJson(i));
      }
      return userList;
    } else
      return userList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getUserapi(),
                builder: (context, AsyncSnapshot<List<UsersModel>?> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else
                    return ListView.builder(
                        itemCount: userList.length,
                        itemBuilder: (context, index) {
                          return
                            Card(
                              margin: EdgeInsets.all(8.0),
                              child:Column(
                                children: [

                                  ReusableRow(title: snapshot.data![index].id.toString(),value: snapshot.data![index].address!.geo!.lat.toString(),),
                                  ReusableRow(title: snapshot.data![index].address!.street.toString(),value: snapshot.data![index].address.toString(),)
                                ],
                              ) ,
                            );
                            
                        });
                }),
          )
        ],
      ),
    );
  }
}


class ReusableRow extends StatelessWidget {
  String title,value;

  ReusableRow({Key? key,required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value)
      ],
    );
  }
}
