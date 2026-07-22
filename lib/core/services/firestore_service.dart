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

  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getStreamCollection(
      {
        required String collectionName,
        String? orderByField,
        String? whereField,
        dynamic isEqualTo,
        bool descending = false,
      }) {
    Query<Map<String, dynamic>> query = _fireStore.collection(collectionName);
    if (whereField != null && isEqualTo != null) {
      query = query.where(whereField, isEqualTo: isEqualTo);
    }
    if (orderByField != null && orderByField.isNotEmpty) {
      query = query.orderBy(orderByField, descending: descending);
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

  Future<void> updateDocument({
    required String collectionName,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    await _fireStore.collection(collectionName).doc(docId).update(data);
  }

  Future<void> deleteCollectionWithParent({
    required String parentCollection,
    required String patientId,
    required String childCollection,
    required String childWhereField,
  }) async {
    final batch = _fireStore.batch();

    final childSnapShot = await _fireStore.collection(childCollection).where(
        childWhereField, isEqualTo: patientId).get();

    for (var doc in childSnapShot.docs) {
      batch.delete(doc.reference);
    }

    final parentRef = _fireStore.collection(parentCollection).doc(patientId);

    batch.delete(parentRef);

    await batch.commit();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getFutureCollection({required String collectionName , String? whereField , dynamic isEqualTo , String? orderByField })async{
    Query<Map<String, dynamic>> query = _fireStore.collection(collectionName);

    if(whereField != null && isEqualTo != null)
      {
        query =  query.where(whereField, isEqualTo: isEqualTo);
      }
    if(orderByField != null && orderByField.isNotEmpty)
      {
        query =  query.orderBy(orderByField);
      }
    return await query.get();
  }

}
