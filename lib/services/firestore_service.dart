import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Parents Collection
  CollectionReference get parents =>
      _firestore.collection('parents');

  // Children Collection
  CollectionReference get children =>
      _firestore.collection('children');

  // Tasks Collection
  CollectionReference get tasks =>
      _firestore.collection('tasks');
}