import 'package:cloud_firestore/cloud_firestore.dart';

class UserCreate{
  String amount;
  Timestamp createAt;
  String eventId;
  String image;
  String productName;
  String shopEmail;
  String shopId;
  String shopPic;
  String userAmount;
  List variation = [];
  List userVariations =[];

  UserCreate();

  UserCreate.fromMap(Map<String, dynamic> data){
    amount = data['amount'];
    createAt = data['createAt'];
    eventId = data['eventId'];
    image = data['image'];
    productName = data['productName'];
    shopEmail = data['shopEmail'];
    shopId = data['shopId'];
    shopPic = data['shopPic'];
    userAmount = data['userAmount'];
    variation = data['variation'];
    userVariations = data['userVariations'];
  }

  Map<String, dynamic>toMap(){
    return {
      'amount':amount,
      'createAt':createAt,
      'eventId':eventId,
      'image':image,
      'productName':productName,
      'shopEmail':shopEmail,
      'shopId':shopPic,
      'shopPic':shopPic,
      'userAmount':userAmount,
      'variation':variation,
      'userVariations':userVariations
    };
  }
}
