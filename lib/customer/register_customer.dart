import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/controllers/new_update_info.dart';
import 'package:finalproject/customer/controlPageCustomer/main_customer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class RegisterCustomer extends StatefulWidget {
  @override
  _RegisterCustomerState createState() => _RegisterCustomerState();
}

class _RegisterCustomerState extends State<RegisterCustomer> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool showPW = true;
  String _age = 'Birth Day';
  String gender;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _cusFName;
  TextEditingController _cusLName;
  TextEditingController _cusPassword;
  TextEditingController _cusEmail;
  TextEditingController _cusPhone;
  NewUpdateInfo updateInfo = new NewUpdateInfo();
  File imageProfile;
  var proFile = 'https://firebasestorage.googleapis.com/v0/b/login-ce9de.appspot.com/o/user%2Fimages.png?alt=media&token=bbc9397d-f425-4834-82f1-5e6855b4a171';

  Future getImageCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      imageProfile = image;
    });
  }

  Future getImageGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageProfile = image;
    });
  }

  Future uploadImage(BuildContext context) async {
    String fileName = basename(imageProfile.path);
    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('CustomerProfile/${fileName.toString()}');
    StorageUploadTask task = firebaseStorageRef.putFile(imageProfile);
    StorageTaskSnapshot snapshotTask = await task.onComplete;
    String downloadUrl = await snapshotTask.ref.getDownloadURL();
    if (downloadUrl != null) {
      updateInfo.updateProfilePic(downloadUrl.toString(), context).then((val) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainCustomer()),
            ModalRoute.withName('/'));
      }).catchError((e) {
        print('upload error ${e}');
      });
    }
  }

  signUp(BuildContext context) async {
    _auth.createUserWithEmailAndPassword(
        email: _cusEmail.text.trim(),
        password: _cusPassword.text.trim())
        .then((currentUser) =>
        Firestore.instance.collection('users')
            .document(currentUser.user.uid)
            .setData({
          'FirstName': _cusFName.text.trim(),
          'LastName': _cusLName.text.trim(),
          'age': _age.toString().trim(),
          'gender': gender.toString().trim(),
          'email': _cusEmail.text.trim(),
          'uid': currentUser.user.uid,
          'role': 'user'
        }).then((user) {
          print('user ok ${currentUser}');
          uploadImage(context);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context)=>MainCustomer()),
              ModalRoute.withName('/'));
        }).catchError((e) {
          print('profile ${e}');
        })
    );
  }

  Widget showImage(BuildContext context) {
    return Center(
      child: imageProfile == null
          ? Container(
        height: 200,
        width: 200,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1.0, color: Colors.grey),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                proFile
            ),
          ),
        ),
      )
          : CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: FileImage(imageProfile) == null
            ? Center(
          child: Text('loading....'),
        )
            : FileImage(imageProfile),
        radius: 120,
      ),
    );
  }

  _handleRadioValueChange(String value) {
    setState(() {
      gender = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    gender = 'Man';
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
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Register Customer',
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey[400],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 1.1,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        showImage(context),
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
                              child: Text(
                                'Take Photo',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                getImageCamera();
                              },
                            ),
                            RaisedButton(
                              color: Colors.blueGrey[300],
                              child: Text(
                                'Add Picture',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                getImageGallery();
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Radio(
                              groupValue: gender,
                              value: 'Man',
                              onChanged: _handleRadioValueChange,
                            ),
                            Text(
                              'ชาย',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 30.0, right: 10.0),
                              child: Radio(
                                groupValue: gender,
                                value: 'Girl',
                                onChanged: _handleRadioValueChange,
                              ),
                            ),
                            Text(
                              'หญิง',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ), //GENDER
                        SizedBox(
                          height: 12.0,
                        ),
                        TextFormField(
                          maxLines: 1,
                          keyboardType: TextInputType.text,
                          controller: _cusFName,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Plese check First Name';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: Colors.blueGrey[200],
                            ),
                            hintText: 'First Name',
                            focusColor: Colors.black,
                            labelText: 'First Name',
                            labelStyle: TextStyle(color: Colors.blueGrey[200]),
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ), //FIRST NAME
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          controller: _cusLName,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Plese check Last Name';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: Colors.blueGrey[200],
                            ),
                            hintText: 'Last Name',
                            focusColor: Colors.black,
                            labelText: 'Last Name',
                            labelStyle: TextStyle(color: Colors.blueGrey[200]),
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ), //LAST NAME
                        SizedBox(
                          height: 10.0,
                        ),
                        RaisedButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                                theme: DatePickerTheme(
                                  containerHeight: 210.0,
                                ),
                                showTitleActions: true,
                                minTime: DateTime(1950, 1, 1),
                                maxTime: DateTime(2021, 12, 31),
                                onConfirm: (date) {
                                  print('Confirm $date');
                                  _age =
                                  '${date.year} - ${date.month} - ${date.day}';
                                  setState(() {});
                                },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50.0,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.date_range,
                                        size: 18.0,
                                        color: Colors.blueGrey[200],
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          '$_age',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ), //BIRTH DAY
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          maxLines: 1,
                          keyboardType: TextInputType.emailAddress,
                          controller: _cusEmail,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Plese check Email';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.blueGrey[200],
                            ),
                            hintText: 'Email',
                            focusColor: Colors.black,
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.blueGrey[200]),
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ), //
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          maxLines: 1,
                          controller: _cusPassword,
                          obscureText: showPW,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'password not empty';
                            } else if (value.length <= 5) {
                              return 'password less than 5 charecters';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.blueGrey[200],
                            ),
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.blueGrey[200]),
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.blueGrey[200]),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (showPW == true) {
                                    showPW = false;
                                  } else {
                                    showPW = true;
                                  }
                                });
                              },
                              icon: Icon(
                                showPW
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ), //PasswordEMAIL
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          maxLength: 10,
                          maxLines: 1,
                          keyboardType: TextInputType.phone,
                          controller: _cusPhone,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please check Phone Number';
                            } else if (value.length != 10) {
                              return 'Please check Length Number';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.blueGrey[200],
                            ),
                            hintText: 'Phone Number',
                            focusColor: Colors.black,
                            labelText: 'Phone Number',
                            labelStyle: TextStyle(color: Colors.blueGrey[200]),
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ), //PHONE
                        SizedBox(
                          height: 30.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            height: 50.0,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: RaisedButton(
                              color: Colors.blueGrey[400],
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  signUp(context);
                                }
                              },
                              elevation: 1.1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'Create Account',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ), //CREATE ACCOUNT
                        SizedBox(
                          height: 120.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}