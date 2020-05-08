import 'package:cloud_firestore/cloud_firestore.dart';

class UserJoin{
  String eventId;
  String eventName;
  String productName;
  String currentAmount;
  String category;
  String image;
  String userId;
  String userName;
  String userProvince;
  String userPhone;
  String userAddress;
  String userEmail;
  String userPic;
  String userAmount;
  List userVariations = [];
  Timestamp joinAt;
  Timestamp updateJoinAt;

  UserJoin();

  UserJoin.fromMap(Map<String,dynamic>data){
    eventId = data['eventId'];
    eventName = data['eventName'];
    productName = data['productName'];
    currentAmount = data['currentAmount'];
    category = data['category'];
    image = data['image'];
    userId = data['userId'];
    userName = data['userName'];
    userProvince = data['userProvince'];
    userPhone = data['userPhone'];
    userAddress = data['userAddress'];
    userEmail = data['userEmail'];
    userPic = data['userPic'];
    userAmount = data['userAmount'];
    userVariations = data['userVariations'];
    joinAt = data['joinAt'];
    updateJoinAt = data['updateJoinAt'];

    Map<String, dynamic>toMap(){
      return{
        'eventId':eventId,
        'eventName':eventName,
        'productName':productName,
        'currentAmount':currentAmount,
        'category':category,
        'image':image,
        'userId':userId,
        'userName':userName,
        'userProvince':userProvince,
        'userPhone':userPhone,
        'userAddress':userAddress,
        'userEmail':userEmail,
        'userPic':userPic,
        'userAmount':userAmount,
        'userVariations':userVariations,
        'joinAt':joinAt,
        'updateJoinAt':updateJoinAt,
      };
    }
  }
}