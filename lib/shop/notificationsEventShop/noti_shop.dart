import 'package:finalproject/shop/notificationsEventShop/detail_event_shop.dart';
import 'package:flutter/material.dart';

class NotificationShop extends StatefulWidget {
  @override
  _NotificationShopState createState() => _NotificationShopState();
}

class _NotificationShopState extends State<NotificationShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.white,fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 5.0,
              ),
              ListTile(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>DetailEventShop())
                  );
                },
                leading: CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/prototype/sony.jpg',
                  ),
                  maxRadius: 35.0,
                ),
                title: Text('Product : Sony WF-1000xm3',style: TextStyle(fontSize: 18),),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Need to Deal with You'),
                    Row(
                      children: <Widget>[
                        Icon(Icons.access_time),
                        Text('01/27/2020')
                      ],
                    ),
                  ],
                ),
                trailing: IconButton(
                  onPressed: (){},
                  icon: Icon(
                      Icons.more_vert
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Divider(
                height: 5.0,
                color: Colors.grey,
              ),
              SizedBox(
                height: 5.0,
              ),
              ListTile(
                onTap: (){},
                leading: CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/prototype/timbuk.jpg',
                  ),
                  maxRadius: 35.0,
                ),
                title: Text('Product : Timbuk 2',style: TextStyle(fontSize: 18),),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Need to Deal with You'),
                    Row(
                      children: <Widget>[
                        Icon(Icons.access_time),
                        Text('01/27/2020')
                      ],
                    ),
                  ],
                ),
                trailing: IconButton(
                  onPressed: (){},
                  icon: Icon(
                      Icons.more_vert
                  ),
                ),
              ),
              Divider(
                height: 5.0,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}