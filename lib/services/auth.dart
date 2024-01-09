import 'package:firebase_auth/firebase_auth.dart';

class Auth
{
  final _auth = FirebaseAuth.instance;

  createUser(String email, String password) async
  {
    final authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return authResult;
  }

  LoginUser(String email, String password) async
  {
    final authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return authResult;
  }

  getCurrentUserInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    return user;
  }
}