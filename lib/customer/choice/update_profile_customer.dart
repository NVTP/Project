import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';

class UpdateProfile extends StatefulWidget {
  String uid;
  UpdateProfile(this.uid);
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _cusFName;
  TextEditingController _cusLName;
  TextEditingController _cusEmail;
  TextEditingController _cusPhone;
  var inStead = 'https://firebasestorage.googleapis.com/v0/b/login-ce9de.appspot.com/o/user%2Fimages.png?alt=media&token=bbc9397d-f425-4834-82f1-5e6855b4a171';
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

  Widget showImage(String image){
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
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(width: 2,color: Colors.grey),
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(inStead)
            ),
          ),
        )
      )
          : Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          border: Border.all(width: 2,color: Colors.grey),
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(image)
          ),
        ),
      )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _cusFName = TextEditingController();
    _cusLName = TextEditingController();
    _cusEmail = TextEditingController();
    _cusPhone = TextEditingController();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Update Profile'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance.collection('users').document(widget.uid).snapshots(),
        builder: (context, snapshot){
          return SingleChildScrollView(
            child: Center(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2,color: Colors.grey),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(snapshot.data['proFile'] ??inStead)
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
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
                        height: 12,
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
                            labelText: snapshot.data['FirstName'] ?? 'First Name',
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
                            labelText: snapshot.data['LastName'] ??'Last Name',
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
                            labelText: snapshot.data['email']??'Email',
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
                            labelText: snapshot.data['phone']??'Phone Number',
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
                          onPressed: (){
                            Firestore.instance.collection('users').document(widget.uid).updateData({
                              'FirstName' : _cusFName.text,
                              'LastName' : _cusLName.text,
                              'email' : _cusEmail.text,
                              'proFile' : imageProfile,
                              'phone' : _cusPhone
                            }).catchError((e){
                              print('can\'t update');
                            });
                          },
                          child: Text('Save',style: TextStyle(color: Colors.white,fontSize: 20),),
                          color: Colors.blueGrey[300],
                          elevation: 1.1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
//    return Scaffold(
//      body: CustomScrollView(
//        shrinkWrap: true,
//        slivers: <Widget>[
//          SliverAppBar(
//            title: Text('Update Profile',style: TextStyle(color: Colors.white),),
//            centerTitle: true,
//            floating: true,
//          ),
//          SliverList(
//            delegate: SliverChildListDelegate([
//              Center(
//                child: Form(
//                  child: Column(
//                    children: <Widget>[
//                      SizedBox(
//                        height: 20.0,
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                        child: Form(
//                          key: _formKey,
//                          child: Column(
//                            children: <Widget>[
//                              SizedBox(
//                                height: 10,
//                              ),
//                              showImage(),
//                              SizedBox(
//                                height: 10,
//                              ),
//                              Row(
//                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                children: <Widget>[
//                                  SizedBox(
//                                    height: 10.0,
//                                  ),
//                                  RaisedButton(
//                                    color: Colors.blueGrey[300],
//                                    child: Text('Take Photo',style: TextStyle(color: Colors.white),),
//                                    onPressed: (){
//                                      getImageCamera();
//                                    },
//                                  ),
//                                  RaisedButton(
//                                    color: Colors.blueGrey[300],
//                                    child: Text('Add Picture',style: TextStyle(color: Colors.white),),
//                                    onPressed: (){
//                                      getImageGallery();
//                                    },
//                                  ),
//                                ],
//                              ),
//                              SizedBox(
//                                height: 10,
//                              ),
//                              TextFormField(
//                                controller: _cusFName,
//                                maxLines: 1,
//                                keyboardType: TextInputType.text,
//                                validator: (data){
//                                  if(data.isEmpty){
//                                    return 'Plese check First Name';
//                                  }else{
//                                    return null;
//                                  }
//                                },
//                                decoration: InputDecoration(
//                                    labelText: 'First Name',
//                                    labelStyle: TextStyle(color: Colors.blueGrey[300]),
//                                    border: OutlineInputBorder(
//                                        borderRadius: BorderRadius.circular(10)
//                                    )
//                                ),
//                              ),//FIRST NAME
//                              SizedBox(
//                                height: 10.0,
//                              ),
//                              TextFormField(
//                                controller: _cusLName,
//                                maxLines: 1,
//                                keyboardType: TextInputType.text,
//                                validator: (data){
//                                  if(data.isEmpty){
//                                    return 'Plese check Last Name';
//                                  }else{
//                                    return null;
//                                  }
//                                },
//                                decoration: InputDecoration(
//                                    labelText: 'Last Name',
//                                    labelStyle: TextStyle(color: Colors.blueGrey[300]),
//                                    border: OutlineInputBorder(
//                                        borderRadius: BorderRadius.circular(10)
//                                    )
//                                ),
//                              ),//LAST NAME
//                              SizedBox(
//                                height: 10.0,
//                              ),
//                              TextFormField(
//                                controller: _cusPassword,
//                                maxLines: 1,
//                                keyboardType: TextInputType.text,
//                                validator: (data){
//                                  if(data.isEmpty){
//                                    return 'Plese check Password';
//                                  }else{
//                                    return null;
//                                  }
//                                },
//                                decoration: InputDecoration(
//                                    labelText: 'Password',
//                                    labelStyle: TextStyle(color: Colors.blueGrey[300]),
//                                    border: OutlineInputBorder(
//                                        borderRadius: BorderRadius.circular(10)
//                                    )
//                                ),
//                              ),//PASSWORD
//                              SizedBox(
//                                height: 10.0,
//                              ),
//                              TextFormField(
//                                controller: _cusEmail,
//                                maxLines: 1,
//                                keyboardType: TextInputType.emailAddress,
//                                validator: (data){
//                                  if(data.isEmpty){
//                                    return 'Plese check Email';
//                                  }else{
//                                    return null;
//                                  }
//                                },
//                                decoration: InputDecoration(
//                                    labelText: 'Email',
//                                    labelStyle: TextStyle(color: Colors.blueGrey[300]),
//                                    border: OutlineInputBorder(
//                                        borderRadius: BorderRadius.circular(10)
//                                    )
//                                ),
//                              ),//Email
//                              SizedBox(
//                                height: 10.0,
//                              ),
//                              TextFormField(
//                                controller: _cusPhone,
//                                maxLength: 10,
//                                maxLines: 1,
//                                keyboardType: TextInputType.number,
//                                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
//                                validator: (data){
//                                  if(data.isEmpty){
//                                    return 'Plese check Phone Number';
//                                  }else{
//                                    return null;
//                                  }
//                                },
//                                decoration: InputDecoration(
//                                    labelText: 'Phone Number',
//                                    labelStyle: TextStyle(color: Colors.blueGrey[300]),
//                                    border: OutlineInputBorder(
//                                        borderRadius: BorderRadius.circular(10)
//                                    )
//                                ),
//                              ),//PHONE
//                              SizedBox(
//                                height: 20.0,
//                              ),
//                              Container(
//                                width: MediaQuery.of(context).size.width,
//                                height: 40,
//                                child: RaisedButton(
//                                  onPressed: (){},
//                                  child: Text('Save',style: TextStyle(color: Colors.white,fontSize: 20),),
//                                  color: Colors.blueGrey[300],
//                                  elevation: 1.1,
//                                  shape: RoundedRectangleBorder(
//                                      borderRadius: BorderRadius.circular(10)
//                                  ),
//                                ),
//                              ),
//                              SizedBox(
//                                height: 20,
//                              ),
//                            ],
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            ]),
//          ),
//        ],
//      ),
//    );
  }
}