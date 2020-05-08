import 'package:flutter/material.dart';

class DetailCustomer extends StatefulWidget {
  @override
  _DetailCustomerState createState() => _DetailCustomerState();
}

class _DetailCustomerState extends State<DetailCustomer> {
  bool cbSend;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cbSend = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Detail Customer'),
            centerTitle: true,
            floating: true,
          ),
          SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1.0,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              delegate: SliverChildListDelegate([
                Container(
                  width: 250,
                  height: 200,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 20,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage(
                                'assets/prototype/virgil.jpg'
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Virgil van Dijk'),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10,left: 20,right: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        child: Card(
                          elevation: 1.1,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                            child: Column(
                              children: <Widget>[
                                Text('Color : Black'),
                                Text('Quantlity : 2'),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: Colors.red[700],
                                            width: 1.0
                                        )
                                    ),
                                    child: Text('167/1 ถ.เจษฎาวิถี ต.มหาชัย อ.เมือง จ.สมุทรสาคร')
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                      value: cbSend,
                                      onChanged: (data){
                                        setState(() {
                                          cbSend = data;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Finished'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.black,
                  height: 200,
                  width: 250,
                ),
                Container(
                  width: 250,
                  height: 200,
                  color: Colors.amber,
                ),
              ])
          ),
        ],
      ),
    );
  }
}