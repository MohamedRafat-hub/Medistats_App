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
      DocumentReference documentReference = await _fireStore.collection(collectionName).add(data);
      return documentReference.id;
    }
  }


  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getCollection({
    required String collectionName,
  }) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await _fireStore.collection(collectionName).get();
    return querySnapshot.docs;
  }


  Future<DocumentSnapshot<Map<String, dynamic>>> getDocument({
    required String collectionName,
    required String docId,
  }) async {
    return await _fireStore.collection(collectionName).doc(docId).get();
  }
}
