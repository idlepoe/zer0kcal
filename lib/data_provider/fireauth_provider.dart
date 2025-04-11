import 'package:firebase_auth/firebase_auth.dart';

class FireAuthProvider {
  final FirebaseAuth _db = FirebaseAuth.instance;

  Future<User?> loginAnon() async {
    return _db.currentUser ?? (await _db.signInAnonymously()).user;
  }
}
