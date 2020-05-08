import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _cusFName;
  TextEditingController _cusLName;
  TextEditingController _cusPassword;
  TextEditingController _cusEmail;
  TextEditingController _cusPhone;
  File imageProfile;

  Future getImageCamera() async{
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      imageProfile = image;
    });
  }
  Future getImageGallery() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageProfile = image;
    });
  }

  Widget showImage(){
    return Center(
      child: imageProfile == null
          ? Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: Colors.grey,
                width: 1.0
            )
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.image,
              size: 80,
              color: Colors.grey,
            ),
            Text(
              'Add Image',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      )
          : CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: FileImage(imageProfile),
        radius: 120,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _cusFName = TextEditingController();
    _cusLName = TextEditingController();
    _cusPassword = TextEditingController();
    _cusEmail = TextEditingController();
    _cusPhone = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Update Profile',style: TextStyle(color: Colors.white),),
            centerTitle: true,
            floating: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Center(
                child: Form(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              showImage(),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  RaisedButton(
                                    color: Colors.blueGrey[300],
                                    child: Text('Take Photo',style: TextStyle(color: Colors.white),),
                                    onPressed: (){
                                      getImageCamera();
                                    },
                                  ),
                                  RaisedButton(
                                    color: Colors.blueGrey[300],
                                    child: Text('Add Picture',style: TextStyle(color: Colors.white),),
                                    onPressed: (){
                                      getImageGallery();
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _cusFName,
                                maxLines: 1,
                                keyboardType: TextInputType.text,
                                validator: (data){
                                  if(data.isEmpty){
                                    return 'Plese check First Name';
                                  }else{
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    labelText: 'First Name',
                                    labelStyle: TextStyle(color: Colors.blueGrey[300]),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    )
                                ),
                              ),//FIRST NAME
                              SizedBox(
                                height: 10.0,
                              ),
                              TextFormField(
                                controller: _cusLName,
                                maxLines: 1,
                                keyboardType: TextInputType.text,
                                validator: (data){
                                  if(data.isEmpty){
                                    return 'Plese check Last Name';
                                  }else{
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    labelText: 'Last Name',
                                    labelStyle: TextStyle(color: Colors.blueGrey[300]),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    )
                                ),
                              ),//LAST NAME
                              SizedBox(
                                height: 10.0,
                              ),
                              TextFormField(
                                controller: _cusPassword,
                                maxLines: 1,
                                keyboardType: TextInputType.text,
                                validator: (data){
                                  if(data.isEmpty){
                                    return 'Plese check Password';
                                  }else{
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: TextStyle(color: Colors.blueGrey[300]),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    )
                                ),
                              ),//PASSWORD
                              SizedBox(
                                height: 10.0,
                              ),
                              TextFormField(
                                controller: _cusEmail,
                                maxLines: 1,
                                keyboardType: TextInputType.emailAddress,
                                validator: (data){
                                  if(data.isEmpty){
                                    return 'Plese check Email';
                                  }else{
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: TextStyle(color: Colors.blueGrey[300]),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    )
                                ),
                              ),//Email
                              SizedBox(
                                height: 10.0,
                              ),
                              TextFormField(
                                controller: _cusPhone,
                                maxLength: 10,
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                                validator: (data){
                                  if(data.isEmpty){
                                    return 'Plese check Phone Number';
                                  }else{
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    labelText: 'Phone Number',
                                    labelStyle: TextStyle(color: Colors.blueGrey[300]),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    )
                                ),
                              ),//PHONE
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                child: RaisedButton(
                                  onPressed: (){},
                                  child: Text('Save',style: TextStyle(color: Colors.white,fontSize: 20),),
                                  color: Colors.blueGrey[300],
                                  elevation: 1.1,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}