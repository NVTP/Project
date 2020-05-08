import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreditCard extends StatefulWidget {
  @override
  _CreditCardState createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _cardNumber;
  TextEditingController _cardName;
  TextEditingController _cardExpiration;
  TextEditingController _cardCVV;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cardNumber = TextEditingController();
    _cardName = TextEditingController();
    _cardExpiration = TextEditingController();
    _cardCVV = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Credit Card'),
            floating: true,
            centerTitle: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _cardNumber,
                            keyboardType: TextInputType.number,
                            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                            maxLines: 1,
                            maxLength: 16,
                            decoration: InputDecoration(
                              hintText: 'Card Number',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            validator: (data){
                              if(data.length != 16){
                                return 'Card Number have 16';
                              }else if(data.isEmpty){
                                return 'Plese fills card number';
                              }else{
                                return null;
                              }
                            },
                          ),//CARD NUMBER
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _cardName,
                            keyboardType: TextInputType.text,
                            maxLines: 1,
                            decoration: InputDecoration(
                              hintText: 'Name on Card',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            validator: (data){
                              if(data.isEmpty){
                                return 'Please fills Name';
                              }else{
                                return null;
                              }
                            },
                          ),//NAME CARD
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _cardExpiration,
                            keyboardType: TextInputType.number,
                            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                            maxLines: 1,
                            maxLength: 5,
                            decoration: InputDecoration(
                              hintText: 'Expiration(MM/YY)',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            validator: (data){
                              if(data.isEmpty){
                                return 'Plese fills Expiration';
                              }else{
                                return null;
                              }
                            },
                          ),//EXPIRATION
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _cardCVV,
                            keyboardType: TextInputType.number,
                            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                            maxLines: 1,
                            maxLength: 3,
                            decoration: InputDecoration(
                              hintText: 'CVV',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            validator: (data){
                              if(data.isEmpty){
                                return 'Plese fills CVV';
                              }else{
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          RaisedButton(
                            onPressed: (){
                              if(_formKey.currentState.validate()){

                              }
                            },
                            elevation: 1.1,
                            color: Colors.blueGrey[300],
                            child: Text('Pay Now',style: TextStyle(color: Colors.white),),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}