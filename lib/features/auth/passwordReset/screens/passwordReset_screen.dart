import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/features.dart';
import '/core/core.dart';

import '/widgets/widgets.dart';

final class PasswordresetScreen extends StatefulWidget {
  const PasswordresetScreen({super.key});

  @override
  State<PasswordresetScreen> createState() => _PasswordresetScreenState();
}

final class _PasswordresetScreenState extends State<PasswordresetScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailContoller = TextEditingController();

  late PasswordResetCubit _passwordResetCubit;
  @override
  void initState() {
    _passwordResetCubit = BlocProvider.of<PasswordResetCubit>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              const SizedBox(height: 16.0),
              const SizedBox(height: 16.0),
              _email(),
              const SizedBox(height: 16.0),
              const SizedBox(height: 16.0),
              BlocListener<PasswordResetCubit, AppState>(
                listener: (context, state) {
                  if (state is SuccessState) {
                    NavigationService.instance.pop();
                    FlushbarManager.showSuccess('Check your mail');
                  }
                },
                child: _loginButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppTextFormField _email() {
    return AppTextFormField(
      labelText: 'Email',
      controller: _emailContoller,
      keyboardType: TextInputType.emailAddress,
    );
  }

  ElevatedButton _loginButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _passwordResetCubit.resetPassword(_emailContoller.text.trim());
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent, // Arka plan rengi
        minimumSize: const Size(double.infinity,
            60), // Ekranın tüm genişliğini kaplasın ve height 60 olsun
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Border radius 10
        ),
      ),
      child: const Text(
        'Login',
        style: TextStyle(fontSize: 18), // Buton metni için yazı tipi boyutu
      ),
    );
  }
}
