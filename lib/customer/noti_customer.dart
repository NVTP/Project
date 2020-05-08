import 'package:finalproject/customer/checkouts.dart';
import 'package:finalproject/customer/controlPageCustomer/main_event.dart';
import 'package:flutter/material.dart';

class NotificationCustomer extends StatefulWidget {
  @override
  _NotificationCustomerState createState() => _NotificationCustomerState();
}

class _NotificationCustomerState extends State<NotificationCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Notifications', style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            ListTile(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>MainEvent())
                );
              },
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/prototype/sony.jpg'),
                backgroundColor: Colors.transparent,
                radius: 30,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Sony wf-1000xm3'),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.access_time),
                        Text('2020/1/16'),
                      ],
                    ),
                  ),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=>Checkouts())
                          );
                        },
                        elevation: 1.1,
                        child: Text('OK',style: TextStyle(color: Colors.white),),
                        color: Colors.blueGrey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        onPressed: (){},
                        elevation: 1.1,
                        child: Text('Cancel',style: TextStyle(color: Colors.white),),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Divider(
                height: 2.0,
                color: Colors.blueGrey,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            ListTile(
              onTap: (){},
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/prototype/timbuk.jpg'),
                backgroundColor: Colors.transparent,
                radius: 30,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Timbuk 2'),
                  Container(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.access_time),
                          Text('2020/1/16'),
                        ],
                      )
                  ),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        onPressed: (){},
                        elevation: 1.1,
                        child: Text('OK',style: TextStyle(color: Colors.white),),
                        color: Colors.blueGrey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        onPressed: (){},
                        elevation: 1.1,
                        child: Text('Cancel',style: TextStyle(color: Colors.white),),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Divider(
                height: 2.0,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}