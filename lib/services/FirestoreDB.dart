import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {
  final _firestore = FirebaseFirestore.instance;
  getData(String name) async {
    final Stream<QuerySnapshot> querySnapshot = await _firestore.collection(name).snapshots(includeMetadataChanges: true);
    return querySnapshot;
  }
}