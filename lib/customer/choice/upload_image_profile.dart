import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

//TODO NOT USE
class UploadImage extends StatefulWidget {
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  Future<File> imageProfile;

  pickImageFromGallery(ImageSource source){
    setState(() {
      imageProfile = ImagePicker.pickImage(source: source);
    });
  }
  pickImageFromCamera(ImageSource source){
    setState(() {
      imageProfile = ImagePicker.pickImage(source: source);
    });
  }

  Widget showImage(){
    return FutureBuilder<File>(
        future: imageProfile,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot){
          if(snapshot.connectionState == ConnectionState.done && snapshot.data != null){
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Image.file(
                snapshot.data,
                fit: BoxFit.cover,
              ),
            );
          }else if(snapshot.error != null){
            return const Text(
              'Error Picking Image',
              textAlign: TextAlign.center,
            );
          }else{
            return  Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.picture_in_picture,
                    size: 50,
                    color: Colors.grey,
                  ),
                  Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.grey,
                  ),
                  Text(
                    'Add Picture',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: <Widget>[
        showImage(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
              color: Colors.blueGrey[300],
              child: Text('Add Picture',style: TextStyle(color: Colors.white),),
              onPressed: (){
                pickImageFromGallery(ImageSource.gallery);
              },
            ),
            RaisedButton(
              color: Colors.blueGrey[300],
              child: Text('Take Photo',style: TextStyle(color: Colors.white),),
              onPressed: (){
                pickImageFromCamera(ImageSource.camera);
              },
            ),
          ],
        ),
      ],
    );
  }
}