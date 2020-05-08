import 'file:///C:/Users/Pound/StudioProjects/final_project/lib/customer/createEvent/finish_event.dart';
import 'package:flutter/material.dart';

class ShoesSelect extends StatefulWidget {
  @override
  _ShoesSelectState createState() => _ShoesSelectState();
}

class _ShoesSelectState extends State<ShoesSelect> {
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
                        MaterialPageRoute(builder: (context)=>FinishEvent(category: 'Shoes',))
                    );
                  },
                  title: Text('Men\'s Shoes'),
                  trailing: Icon(
                      Icons.arrow_forward_ios
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                ListTile(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>FinishEvent(category: 'Shoes',))
                    );
                  },
                  title: Text('Women\'s Shoes'),
                  trailing: Icon(
                      Icons.arrow_forward_ios
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}