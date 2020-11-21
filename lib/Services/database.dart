import 'package:blog_app/Services/auth.dart';
import 'package:blog_app/content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final _auth = AuthServices();
  final CollectionReference blogsCollection =
      FirebaseFirestore.instance.collection('blogs');

  Future<void> updateUserData(String id, String title, String data) async {
    return await blogsCollection.doc(id).set(
        {'title': title, 'data': data, 'sender': _auth.getCurrentUser().email});
  }

  Future<void> addData(String title, String content, String sender) async {
    return await blogsCollection.add({
      'title': title,
      'data': content,
      'sender': sender,
    });
  }

  List<Blog> _blogListFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs.where((doc) {
      return doc.data()['sender'] == _auth.getCurrentUser().email;
    }).map((doc) {
      return Blog(
          id: doc.id,
          title: doc.data()['title'] ?? "",
          data: doc.data()['data'] ?? "");
    }).toList();
  }

  Stream<List<Blog>> get blogs {
    return blogsCollection.snapshots().map(_blogListFromSnapshots);
  }

  Future<void> deleteData(String id) async {
    return await blogsCollection.doc(id).delete();
  }
}
