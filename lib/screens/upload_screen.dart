import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart 'as http;


class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? image;
  final _picker=ImagePicker();
  bool showSpinner =false;
  
  Future getImage() async{
    final pickedImage=await _picker.pickImage(source: ImageSource.gallery,imageQuality: 80);

    if(pickedImage!=null)
      {
        setState(() {
          image=File(pickedImage.path);
        });
      }
    else
      {
        print('NO Image Selected');
      }
  }

  Future<void> uploadImage() async
  {
    setState(() {
      showSpinner=true;
    });
    var stream=new http.ByteStream(image!.openRead());
    stream.cast();
    var length=await image!.length();

    var uri=Uri.parse('https://fakestoreapi.com/products');

    var request =new http.MultipartRequest('POST', uri);

    request.fields['title']="Static Fields";

    var multiport=new http.MultipartFile('image', stream, length);

    request.files.add(multiport);
    var response= await request.send();
    print(response.stream.toString());
    if(response.statusCode==200)
      {
        setState(() {
          showSpinner=false;
        });
       print('Image Uploaded'); 
      }
    else{
      print('failed');
    }
    
  }


  @override 
  Widget build(BuildContext context) {
    return
       Scaffold(appBar: AppBar(title: Text('ImageUploadScreen'),centerTitle: true,),
      body: ModalProgressHUD(
        inAsyncCall:showSpinner,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:CrossAxisAlignment.center,
          children: [
              GestureDetector(
                onTap: (){
                  getImage();
                },
                child: Container(
                  child: image==null?Center(child: Text('Pick Image'),):
                      Container(
                        child: Center(
                          child: Image.file(
                            File(image!.path).absolute,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,


                          ),
                        ),
                      )
                ),
              ),
            SizedBox(height: 150,),
            GestureDetector(
              onTap: ()
              {

              uploadImage();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadiusDirectional.circular(10)

                ),
                child: Text('Upload Image'),
              ),
            )
          ],
        ),
      ),
      );
  }
}
