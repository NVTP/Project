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
            decoration: InputDecoration(
              hintText: 'Search ',
              hintStyle: TextStyle(color: Colors.grey[200]),
              suffixIcon: IconButton(
                onPressed: (){
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
    );
  }
}
