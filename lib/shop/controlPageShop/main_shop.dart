import 'package:finalproject/shop/cart_shop.dart';
import 'package:finalproject/shop/home_shop.dart';
import 'package:finalproject/shop/notificationsEventShop/noti_shop.dart';
import 'package:finalproject/shop/profileShop/profile_shop.dart';
import 'package:flutter/material.dart';

class MainShop extends StatefulWidget {
  @override
  _MainShopState createState() => _MainShopState();
}

class _MainShopState extends State<MainShop> {
  int c_index = 0;
  List<Widget> screen = [
    HomeShop(),
    NotificationShop(),
    CartShop(),
    ProfileShop(),
  ];

  Widget show_screen;

  @override
  void initState() {
    // TODO: implement initState
    show_screen = screen[0];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: show_screen,
      bottomNavigationBar: Container(
        color: Colors.deepOrange,
        child: BottomNavigationBar(
          onTap: (value_data){
            setState(() {
              c_index = value_data;
              show_screen = screen[value_data];
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
                  Icons.home
              ),
              title: Text(
                'Home',style: TextStyle(fontSize: 10),
              ),
            ),//HOME
            BottomNavigationBarItem(
              activeIcon: Icon(
                  Icons.notifications
              ),
              icon: Icon(
                  Icons.notifications
              ),
              title: Text(
                'Notification',style: TextStyle(fontSize: 10),
              ),
            ),//NOTIFICATION
            BottomNavigationBarItem(
              activeIcon: Icon(
                  Icons.shopping_cart
              ),
              icon: Icon(
                  Icons.shopping_cart
              ),
              title: Text(
                'Cart',style: TextStyle(fontSize: 10),
              ),
            ),//CART
            BottomNavigationBarItem(
              activeIcon: Icon(
                  Icons.person
              ),
              icon: Icon(
                  Icons.person
              ),
              title: Text(
                'Profile',style: TextStyle(fontSize: 10),
              ),
            ),//PROFILE
          ],
        ),
      ),
    );
  }
}