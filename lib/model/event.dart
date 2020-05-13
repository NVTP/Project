import 'package:cloud_firestore/cloud_firestore.dart';

class Events{
  String eventId;
  String eventName;
  String eventDetail;
  String category;
  String productName;
  String mediumPrice;
  List variations = [];
  String image;
  String currentAmount;
  Timestamp createAt;
  Timestamp updateAt;
  Timestamp endAt;
  String userCreateId;
  String userPic;
  String userEmail;
  String userAmount;
  List userVariations = [];
  String shopOwnId;
  String shopPic;
  String shopEmail;
  String shopPrice;
  String shopAmount;
  String status;

  Events();

  Events.fromMap(Map<String, dynamic> data){
    eventId = data['eventId'];
    eventName = data['eventName'];
    eventDetail = data['eventDetail'];
    category = data['category'];
    productName = data['productName'];
    mediumPrice = data['mediumPrice'];
    variations = data['variations'];
    image = data['image'];
    currentAmount = data['currentAmount'];
    createAt = data['createAt'];
    updateAt = data['updateAt'];
    endAt = data['endAt'];
    userCreateId = data['userCreateId'];
    userPic = data['userPic'];
    userEmail = data['userEmail'];
    userAmount = data['userAmount'];
    userVariations = data['userVariations'];
    shopOwnId = data['shopOwnId'];
    shopPic = data['shopPic'];
    shopEmail = data['shopEmail'];
    shopPrice = data['shopPrice'];
    shopAmount = data['shopAmount'];
    status = data['atatus'];
  }

  Map<String, dynamic>toMap(){
    return{
      'eventId':eventId,
      'eventName':eventName,
      'eventDetail':eventDetail,
      'category':category,
      'productName':productName,
      'mediumPrice':mediumPrice,
      'variations':variations,
      'image':image,
      'currentAmount':currentAmount,
      'createAt':createAt,
      'updateAt':updateAt,
      'endAt':endAt,
      'userCreateId':userCreateId,
      'userPic':userPic,
      'userEmail':userEmail,
      'userAmount':userAmount,
      'userVariations':userVariations,
      'shopOwnId':shopOwnId,
      'shopPic':shopPic,
      'shopEmail':shopEmail,
      'shopPrice':shopPrice,
      'shopAmount':shopAmount,
      'status':status,
    };
  }
}