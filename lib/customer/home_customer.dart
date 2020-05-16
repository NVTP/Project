import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/controllers/event_controller.dart';
import 'package:finalproject/customer/controlPageCustomer/main_event.dart';
import 'package:finalproject/customer/search_cus.dart';
import 'package:finalproject/services/notifier/event_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeCustomer extends StatefulWidget {
  @override
  _HomeCustomerState createState() => _HomeCustomerState();
}

class _HomeCustomerState extends State<HomeCustomer> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
    getEvent(eventNotifier);
  }
  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    Future<void> _refreshList()async{
      getEvent(eventNotifier);
    }
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          InkWell(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context)=>SearchCus()
                  )
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[100],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0,right: 10.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ),
                  Text('Search',style: TextStyle(color: Colors.grey,fontSize: 18),),
                ],
              ),
            ),
          ),
        ],
      ),
        body: RefreshIndicator(
          onRefresh: _refreshList,
          child: StreamBuilder(
            stream: Firestore.instance.collection('events').orderBy('createAt',descending: true).snapshots(),
            builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator(),);
              }else{
                List<DocumentSnapshot> reversedDocuments = snapshot.data.documents.reversed.toList();
                return ListView.separated(
                  separatorBuilder: (context,index){
                    return SizedBox(
                      height: 22,
                      child: Divider(
                        height: 1,
                        color: Colors.red,
                      ),
                    );
                  },
                  itemCount: reversedDocuments.length,
                  itemBuilder: (context,index){
                    return Column(
                      children: <Widget>[
                        SizedBox(
                          height: 8,
                        ),
                        InkWell(
                          onTap: (){
                            print(reversedDocuments[index].data['eventId']);
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context)=>MainEvent(
                                  reversedDocuments[index].data['eventId'].toString(),
                                ))
                            );
                          },
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 40,
                              ),
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300],width: 1),
                                    borderRadius: BorderRadius.circular(22),
                                    color: Colors.black12,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(reversedDocuments[index].data['image'].toString())
                                      ),
                                ),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Text(reversedDocuments[index].data['productName'].toString())
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ),
//      body: RefreshIndicator(
//        child: ListView.separated(
//          separatorBuilder: (context, index){
//            return SizedBox(
//              height: 22,
//              child: Divider(
//                height: 0,
//                color: Colors.grey,
//              ),
//            );
//          },
//          itemCount: eventNotifier.eventList.length,
//          itemBuilder: (BuildContext context,int index){
//            return Column(
//              children: <Widget>[
//                SizedBox(
//                  height: 8,
//                ),
//                InkWell(
//                  highlightColor: Colors.transparent,
//                  focusColor: Colors.transparent,
//                  splashColor: Colors.transparent,
//                  hoverColor: Colors.transparent,
//                  onTap: (){
//                    eventNotifier.currentEvent = eventNotifier.eventList[index];
//                    Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context)=>MainEvent())
//                    );
//                  },
//                  child: Row(
//                    children: <Widget>[
//                      SizedBox(
//                        width: 40,
//                      ),
//                      Container(
//                        width: 100,
//                        height: 100,
//                        decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(12),
//                          border: Border.all(color: Colors.grey[300]),
//                          image: DecorationImage(
//                            fit: BoxFit.cover,
//                            image: NetworkImage(
//                              eventNotifier.eventList[index].image,
//                            ),
//                          ),
//                        ),
//                      ),
//                      SizedBox(
//                        width: 40,
//                      ),
//                      Text(
//                        eventNotifier.eventList[index].productName,
//                      ),
//                    ],
//                  ),
//                ),
//                SizedBox(
//                  height: 8,
//                ),
//              ],
//            );
//          },
//          shrinkWrap: true,
//        ),
//        onRefresh: _refreshList,
//      ),



