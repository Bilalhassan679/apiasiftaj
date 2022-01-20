
///Not Working Properly api data is





import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:apiasiftaj/Models/products_model.dart';

class ArrayNameDefineInModel extends StatefulWidget {
  const ArrayNameDefineInModel({Key? key}) : super(key: key);

  @override
  _ArrayNameDefineInModelState createState() => _ArrayNameDefineInModelState();
}

class _ArrayNameDefineInModelState extends State<ArrayNameDefineInModel> {
  Future<ProductsModel> getProductApi() async {
    // Response response;
    // var data;
    // try {
    //  response = await Dio().get('https://webhook.site/013bef0a-bda5-46d1-9fb7-6c5a301d90bf');
    //   print(response);
    //  var data=jsonDecode(response.data.toString());
    //   print(data);
    // } catch (e) {
    //   print(e);
    // }
    //
    //
    // return ProductsModel.fromJson(data);


    var request = await http.Request('GET', Uri.parse('https://webhook.site/013bef0a-bda5-46d1-9fb7-6c5a301d90bf'));
    request.body = '''''';

    http.StreamedResponse response = await request.send();
    // var data=jsonDecode(await response.stream.bytesToString());
    // print(data);
    // print('data');
    if (response.statusCode == 200) {

      print(await response.stream.bytesToString());
      return ProductsModel.fromJson(await response.stream.bytesToString());

    }
    else {
      print(response.reasonPhrase);
      return ProductsModel.fromJson(response.stream.bytesToString());

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder<ProductsModel>(
                  future: getProductApi(),
                  builder: (context,AsyncSnapshot<ProductsModel> snapshot) {
                  if(!snapshot.hasData){
                   return Center(child: Text("Loading"));
                  }

                      return ListView.builder(
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [Text(index.toString())],
                          );
                        },
                      );



                  }))
        ],
      ),
    );
  }
}
