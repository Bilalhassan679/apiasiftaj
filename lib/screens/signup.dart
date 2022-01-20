import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  void login(String email,String password)
  async{
    try{
      Response response=await post(Uri.parse('https://reqres.in/api/register'),
      body: {
        'email':email,
        'password':password
      }
      );
      if(response.statusCode==200)
        {
          var data=jsonDecode(response.body.toString());
          print(data);
          print('Acount Created Succesfully');
        }
      else {
        print('Failed');
    }
    }
    catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SignUp'),),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
           child: Column(
             children: [
               TextField(
                 controller:emailController ,
                 decoration: InputDecoration(
                   hintText: "Email"
                 ),
               ),
               SizedBox(height: 20,),
               TextField(
                 controller:passwordController ,
                 decoration: InputDecoration(
                     hintText: "Password"
                 ),

               ),
               SizedBox(height: 20,),
               GestureDetector(
                 onTap:(){
                   login(emailController.text.toString(),passwordController.text.toString());
                 } ,
                 child: Container(
                   height: 50,
                   width: MediaQuery.of(context).size.width,
                   decoration: BoxDecoration(
                     color: Colors.green,
                     borderRadius: BorderRadiusDirectional.circular(10),
                   ),
                   child: Center(child: Text('Sign Up'),)
                 ),
               )
             ],
           ),
          )
        ],
      ),
    );
  }
}
