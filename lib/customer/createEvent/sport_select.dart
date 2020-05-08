import 'file:///C:/Users/Pound/StudioProjects/final_project/lib/customer/createEvent/finish_event.dart';
import 'package:flutter/material.dart';

class SportSelect extends StatefulWidget {
  @override
  _SportSelectState createState() => _SportSelectState();
}

class _SportSelectState extends State<SportSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Create Event Step : 2'),
              centerTitle: true,
              floating: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: 5.0,
                ),
                ListTile(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>FinishEvent(category: 'Sport',))
                    );
                  },
                  title: Text('Gadget fot Sport'),
                  trailing: Icon(
                      Icons.arrow_forward_ios
                  ),
                ),//GADGET
                SizedBox(
                  height: 5.0,
                ),
                ListTile(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>FinishEvent(category: 'Sport',))
                    );
                  },
                  title: Text('Men\'s'),
                  trailing: Icon(
                      Icons.arrow_forward_ios
                  ),
                ),//MEN
                SizedBox(
                  height: 5.0,
                ),
                ListTile(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>FinishEvent(category: 'Sport',))
                    );
                  },
                  title: Text('Women\'s'),
                  trailing: Icon(
                      Icons.arrow_forward_ios
                  ),
                ),//WOMEN
              ]),
            ),
          ],
        ),
      ),
    );
  }
}