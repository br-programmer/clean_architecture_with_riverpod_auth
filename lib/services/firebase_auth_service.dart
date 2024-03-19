import 'package:firebase_auth/firebase_auth.dart';

import '../core/either.dart';
import '../failures/failures.dart';

class AuthService {
  AuthService({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  final FirebaseAuth _firebaseAuth;

  Future<AuthFailure?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credentials = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userId = credentials.user?.uid;
      if (userId == null) {
        return UserNotFoundFailure();
      }

      return null;
    } on FirebaseAuthException catch (e) {
      return switch (e.code) {
        'network-request-failed' => NetworkFailure(),
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

  Future<Either<AuthFailure, String>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credentials.user;
      if (user == null) {
        return Left(
          CreateUserFailure(),
        );
      }
      return Right(user.uid);
    } on FirebaseAuthException catch (e) {
      return Left(
        switch (e.code) {
          'network-request-failed' => NetworkFailure(),
          'email-already-in-use' => EmailExistFailure(),
          'invalid-email' => InvalidEmailFailure(),
          'weak-password' => WeakPasswordFailure(),
          _ => UnknownFailure(),
        },
      );
    } catch (_) {
      return Left(
        UnknownFailure(),
      );
    }
  }

  Future<void> logout() => _firebaseAuth.signOut();
}
