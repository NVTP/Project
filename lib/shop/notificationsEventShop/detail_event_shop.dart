import 'package:finalproject/shop/notificationsEventShop/detail_customer.dart';
import 'package:flutter/material.dart';

class DetailEventShop extends StatefulWidget {
  @override
  _DetailEventShopState createState() => _DetailEventShopState();
}

class _DetailEventShopState extends State<DetailEventShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Detail Event'),
            centerTitle: true,
            floating: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>DetailCustomer())
                        );
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(
                            'assets/prototype/virgil.jpg'
                        ),
                      ),
                      title: Text('Virgil van Dijk'),
                      subtitle: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Quantity : 2'),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text('Color : Black'),
                        ],
                      ),
                    ),
                    Divider(
                      height: 5.0,
                      color: Colors.grey,
                    ),
                    ListTile(
                      onTap: (){},
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(
                            'assets/prototype/razer.jpg'
                        ),
                      ),
                      title: Text('AAAA'),
                      subtitle: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Quantity : 2'),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text('Color : Black'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}