import 'package:firebase_auth/firebase_auth.dart';

import '../failures/failures.dart';

class FirebaseService {
  FirebaseService._();

  static final FirebaseService _instance = FirebaseService._();
  static final FirebaseService instance = _instance;

  final _firebaseAuth = FirebaseAuth.instance;

  Future<AuthFailure?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credentials = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credentials.user == null) {
        return UserNotFoundFailure();
      }
      return null;
    } on FirebaseAuthException catch (e) {
      return switch (e.code) {
        'user-not-found' => UserNotFoundFailure(),
        'invalid-email' => InvalidEmailFailure(),
        'invalid-credential' || 'wrong-password' => InvalidCredentialsFailure(),
        'user-disabled' => UserDisableFailure(),
        _ => UnknownFailure(),
      };
    } catch (_) {
      return UnknownFailure();
    }
  }

  Future<AuthFailure?> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credentials.user == null) {
        return CreateUserFailure();
      }
      return null;
    } on FirebaseAuthException catch (e) {
      return switch (e.code) {
        'email-already-in-use' => EmailExistFailure(),
        'invalid-email' => InvalidEmailFailure(),
        'weak-password' => WeakPasswordFailure(),
        _ => UnknownFailure(),
      };
    } catch (_) {
      return UnknownFailure();
    }
  }

  Future<void> logout() => _firebaseAuth.signOut();
}
