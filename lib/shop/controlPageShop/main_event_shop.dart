
import 'package:finalproject/shop/shop_event.dart';
import 'package:finalproject/shop/shop_event_shop.dart';
import 'package:flutter/material.dart';

class MainEventShop extends StatefulWidget {
  final String evID;
  MainEventShop(this.evID);
  @override
  _MainEventShopState createState() => _MainEventShopState();
}

class _MainEventShopState extends State<MainEventShop> with SingleTickerProviderStateMixin{
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
          ShopEvent(widget.evID),
          ShopEventShop(widget.evID),
        ],
      ),
    );
  }
}
