import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/controllers/new_update_info.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';

class UpdateShop extends StatefulWidget {
  String uid;
  UpdateShop(this.uid);
  @override
  _UpdateShopState createState() => _UpdateShopState();
}

class _UpdateShopState extends State<UpdateShop> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _shopTax ;
  TextEditingController _shopEmail ;
  TextEditingController _shopPhone ;
  TextEditingController _shopName ;
  TextEditingController _shopAddress ;
  File imageProfile;
  NewUpdateInfo updateInfo = new NewUpdateInfo();
  var inStead = 'https://firebasestorage.googleapis.com/v0/b/login-ce9de.appspot.com/o/user%2Fimages.png?alt=media&token=bbc9397d-f425-4834-82f1-5e6855b4a171';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _shopTax = TextEditingController();
    _shopEmail = TextEditingController();
    _shopPhone = TextEditingController();
    _shopName = TextEditingController();
    _shopAddress = TextEditingController();
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
        Navigator.pop(context);
      }).catchError((e) {
        print('upload error ${e}');
      });
    }
  }

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

  Widget showImage(BuildContext context){
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
                              image: NetworkImage(snapshot.data['proFile'] ?? inStead)
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
                        controller: _shopName,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        validator: (data){
                          if(data.isEmpty){
                            return 'Plese check Shop Name';
                          }else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            labelText: snapshot.data['ShopName'] ?? 'Shop Name',
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
                        controller: _shopPhone,
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
                            labelText: snapshot.data['ShopPhone']??'Phone Number',
                            labelStyle: TextStyle(color: Colors.blueGrey[300]),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                      ),//phone
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: _shopEmail,
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
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: _shopAddress,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        validator: (data){
                          if(data.isEmpty){
                            return 'Plese check Address';
                          }else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            labelText: snapshot.data['ShopAddress']??'Address',
                            labelStyle: TextStyle(color: Colors.blueGrey[300]),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                      ),//Address
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: RaisedButton(
                          onPressed: (){
                            Firestore.instance.collection('users').document(widget.uid).updateData({
                              'Tax' : _shopTax.text,
                              'ShopName' : _shopEmail.text,
                              'email' : _shopEmail.text,
                              'ShopAddress' : _shopAddress.text,
                              'ShopPhone' : _shopPhone
                            }).then((user){
                              uploadImage(context);
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
//        slivers: <Widget>[
//          SliverAppBar(
//            title: Text('Update Profile',style: TextStyle(color: Colors.white,fontSize: 20),),
//            floating: true,
//            centerTitle: true,
//          ),
//          SliverList(
//            delegate: SliverChildListDelegate([
//              SizedBox(
//                height: 40,
//              ),
//              Padding(
//                padding: const EdgeInsets.symmetric(horizontal: 20),
//                child: Form(
//                  key: _formKey,
//                  child: Column(
//                    children: <Widget>[
//                      SizedBox(
//                        height: 10,
//                      ),
//                      showImage(),
//                      SizedBox(
//                        height: 10,
//                      ),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                        children: <Widget>[
//                          SizedBox(
//                            height: 10.0,
//                          ),
//                          RaisedButton(
//                            color: Colors.blueGrey[300],
//                            child: Text('Take Photo',style: TextStyle(color: Colors.white),),
//                            onPressed: (){
//                              getImageCamera();
//                            },
//                          ),
//                          RaisedButton(
//                            color: Colors.blueGrey[300],
//                            child: Text('Add Picture',style: TextStyle(color: Colors.white),),
//                            onPressed: (){
//                              getImageGallery();
//                            },
//                          ),
//                        ],
//                      ),
//                      SizedBox(
//                        height: 10,
//                      ),
//                      TextFormField(
//                        controller: _shopName,
//                        maxLines: 1,
//                        keyboardType: TextInputType.text,
//                        validator: (data){
//                          if(data.isEmpty){
//                            return 'Plese check Shop Name';
//                          }else{
//                            return null;
//                          }
//                        },
//                        decoration: InputDecoration(
//                            labelText: 'Shop Name',
//                            labelStyle: TextStyle(color: Colors.blueGrey[300]),
//                            border: OutlineInputBorder(
//                                borderRadius: BorderRadius.circular(10)
//                            )
//                        ),
//                      ),
//                      SizedBox(
//                        height: 10,
//                      ),
//                      TextFormField(
//                        controller: _shopPhone,
//                        maxLines: 1,
//                        maxLength: 10,
//                        keyboardType: TextInputType.number,
//                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
//                        validator: (data){
//                          if(data.isEmpty){
//                            return 'Plese check Shop Phone';
//                          }else{
//                            return null;
//                          }
//                        },
//                        decoration: InputDecoration(
//                            labelText: 'Shop Phone',
//                            labelStyle: TextStyle(color: Colors.blueGrey[300]),
//                            border: OutlineInputBorder(
//                                borderRadius: BorderRadius.circular(10)
//                            )
//                        ),
//                      ),
//                      SizedBox(
//                        height: 10,
//                      ),
//                      TextFormField(
//                        controller: _shopEmail,
//                        maxLines: 1,
//                        keyboardType: TextInputType.emailAddress,
//                        validator: (data){
//                          if(data.isEmpty){
//                            return 'Plese check Shop Email';
//                          }else{
//                            return null;
//                          }
//                        },
//                        decoration: InputDecoration(
//                            labelText: 'Shop Email',
//                            labelStyle: TextStyle(color: Colors.blueGrey[300]),
//                            border: OutlineInputBorder(
//                                borderRadius: BorderRadius.circular(10)
//                            )
//                        ),
//                      ),
//                      SizedBox(
//                        height: 10,
//                      ),
//                      TextFormField(
//                        controller: _shopAddress,
//                        maxLines: null,
//                        textAlign: TextAlign.justify,
//                        keyboardType: TextInputType.multiline,
//                        validator: (data){
//                          if(data.isEmpty){
//                            return 'Plese check Shop Name';
//                          }else{
//                            return null;
//                          }
//                        },
//                        decoration: InputDecoration(
//                            labelText: 'Shop Name',
//                            labelStyle: TextStyle(color: Colors.blueGrey[300]),
//                            border: OutlineInputBorder(
//                                borderRadius: BorderRadius.circular(10)
//                            )
//                        ),
//                      ),
//                      SizedBox(
//                        height: 20,
//                      ),
//                      RaisedButton(
//                        onPressed: (){
//                          if(_formKey.currentState.validate()){
//
//                          }
//                        },
//                        elevation: 1.1,
//                        color: Colors.blueGrey[300],
//                        child: Text('Save',style: TextStyle(color: Colors.white,fontSize: 20),),
//                        shape: RoundedRectangleBorder(
//                            borderRadius: BorderRadius.circular(20)
//                        ),
//                      ),
//                      SizedBox(
//                        height: 20,
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