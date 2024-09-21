// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

import '/core/core.dart';

final class LoginCubit extends BaseCubit<AppState> {
  LoginCubit() : super(const InitialState());

  Future<void> login(String email, String password) async {
    safeEmit(const LoadingState());
    final either =
        await getIt<IAuthService>().loginWithEmailPassword(email, password);
    either.fold(
      (appError) {
        safeEmit(ErrorState(appError));
      },
      (user) {
        if (user != null) {
          final userBox = getIt<IHiveManager>().user;
          userBox.add(
            UserHiveModel(
              uid: user.uid,
              email: user.email,
              displayName: user.displayName,
              photoURL: user.photoURL,
            ),
          );
        }

        safeEmit(const SuccessState());
      },
    );
  }
}
