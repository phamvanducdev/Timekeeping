import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:timekeeping/configs/themes/colors.dart';
import 'package:timekeeping/core/helpers/dialogs.dart';
import 'package:timekeeping/domains/repositories/api_repository.dart';
import 'package:timekeeping/features/auth/login_vm.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginViewModel _viewModel;
  late TextEditingController _inputEmailController;
  late TextEditingController _inputPasswordController;
  late bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _viewModel = LoginViewModel(
      context.read<ApiRepository>(),
    );
    _inputEmailController = TextEditingController();
    _inputPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: KeyboardDismisser(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                        child: Column(
                          children: [
                            const Text(
                              'Welcome to...',
                              style: TextStyle(
                                fontSize: 24,
                                color: AppColors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 24),
                            TextField(
                              controller: _inputEmailController,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 12,
                                ),
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.black.withOpacity(0.5),
                                  fontWeight: FontWeight.w400,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.black.withOpacity(0.5),
                                    width: 0.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.black.withOpacity(1),
                                    width: 1,
                                  ),
                                ),
                              ),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: AppColors.black,
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: _inputPasswordController,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.black.withOpacity(0.5),
                                  fontWeight: FontWeight.w400,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.black.withOpacity(0.5),
                                    width: 0.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.black.withOpacity(1),
                                    width: 1,
                                  ),
                                ),
                                suffixIconConstraints:
                                    const BoxConstraints(minHeight: 24, minWidth: 24),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                  child: Icon(
                                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.visiblePassword,
                              cursorColor: AppColors.black,
                              obscureText: _passwordVisible,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          disabledBackgroundColor: AppColors.black.withOpacity(0.2),
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                            side: const BorderSide(color: AppColors.black),
                          ),
                          textStyle: const TextStyle(color: AppColors.black),
                        ),
                        onPressed: () {
                          _viewModel.onLogin(
                            username: _inputEmailController.text,
                            password: _inputPasswordController.text,
                            onSuccess: () => context.go('/'),
                            onFailed: (String message) {
                              DialogHelper.show(
                                context: context,
                                params: Params(
                                  title: 'Failed to login',
                                  message: message,
                                ),
                              );
                            },
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(color: AppColors.black, fontSize: 14),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        StreamBuilder<bool>(
          stream: _viewModel.streamLoading,
          builder: (context, snapshot) {
            final isLoading = snapshot.data ?? false;
            return isLoading
                ? Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: AppColors.black.withOpacity(0.5),
                    child: const Center(
                      child: CircularProgressIndicator(color: AppColors.white),
                    ),
                  )
                : Container();
          },
        ),
      ],
    );
  }
}
