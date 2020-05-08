import 'package:finalproject/customer/event_cus_shop.dart';
import 'package:finalproject/customer/event_customer.dart';
import 'package:flutter/material.dart';

class MainEvent extends StatefulWidget {
  @override
  _MainEventState createState() => _MainEventState();
}

class _MainEventState extends State<MainEvent> with SingleTickerProviderStateMixin{
  TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.white,
          indicatorColor: Colors.black,
          controller: tabController,
          tabs: <Widget>[
            Tab(
              text: 'Event',
            ),
            Tab(
              text: 'Shop',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          EventCustomer(),
          EventCusShop(),
        ],
      ),
    );
  }
}