//      body: Stack(
//        fit: StackFit.expand,
//        children: <Widget>[
//          SafeArea(
//            child: Column(
//              children: <Widget>[
//                SizedBox(
//                  height: 10.0,
//                ),
//                Expanded(
//                  flex: 1,
//                  child: Container(
//                      alignment: Alignment.topCenter,
//                      child: SingleChildScrollView(
//                       child: Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          Container(
//                            height: 70,
//                            child: Card(
//                              elevation: 1.0,
//                              shape: RoundedRectangleBorder(
//                                borderRadius: BorderRadius.circular(20)
//                              ),
//                              child: ListView(
//                                scrollDirection: Axis.horizontal,
//                                children: <Widget>[
//                                  Row(
//                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                    crossAxisAlignment: CrossAxisAlignment.center,
//                                    children: <Widget>[
//                                      RawMaterialButton(
//                                        onPressed: (){
//                                          Navigator.push(context,
//                                              MaterialPageRoute(builder: (context)=>Gadget())
//                                          );
//                                        },
//                                        child: Image.asset(
//                                          'assets/images/Computer.png',
//                                          color: Colors.blueGrey,
//                                          alignment: Alignment.center,
//                                          fit: BoxFit.cover,
//                                          height: 50.0,
//                                        ),
//                                        elevation: 1.0,
//                                        shape: RoundedRectangleBorder(
//                                          borderRadius: BorderRadius.circular(20),
//                                        ),
//                                      ),
//                                      RawMaterialButton(
//                                        onPressed: (){
//                                          Navigator.push(context,
//                                          MaterialPageRoute(
//                                            builder: (context)=>Clothing(),
//                                          )
//                                          );
//                                        },
//                                        child: Image.asset(
//                                          'assets/images/Clothing.png',
//                                          color: Colors.blueGrey,
//                                          alignment: Alignment.center,
//                                          fit: BoxFit.cover,
//                                          height: 50.0,
//                                        ),
//                                        elevation: 1.0,
//                                        shape: RoundedRectangleBorder(
//                                          borderRadius: BorderRadius.circular(20),
//                                        ),
//                                      ),
//                                      RawMaterialButton(
//                                        onPressed: (){
//                                          Navigator.push(context,
//                                          MaterialPageRoute(
//                                            builder: (context)=>Shoes(),
//                                          )
//                                          );
//                                        },
//                                        child: Image.asset(
//                                          'assets/images/shoes.png',
//                                          color: Colors.blueGrey,
//                                          alignment: Alignment.center,
//                                          fit: BoxFit.cover,
//                                          height: 50.0,
//                                        ),
//                                        elevation: 1.0,
//                                        shape: RoundedRectangleBorder(
//                                          borderRadius: BorderRadius.circular(20),
//                                        ),
//                                      ),
//                                      RawMaterialButton(
//                                        onPressed: (){
//                                          Navigator.push(context,
//                                          MaterialPageRoute(builder: (context)=>Sport())
//                                          );
//                                        },
//                                        child: Image.asset(
//                                          'assets/images/sport.png',
//                                          color: Colors.blueGrey,
//                                          alignment: Alignment.center,
//                                          fit: BoxFit.cover,
//                                          height: 50.0,
//                                        ),
//                                        elevation: 1.0,
//                                        shape: RoundedRectangleBorder(
//                                          borderRadius: BorderRadius.circular(20),
//                                        ),
//                                      ),
//                                      RawMaterialButton(
//                                        onPressed: (){
//                                          Navigator.push(context,
//                                          MaterialPageRoute(builder: (context)=>Electronic())
//                                          );
//                                        },
//                                        child: Image.asset(
//                                          'assets/images/eletronic.png',
//                                          color: Colors.blueGrey,
//                                          alignment: Alignment.center,
//                                          fit: BoxFit.cover,
//                                          height: 50.0,
//                                        ),
//                                        elevation: 1.0,
//                                        shape: RoundedRectangleBorder(
//                                          borderRadius: BorderRadius.circular(20),
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ),
//                          Container(
//                            width: MediaQuery.of(context).size.width,
//                            decoration: BoxDecoration(
//                              borderRadius: BorderRadius.circular(20),
//                            ),
//                            child: Column(
//                              children: <Widget>[
//                                Padding(
//                                  padding: const EdgeInsets.only(left: 20.0,top: 12.0),
//                                  child: Row(
//                                    crossAxisAlignment: CrossAxisAlignment.start,
//                                    children: <Widget>[
//                                      Icon(
//                                        Icons.new_releases,
//                                        color: Colors.blueGrey,
//                                      ),
//                                      SizedBox(
//                                        width: 10.0,
//                                      ),
//                                      Text('New !',style: TextStyle(color: Colors.blueGrey,fontSize: 20.0,fontWeight: FontWeight.bold),),
//                                      SizedBox(
//                                        width: 10.0,
//                                      ),
//                                      InkWell(
//                                        onTap: (){
//                                          Navigator.push(context,
//                                          MaterialPageRoute(builder: (context)=>NewCustomer())
//                                          );
//                                        },
//                                        child: Text('See all',style: TextStyle(color: Colors.blueGrey,fontSize: 20,decoration: TextDecoration.underline),),
//                                      ),
//                                    ],
//                                  ),
//                                ),//NEW
//                                Card(
//                                  elevation: 9.8,
//                                  shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.circular(20)
//                                  ),
//                                  child: SingleChildScrollView(
//                                    scrollDirection: Axis.horizontal,
//                                    child: Column(
//                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                      crossAxisAlignment: CrossAxisAlignment.start,
//                                      children: <Widget>[
//                                        Padding(
//                                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
//                                           child: Row(
//                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                            crossAxisAlignment: CrossAxisAlignment.start,
//                                            children: <Widget>[
//                                              InkWell(
//                                                onTap: (){
//                                                  Navigator.push(context,
//                                                    MaterialPageRoute(
//                                                      builder: (context)=>MainEvent()
//                                                    )
//                                                  );
//                                                },
//                                                child: Column(
//                                                  children: <Widget>[
//                                                    Container(
//                                                      margin: EdgeInsets.symmetric(horizontal: 5.0),
//                                                      height: 150,
//                                                      width: 150,
//                                                      decoration: BoxDecoration(
//                                                          borderRadius: BorderRadius.circular(20)
//                                                      ),
//                                                      child: Image.asset('assets/prototype/sony.jpg',fit: BoxFit.fill,),
//                                                    ),
//                                                    Text('Sony WF-1000xm3',style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold),),
//                                                    SizedBox(
//                                                      height: 10.0,
//                                                    ),
//                                                  ],
//                                                ),
//                                              ),
//                                              InkWell(
//                                                onTap: (){},
//                                                child: Column(
//                                                  children: <Widget>[
//                                                    Container(
//                                                      margin: EdgeInsets.symmetric(horizontal: 5.0),
//                                                      width: 150,
//                                                      height: 150,
//                                                      decoration: BoxDecoration(
//                                                          borderRadius: BorderRadius.circular(20)
//                                                      ),
//                                                      child: Image.asset('assets/prototype/levis.jpg',fit: BoxFit.fill,),
//                                                    ),
//                                                    Text('Levi\'s',style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold),),
//                                                    SizedBox(
//                                                      height: 10.0,
//                                                    ),
//                                                  ],
//                                                ),
//                                              ),
//                                              InkWell(
//                                                onTap: (){},
//                                                child: Column(
//                                                  children: <Widget>[
//                                                    Container(
//                                                      margin: EdgeInsets.symmetric(horizontal: 5.0),
//                                                      height: 150,
//                                                      width: 150,
//                                                      decoration: BoxDecoration(
//                                                          borderRadius: BorderRadius.circular(20)
//                                                      ),
//                                                      child: Image.asset('assets/prototype/stan.jpg',fit: BoxFit.fill,),
//                                                    ),
//                                                    Text('Adidas Stan Smith',style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold),),
//                                                    SizedBox(
//                                                      height: 10.0,
//                                                    ),
//                                                  ],
//                                                ),
//                                              ),
//                                              InkWell(
//                                                onTap: (){},
//                                                child: Column(
//                                                  children: <Widget>[
//                                                    Container(
//                                                      margin: EdgeInsets.symmetric(horizontal: 5.0),
//                                                      width: 150,
//                                                      height: 150,
//                                                      decoration: BoxDecoration(
//                                                          borderRadius: BorderRadius.circular(20)
//                                                      ),
//                                                      child: Image.asset('assets/prototype/timbuk.jpg',fit: BoxFit.fill,),
//                                                    ),
//                                                    Text('Timbuk 2',style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold),),
//                                                    SizedBox(
//                                                      height: 10.0,
//                                                    ),
//                                                  ],
//                                                ),
//                                              ),
//                                              InkWell(
//                                                onTap: (){},
//                                                child: Column(
//                                                  children: <Widget>[
//                                                    Container(
//                                                      margin: EdgeInsets.symmetric(horizontal: 5.0),
//                                                      width: 150,
//                                                      height: 150,
//                                                      decoration: BoxDecoration(
//                                                          borderRadius: BorderRadius.circular(20)
//                                                      ),
//                                                      child: Image.asset('assets/prototype/timbuk.jpg',fit: BoxFit.fill,),
//                                                    ),
//                                                    Text('Timbuk 2',style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold),),
//                                                    SizedBox(
//                                                      height: 10.0,
//                                                    ),
//                                                  ],
//                                                ),
//                                              ),
//                                            ],
//                                          ),
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//                                ),//EVENT NEW
//                                SizedBox(
//                                  height: 15.0,
//                                ),
//                                Padding(
//                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                                  child: Divider(
//                                    height: 2.0,
//                                    color: Colors.blueGrey[800],
//                                  ),
//                                ),//DIVIDER
//                                Padding(
//                                  padding: const EdgeInsets.only(left: 20.0,top: 12.0),
//                                  child: Row(
//                                    crossAxisAlignment: CrossAxisAlignment.start,
//                                    children: <Widget>[
//                                      Icon(
//                                        Icons.access_time,
//                                        color: Colors.blueGrey,
//                                      ),
//                                      SizedBox(
//                                        width: 10.0,
//                                      ),
//                                      Text('Warning Time !',
//                                        style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold,fontSize: 20.0),
//                                      ),
//                                      SizedBox(
//                                        width: 10.0,
//                                      ),
//                                      InkWell(
//                                        onTap: (){
//                                          Navigator.push(context,
//                                          MaterialPageRoute(builder: (context)=>WarningTime())
//                                          );
//                                        },
//                                        child: Text('See all',style: TextStyle(color: Colors.blueGrey,fontSize: 20,decoration: TextDecoration.underline),),
//                                      ),
//                                    ],
//                                  ),
//                                ),//WARNING TIME
//                                Card(
//                                  elevation: 9.8,
//                                  shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.circular(20)
//                                  ),
//                                  child: SingleChildScrollView(
//                                    scrollDirection: Axis.horizontal,
//                                    child: Column(
//                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                      crossAxisAlignment: CrossAxisAlignment.start,
//                                      children: <Widget>[
//                                        Padding(
//                                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
//                                          child: Row(
//                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                            crossAxisAlignment: CrossAxisAlignment.start,
//                                            children: <Widget>[
//                                              InkWell(
//                                                onTap: (){},
//                                                child: Column(
//                                                  children: <Widget>[
//                                                    Container(
//                                                      margin: EdgeInsets.symmetric(horizontal: 5.0),
//                                                      height: 150,
//                                                      width: 150,
//                                                      decoration: BoxDecoration(
//                                                          borderRadius: BorderRadius.circular(20)
//                                                      ),
//                                                      child: Image.asset('assets/prototype/levis.jpg',fit: BoxFit.fill,),
//                                                    ),
//                                                    Row(
//                                                        children: <Widget>[
//                                                          Icon(Icons.watch_later,color: Colors.blueGrey,),
//                                                          Text('2020/1/23',
//                                                            style: TextStyle(
//                                                                fontSize: 12.0,fontWeight: FontWeight.bold,color: Colors.blueGrey
//                                                            ),
//                                                          ),
//                                                        ],
//                                                    ),
//                                                    SizedBox(
//                                                      height: 10.0,
//                                                    ),
//                                                  ],
//                                                ),
//                                              ),
//                                              InkWell(
//                                                onTap: (){},
//                                                child: Column(
//                                                  children: <Widget>[
//                                                    Container(
//                                                      margin: EdgeInsets.symmetric(horizontal: 5.0),
//                                                      height: 150,
//                                                      width: 150,
//                                                      decoration: BoxDecoration(
//                                                          borderRadius: BorderRadius.circular(20)
//                                                      ),
//                                                      child: Image.asset('assets/prototype/intel.jpg',fit: BoxFit.fill,),
//                                                    ),
//                                                    Row(
//                                                      children: <Widget>[
//                                                        Icon(Icons.watch_later,color: Colors.blueGrey,),
//                                                        Text('2020/1/23',
//                                                          style: TextStyle(
//                                                              fontSize: 12.0,fontWeight: FontWeight.bold,color: Colors.blueGrey
//                                                          ),
//                                                        ),
//                                                      ],
//                                                    ),
//                                                    SizedBox(
//                                                      height: 10.0,
//                                                    ),
//                                                  ],
//                                                ),
//                                              ),
//                                              InkWell(
//                                                onTap: (){},
//                                                child: Column(
//                                                  children: <Widget>[
//                                                    Container(
//                                                      margin: EdgeInsets.symmetric(horizontal: 5.0),
//                                                      height: 150,
//                                                      width: 150,
//                                                      decoration: BoxDecoration(
//                                                          borderRadius: BorderRadius.circular(20)
//                                                      ),
//                                                      child: Image.asset('assets/prototype/timbuk.jpg',fit: BoxFit.fill,),
//                                                    ),
//                                                    Row(
//                                                      children: <Widget>[
//                                                        Icon(Icons.watch_later,color: Colors.blueGrey,),
//                                                        Text('2020/1/23',
//                                                          style: TextStyle(
//                                                              fontSize: 12.0,fontWeight: FontWeight.bold,color: Colors.blueGrey
//                                                          ),
//                                                        ),
//                                                      ],
//                                                    ),
//                                                    SizedBox(
//                                                      height: 10.0,
//                                                    ),
//                                                  ],
//                                                ),
//                                              ),
//                                              InkWell(
//                                                onTap: (){},
//                                                child: Column(
//                                                  children: <Widget>[
//                                                    Container(
//                                                      margin: EdgeInsets.symmetric(horizontal: 5.0),
//                                                      height: 150,
//                                                      width: 150,
//                                                      decoration: BoxDecoration(
//                                                          borderRadius: BorderRadius.circular(20)
//                                                      ),
//                                                      child: Image.asset('assets/prototype/stan.jpg',fit: BoxFit.fill,),
//                                                    ),
//                                                    Row(
//                                                      children: <Widget>[
//                                                        Icon(Icons.watch_later,color: Colors.blueGrey,),
//                                                        Text('2020/1/23',
//                                                          style: TextStyle(
//                                                              fontSize: 12.0,fontWeight: FontWeight.bold,color: Colors.blueGrey
//                                                          ),
//                                                        ),
//                                                      ],
//                                                    ),
//                                                    SizedBox(
//                                                      height: 10.0,
//                                                    ),
//                                                  ],
//                                                ),
//                                              ),
//                                            ],
//                                          ),
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//                                ),//EVENT WARNING
//                              ],
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ],
//      ),
    );
  }
}