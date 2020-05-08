import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomerStatus extends StatefulWidget {
  @override
  _CustomerStatusState createState() => _CustomerStatusState();
}

class _CustomerStatusState extends State<CustomerStatus> {
  var proFile;
  var inStead = 'https://firebasestorage.googleapis.com/v0/b/login-ce9de.appspot.com/o/user%2Fimages.png?alt=media&token=bbc9397d-f425-4834-82f1-5e6855b4a171';
  var email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.currentUser().then((user){
      setState(() {
        proFile = user.photoUrl;
        email = user.email;
      });
    }).catchError((e){
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            centerTitle: true,
            title: Text('Information Customer'),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              proFile ?? inStead
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.grey,
                height: 1.0,
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(
                      'assets/prototype/sony.jpg'
                  ),
                  radius: 30,
                ),
                title: Text('Sony wf-1000xm3'),
                subtitle: Text('Status : Sending'),
              ),
              Divider(
                height: 0.0,
                color: Colors.grey,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}