import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/customer/controlPageCustomer/main_event.dart';
import 'package:flutter/material.dart';

class SearchCus extends StatefulWidget {
  @override
  _SearchCusState createState() => _SearchCusState();
}

class _SearchCusState extends State<SearchCus> {
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowSearchCus(_search.text)));
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

class ShowSearchCus extends StatefulWidget {
  String name;
  ShowSearchCus(this.name);
  @override
  _ShowSearchCusState createState() => _ShowSearchCusState();
}

class _ShowSearchCusState extends State<ShowSearchCus> {
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
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MainEvent(reversedDocuments[index].data['eventId'])));
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

