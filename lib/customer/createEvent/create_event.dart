import 'package:finalproject/customer/createEvent/clothing_select.dart';
import 'package:finalproject/customer/createEvent/eletronic_select.dart';
import 'package:finalproject/customer/createEvent/gadget_select.dart';
import 'package:finalproject/customer/createEvent/shoes_select.dart';
import 'package:finalproject/customer/createEvent/sport_select.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class CreateEvent extends StatefulWidget {
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {

  final _formKey = GlobalKey<FormState>();
  List catData; //collect data for dropdown
  List<DropdownMenuItem<String>> catToDo = []; //bring data to dropdown
  String catDataSelected; // keep data for dropdown select

  TextEditingController _eventName;

  @override
  void initState() {
    // TODO: implement initState
    _eventName = TextEditingController();

    super.initState();

    catData = [
      'Gadget',
      'Clothing',
      'Shoes',
      'Sport',
      'Electronic',
    ];
    for (int i = 0; i < catData.length; i++) {
      catToDo.add(
        DropdownMenuItem(
          child: Text(
            catData[i],
            style: TextStyle(
              color: Colors.blueGrey[300],
            ),
          ),
          value: catData[i],
        ),
      );
    }
    catDataSelected = catData[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Create Event Step : 1'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 100.0),
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: <Widget>[
                          Card(
                            color: Colors.grey[200],
                            elevation: 1.1,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: 100.0,
                              child: ListView(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text('This is Step for create event'),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Event Name is Name of Event'),
                                          Text('Step : 1 Chose Category of product'),
                                          Text('Step : 2 Chose Type of product'),
                                          Text('Step : 3 Chose Color or Size of product'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            controller: _eventName,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.event,
                                color: Colors.blueGrey[300],
                              ),
                              hintText: 'Event Name',
                              hintStyle: TextStyle(color: Colors.blueGrey[300]),
                              labelText: 'Event Name',
                              labelStyle: TextStyle(color: Colors.blueGrey[300]),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Plese Fill Event Name';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  width: 0.5
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey[100],
                            ),
                            child: DropdownMenuItem(
                              child: DropdownButton(
                                items: catToDo,
                                value: catDataSelected,
                                isExpanded: true,
                                onChanged: (data) {
                                  setState(() {
                                    catDataSelected = data;
                                  });
                                },
                              ),
                            ),
                          ), //CATEGORY
                          SizedBox(
                            height: 30.0,
                          ),
                          RaisedButton(
                            onPressed: (){
                              //if(_formKey.currentState.validate()){}
                              if(catDataSelected == 'Clothing'){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>ClothingSelect())
                                );
                              }else if(catDataSelected == 'Shoes'){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>ShoesSelect())
                                );
                              }else if(catDataSelected == 'Gadget'){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>GadgetSelect())
                                );
                              }else if(catDataSelected == 'Sport'){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>SportSelect())
                                );
                              }else{
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>ElectronicSelect())
                                );
                              }
                            },
                            color: Colors.blueGrey[300],
                            child: Text('Next',style: TextStyle(color: Colors.white,fontSize: 20),),
                          ),//CREATE EVENT
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
