import 'package:finalproject/customer/controlPageCustomer/cart_event.dart';
import 'package:finalproject/customer/createEvent/create_event.dart';
import 'package:finalproject/customer/home_customer.dart';
import 'package:finalproject/customer/noti_customer.dart';
import 'package:finalproject/customer/profile_customer.dart';
import 'package:flutter/material.dart';

class MainCustomer extends StatefulWidget {
  @override
  _MainCustomerState createState() => _MainCustomerState();
}

class _MainCustomerState extends State<MainCustomer> {
  int c_index = 0;
  List<Widget> Screen = [
    HomeCustomer(),
    NotificationCustomer(),
    CreateEvent(),
    CartEvent(),
    ProfileCustomer()
  ];

  Widget show_screen; //เก็บค่า screen ที่ show

  @override
  void initState() {
    // TODO: implement initState
    show_screen = Screen[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: show_screen,
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          onTap: (value_data) {
            setState(() {
              c_index = value_data;
              show_screen = Screen[value_data];
            });
          },
          currentIndex: c_index,
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.red[600],
          items: [
            BottomNavigationBarItem(
              activeIcon: Icon(
                  Icons.home
              ),
              icon: Icon(
                Icons.home,
                color: Colors.blueGrey,
              ),
              title: Text('Home', style: TextStyle(fontSize: 10),),
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                  Icons.notifications
              ),
              icon: Icon(
                Icons.notifications,
                color: Colors.blueGrey,
              ),
              title: Text('Status', style: TextStyle(fontSize: 10),),
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.add_box,
              ),
              icon: Icon(
                Icons.add_box,
                color: Colors.blueGrey,
              ),
              title: Text('Create', style: TextStyle(fontSize: 10),),
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                  Icons.shopping_cart
              ),
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.blueGrey,
              ),
              title: Text('Cart', style: TextStyle(fontSize: 10),),
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                  Icons.person
              ),
              icon: Icon(
                Icons.person,
                color: Colors.blueGrey,
              ),
              title: Text('Profile', style: TextStyle(fontSize: 10),),
            ),
          ],
        ),
      ),
    );
  }
}