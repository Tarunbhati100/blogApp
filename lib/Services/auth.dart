import 'package:firebase_auth/firebase_auth.dart';
class AuthServices{
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> get user {
    return _auth.authStateChanges();
    }

  User getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        return user;
      }
    } catch (e) {
      print(e);
    }
  }


  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return result;
    } catch (error) {
      throw error;
    } 
  }

  Future signInWithEmailAndPassword(String email, String password) async{
    try {
      final result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result;
    } catch (error) {
      throw error;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
  
  
}