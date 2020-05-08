import 'package:finalproject/customer/createEvent/finish_event.dart';
import 'package:flutter/material.dart';

class ElectronicSelect extends StatefulWidget {
  @override
  _ElectronicSelectState createState() => _ElectronicSelectState();
}

class _ElectronicSelectState extends State<ElectronicSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Create Event Step : 2'),
              floating: true,
              centerTitle: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: 5.0,
                ),
                ListTile(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>FinishEvent(category: 'Electronic',))
                    );
                  },
                  title: Text('The Kitchen'),
                  trailing: Icon(
                      Icons.arrow_forward_ios
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                ListTile(
                  onTap: ()=>Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>FinishEvent(category: 'Eletronic',))
                  ),
                  title: Text('IT/Computer'),
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