import 'package:firebase_auth/firebase_auth.dart';

import '../data_provider/fireauth_provider.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FireAuthProvider provider;

  AuthRepositoryImpl(this.provider);

  @override
  Future<bool> signAnon() async {
    return provider.loginAnon() != null;
  }
}
