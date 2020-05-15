import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/shop/controlPageShop/main_event_shop.dart';
import 'package:finalproject/shop/controlPageShop/main_shop.dart';
import 'package:finalproject/shop/home_shop.dart';
import 'package:finalproject/shop/shop_event.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _search;

  @override
  void initState() {
    // TODO: implement initState
    _search = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Form(
          key: _formKey,
          child: TextFormField(
            maxLines: 1,
            autofocus: true,
            keyboardType: TextInputType.text,
            controller: _search,
            onTap: (){
              print('112');
            },
            decoration: InputDecoration(
              hintText: 'Search Product',
              hintStyle: TextStyle(color: Colors.grey[200]),
              suffixIcon: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                  setState(() {
                    _search.clear();
                  });
                },
                icon: Icon(Icons.cancel),
                color: Colors.grey[200],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: RaisedButton(
              onPressed: (){
                print(_search.text);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowSearch(_search.text)));
              },
              child: Text('Search'),
            ),
          ),
        ],
      )
    );
  }
  Widget getData(String data){
    return Expanded(
      child: StreamBuilder(
        stream: Firestore.instance.collection('events').where('productName',isLessThanOrEqualTo: data).orderBy('createAt',descending: false).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            List<DocumentSnapshot> reversedDocuments = snapshot.data.documents.reversed.toList();
            return ListView.separated(
              separatorBuilder: (context,index){
                return SizedBox(
                  height: 12,
                  child: Divider(
                    height: 1,
                    color: Colors.red,
                  ),
                );
              },
              itemCount: reversedDocuments.length,
              itemBuilder: (context, index){
                return Column(
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300],width: 1),
                        color: Colors.black12,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(reversedDocuments[index].data['image'].toString())
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ShowSearch extends StatefulWidget {
  String name;
  ShowSearch(this.name);
  @override
  _ShowSearchState createState() => _ShowSearchState();
}

class _ShowSearchState extends State<ShowSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('events').where('productName',isEqualTo: widget.name).orderBy('createAt',descending: false).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            List<DocumentSnapshot> reversedDocuments = snapshot.data.documents.reversed.toList();
            return ListView.separated(
              separatorBuilder: (context,index){
                return SizedBox(
                  height: 12,
                  child: Divider(
                    height: 1,
                    color: Colors.red,
                  ),
                );
              },
              itemCount: reversedDocuments.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22,vertical: 12),
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: (){
                          print(reversedDocuments[index].data['eventId']);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MainEventShop(reversedDocuments[index].data['eventId'])));
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300],width: 1),
                            color: Colors.black12,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(reversedDocuments[index].data['image'].toString())
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

