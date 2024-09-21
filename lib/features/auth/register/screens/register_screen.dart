import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/features.dart';
import '/widgets/widgets.dart';
import '/core/core.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailContoller = TextEditingController();
  final TextEditingController _gsmContoller = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  late RegisterCubit _registerCubit;

  @override
  void initState() {
    _registerCubit = BlocProvider.of<RegisterCubit>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: _buildBody(),
    );
  }

  Padding _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            const SizedBox(height: 16.0),
            const SizedBox(height: 16.0),
            _buildName(),
            const SizedBox(height: 16.0),
            _buildEMail(),
            const SizedBox(height: 16.0),
            _buildGsm(),
            const SizedBox(height: 16.0),
            _buildPassword(),
            const SizedBox(height: 16.0),
            BlocListener<RegisterCubit, AppState>(
              listener: (context, state) {
                if (state is SuccessState) {
                  NavigationService.instance.navigateTo(AppRoutes.home);
                }
              },
              child: _buildRegisterButton(),
            )
          ],
        ),
      ),
    );
  }

  AppTextFormField _buildName() {
    return AppTextFormField(
      labelText: 'Name',
      controller: _nameController,
      keyboardType: TextInputType.name,
    );
  }

  AppTextFormField _buildEMail() {
    return AppTextFormField(
      labelText: 'Email',
      controller: _emailContoller,
      keyboardType: TextInputType.emailAddress,
    );
  }

  AppTextFormField _buildGsm() {
    return AppTextFormField(
      labelText: 'Gsm',
      controller: _gsmContoller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(10), // Maksimum 8 karakter
        FilteringTextInputFormatter.digitsOnly, // Sadece sayı girişi
      ],
    );
  }

  AppTextFormField _buildPassword() {
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

  ElevatedButton _buildRegisterButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _registerCubit.register(UserRegisterModel(
            name: _nameController.text.trim(),
            email: _emailContoller.text.trim(),
            gsm: _gsmContoller.text.trim(),
            password: _passwordController.text.trim(),
          ));
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
        'Register',
        style: TextStyle(fontSize: 18), // Buton metni için yazı tipi boyutu
      ),
    );
  }
}
