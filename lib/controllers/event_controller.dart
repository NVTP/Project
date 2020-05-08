import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/model/event.dart';
import 'package:finalproject/services/notifier/event_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

getEvent(EventNotifier eventNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance.collection('events')
      .orderBy('createAt', descending: true)
      .getDocuments();

  List<Events> _eventList = [];

  snapshot.documents.forEach((docs){
    Events events = Events.fromMap(docs.data);
    _eventList.add(events);
  });
  eventNotifier.eventList = _eventList;
}

uploadEventsAndImage(Events event, File localFile, Function eventUploaded,{String subID}) async {
  String fileName = basename(localFile.path);
  final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('EventPic/${fileName.toString()}');

  await firebaseStorageRef
      .putFile(localFile)
      .onComplete
      .then((val) {
    //TODO nothing
  }).catchError((e) {
    print('someThing $e');
  });
  String url = await firebaseStorageRef.getDownloadURL();
  var forSub = subID;
  print('image event $url');
  _uploadEvent(event, eventUploaded, imageUrl: url,subID: forSub);
  print('method upload ok');
}

_uploadEvent(Events events, Function eventUploaded,
    {String imageUrl, String subID}) async {
  CollectionReference eventRef = Firestore.instance.collection('events');
  if (imageUrl != null) {
    events.image = imageUrl;
  }
  var start = DateTime.now();
  var end = start.add(Duration(days: 60));
  Timestamp timestamp = Timestamp.fromDate(end);
  events.endAt = timestamp;
  events.createAt = Timestamp.now();
  DocumentReference docRef = await eventRef.add(events.toMap());
  events.eventId = docRef.documentID;
  await docRef.setData(events.toMap(), merge: true);
  DocumentReference ref = Firestore.instance.collection('events').document(events.eventId);
  print(ref.toString());

  FirebaseAuth.instance.currentUser().then((val) {
    Firestore.instance
        .collection('users')
        .document(val.uid)
        .collection('userCreate')
        .document(subID)
        .setData({
      'createAt': Timestamp.now(),
      'image': imageUrl,
      'eventId': docRef.documentID
    }, merge: true);
  }).catchError((e) {
    print('in controller $e');
  });

  FirebaseAuth.instance.currentUser().then((user){
    Firestore.instance.collection('users')
        .document(user.uid)
        .collection('activity')
        .document('create')
        .setData({
      'create' : FieldValue.arrayUnion([ref]),
    },merge: true).catchError((e){
      print('in in $e');
    });
  }).catchError((e){
    print('in create $e');
  });

  eventUploaded(events);
}