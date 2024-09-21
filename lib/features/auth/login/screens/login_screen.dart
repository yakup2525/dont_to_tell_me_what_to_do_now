import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/features.dart';

import '/core/core.dart';
import '/widgets/widgets.dart';

final class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  final TextEditingController _emailContoller = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  late LoginCubit _loginCubit;
  @override
  void initState() {
    _loginCubit = BlocProvider.of<LoginCubit>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
              _password(),
              const SizedBox(height: 16.0),
              BlocListener<LoginCubit, AppState>(
                listener: (context, state) {
                  if (state is SuccessState) {
                    NavigationService.instance.navigateTo(AppRoutes.home);
                  }
                },
                child: _loginButton(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _resetPasswordButton(),
                  _registerButton(),
                ],
              )
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

  AppTextFormField _password() {
    return AppTextFormField(
      labelText: 'Password',
      controller: _passwordController,
      obscureText: _obscureText,
      keyboardType: TextInputType.number,
      prefixIcon: const Icon(Icons.lock),
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(8), // Maksimum 8 karakter
        FilteringTextInputFormatter.digitsOnly, // Sadece sayı girişi
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is required';
        } else if (value.length < 8) {
          return 'Şifre 8 karakterden az olamaz';
        }
        return null;
      },
    );
  }

  ElevatedButton _loginButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _loginCubit.login(
              _emailContoller.text.trim(), _passwordController.text.trim());
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

  Widget _registerButton() {
    return TextButton(
        onPressed: () {
          NavigationService.instance.navigateTo(AppRoutes.register);
        },
        child: const Text('Register'));
  }

  Widget _resetPasswordButton() {
    return TextButton(
        onPressed: () {
          NavigationService.instance.navigateTo(AppRoutes.resetPassword);
        },
        child: const Text('ResetPassweord'));
  }
}
