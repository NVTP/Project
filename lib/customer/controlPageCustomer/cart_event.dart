import 'package:finalproject/customer/cart_customer.dart';
import 'package:finalproject/customer/cart_customer_join.dart';
import 'package:flutter/material.dart';
// This Page Controller Cart of Customer
class CartEvent extends StatefulWidget {
  @override
  _CartEventState createState() => _CartEventState();
}

class _CartEventState extends State<CartEvent> with SingleTickerProviderStateMixin{
  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Cart',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
        bottom: TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.white,
          indicatorColor: Colors.black,
          controller: tabController,
          tabs: <Widget>[
            Tab(
              text: 'My Event',
            ),
            Tab(
              text: 'Join Event',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          CartCustomer(),
          CartCusJoin(),
        ],
      ),
    );
  }
}