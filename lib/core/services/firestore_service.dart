import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<String> addData({
    required String collectionName,
    required Map<String, dynamic> data,
    String? uid,
  }) async {
    if (uid != null && uid.isNotEmpty) {
      await _fireStore.collection(collectionName).doc(uid).set(data);
      return uid;
    } else {
      DocumentReference documentReference = await _fireStore
          .collection(collectionName)
          .add(data);
      return documentReference.id;
    }
  }

  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getCollection({
    required String collectionName,
    String? orderByField,
  }) {
    Query<Map<String, dynamic>> query = _fireStore.collection(collectionName);

    if (orderByField != null && orderByField.isNotEmpty) {
      query = query.orderBy(orderByField, descending: false);
    }

    return query.snapshots().map((querySnapshot) => querySnapshot.docs);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocument({
    required String collectionName,
    required String docId,
  }) async {
    return await _fireStore.collection(collectionName).doc(docId).get();
  }

  Future<void> deleteDocument({
    required String collectionName,
    required String docId,
  }) async {
    await _fireStore.collection(collectionName).doc(docId).delete();
  }
}
