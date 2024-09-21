import '/core/core.dart';

final class PasswordResetCubit extends BaseCubit<AppState> {
  PasswordResetCubit() : super(const InitialState());

  Future<void> resetPassword(String email) async {
    safeEmit(const LoadingState());
    final either = await getIt<IAuthService>().resetPassword(email);
    either.fold(
      (appError) {
        safeEmit(ErrorState(appError));
      },
      (user) {
        safeEmit(const SuccessState());
      },
    );
  }
}
