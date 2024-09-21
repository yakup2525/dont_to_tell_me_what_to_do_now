import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/core/core.dart';

final class RegisterCubit extends BaseCubit<AppState> {
  RegisterCubit() : super(const InitialState());

  Future<void> register(UserRegisterModel userRegisterModel) async {
    safeEmit(const LoadingState());
    final either = await getIt<IAuthService>().registerWithEmailPassword(
        userRegisterModel.email, userRegisterModel.password);
    either.fold(
      (appError) {
        safeEmit(ErrorState(appError));
      },
      (user) {
        if (user != null) {
          saveUserData(user, userRegisterModel);
        }

        // final userBox = getIt<IHiveManager>().user;
        // userBox.add(
        //   UserHiveModel(
        //     uid: user?.uid,
        //     email: user?.email,
        //     displayName: user?.displayName,
        //     photoURL: user?.photoURL,
        //   ),
        // );
        safeEmit(const SuccessState());
        NavigationService.instance.navigateToInitial();
      },
    );
  }

  Future<void> saveUserData(
      User user, UserRegisterModel userRegisterModel) async {
    final usersCollection = FirebaseFirestore.instance.collection('users');
    final userDoc = usersCollection.doc(user.uid);
    // Kullanıcıyı kaydet
    await userDoc.set({
      'uid': user.uid,
      'name': userRegisterModel.name,
      'email': user.email,
      'gsm': userRegisterModel.gsm,
      'createdAt': FieldValue.serverTimestamp(),
    });

    // final todos = [
    //   {
    //     'id': '1',
    //     'title': 'Flutter project',
    //     'description': 'Work on Flutter project',
    //     'isCompleted': false,
    //   },
    //   {
    //     'id': '2',
    //     'title': 'Grocery shopping',
    //     'description': 'Buy groceries for the week',
    //     'isCompleted': false,
    //   }
    // ];

    // final done = [
    //   {
    //     'title': 'Workout',
    //     'description': 'Do a 30-minute workout',
    //     'isCompleted': true,
    //   },
    //   {
    //     'title': 'Read book',
    //     'description': 'Read 50 pages of a book',
    //     'isCompleted': true,
    //   }
    // ];

    // await userDoc.collection('todos').add({
    //   'todos': todos,
    //   'done': done,
    // });
  }
}
