import 'package:finalproject/customer/checkouts.dart';
import 'package:flutter/material.dart';

class EventCusShop extends StatefulWidget {
  @override
  _EventCusShopState createState() => _EventCusShopState();
}

class _EventCusShopState extends State<EventCusShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            ListTile(
              leading: CircleAvatar(
                maxRadius: 35.0,
                backgroundImage: AssetImage('assets/prototype/sony.jpg'),
              ),
              trailing: RaisedButton(
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>Checkouts())
                  );
                },
                elevation: 1.1,
                color: Colors.blueGrey[400],
                child: Text('Deal',style: TextStyle(color: Colors.white),),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Price : 1500.00'),
                  Text('Quantity : 120'),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
              subtitle: Text('Shop : Sony Thailand'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
                height: 4.8,
                color: Colors.grey,
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                maxRadius: 35.0,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/prototype/razer.jpg'),
              ),
              trailing: RaisedButton(
                onPressed: (){},
                elevation: 1.1,
                color: Colors.blueGrey[400],
                child: Text('Deal',style: TextStyle(color: Colors.white),),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Price : 1500.00'),
                  Text('Quantity : 120'),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
              subtitle: Text('Shop : AAAA'),
            ),
          ],
        ),
      ),
    );
  }
}