import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/core/core.dart';

abstract class IAuthService {
  Future<Either<AppError, User?>> registerWithEmailPassword(
      String email, String password);
  Future<Either<AppError, User?>> loginWithEmailPassword(
      String email, String password);
  Future<Either<AppError, bool>> signOut();
  Future<Either<AppError, bool>> resetPassword(String email);
  Future<Either<AppError, bool>> changePassword(String newPassword);
  Stream<User?> get user;
}

class AuthService implements IAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register Function
  @override
  Future<Either<AppError, User?>> registerWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return Right(user);
    } on AppError catch (error) {
      LogManager.error(error.message ?? '');
      return Left(error);
    } catch (e) {
      LogManager.error(e.toString());

      return Left(AppError(message: 'Bilinmeyen bir hata oluştu.'));
    }
  }

  // Login Function
  @override
  Future<Either<AppError, User?>> loginWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return Right(user);
    } on AppError catch (error) {
      LogManager.error(error.message ?? '');
      return Left(error);
    } catch (e) {
      LogManager.error(e.toString());

      return Left(AppError(message: 'Bilinmeyen bir hata oluştu.'));
    }
  }

  //LogOut func
  @override
  Future<Either<AppError, bool>> signOut() async {
    try {
      await _auth.signOut();
      NavigationService.instance.navigateToInitial();
      return const Right(true);
    } on AppError catch (error) {
      LogManager.error(error.message ?? '');
      return Left(error);
    } catch (e) {
      LogManager.error(e.toString());

      return Left(AppError(message: 'Bilinmeyen bir hata oluştu.'));
    }
  }

  // Reset password func
  @override
  Future<Either<AppError, bool>> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return const Right(true);
    } on AppError catch (error) {
      LogManager.error(error.message ?? '');
      return Left(error);
    } catch (e) {
      LogManager.error(e.toString());

      return Left(AppError(message: 'Bilinmeyen bir hata oluştu.'));
    }
  }

  // Change password func
  @override
  Future<Either<AppError, bool>> changePassword(String newPassword) async {
    User? user = _auth.currentUser;
    try {
      await user?.updatePassword(newPassword);
      return const Right(true);
    } on AppError catch (error) {
      LogManager.error(error.message ?? '');
      return Left(error);
    } catch (e) {
      LogManager.error(e.toString());

      return Left(AppError(message: 'Bilinmeyen bir hata oluştu.'));
    }
  }

  // get auth stat
  @override
  Stream<User?> get user {
    return _auth.authStateChanges();
  }
}
