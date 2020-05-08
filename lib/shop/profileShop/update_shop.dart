import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

class UpdateShop extends StatefulWidget {
  @override
  _UpdateShopState createState() => _UpdateShopState();
}

class _UpdateShopState extends State<UpdateShop> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _shopAddress ;
  TextEditingController _shopEmail ;
  TextEditingController _shopPhone ;
  TextEditingController _shopName ;
  File imageProfile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _shopAddress = TextEditingController();
    _shopEmail = TextEditingController();
    _shopPhone = TextEditingController();
    _shopName = TextEditingController();
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Update Profile',style: TextStyle(color: Colors.white,fontSize: 20),),
            floating: true,
            centerTitle: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                            labelText: 'Shop Name',
                            labelStyle: TextStyle(color: Colors.blueGrey[300]),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _shopPhone,
                        maxLines: 1,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                        validator: (data){
                          if(data.isEmpty){
                            return 'Plese check Shop Phone';
                          }else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Shop Phone',
                            labelStyle: TextStyle(color: Colors.blueGrey[300]),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _shopEmail,
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        validator: (data){
                          if(data.isEmpty){
                            return 'Plese check Shop Email';
                          }else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Shop Email',
                            labelStyle: TextStyle(color: Colors.blueGrey[300]),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _shopAddress,
                        maxLines: null,
                        textAlign: TextAlign.justify,
                        keyboardType: TextInputType.multiline,
                        validator: (data){
                          if(data.isEmpty){
                            return 'Plese check Shop Name';
                          }else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Shop Name',
                            labelStyle: TextStyle(color: Colors.blueGrey[300]),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        onPressed: (){
                          if(_formKey.currentState.validate()){

                          }
                        },
                        elevation: 1.1,
                        color: Colors.blueGrey[300],
                        child: Text('Save',style: TextStyle(color: Colors.white,fontSize: 20),),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                      ),
                      SizedBox(
                        height: 20,
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