import 'package:exercies4/common/components/app_button.dart';
import 'package:exercies4/common/components/app_text_field.dart';
import 'package:exercies4/common/utils/app_colors.dart';
import 'package:exercies4/feature/auth/controller/auth_controller.dart';
import 'package:exercies4/feature/auth/controller/is_login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passController;
  late final TextEditingController _confirmPassController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey();
    _emailController = TextEditingController();
    _passController = TextEditingController();
    _confirmPassController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLogin = ref.watch(isLoginProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isLogin ? 'Đăng Nhập' : 'Đăng Ký',
                style: TextStyle(fontSize: 35.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              AppTextField(
                label: 'email',
                controller: _emailController,
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return 'email không hợp lệ';
                  }
                  return null;
                },
              ),
              SizedBox(height: 25.h),
              AppTextField(
                label: 'Password',
                controller: _passController,
                isPass: true,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Pass cần lớn hơn 5 ký tự';
                  }
                  return null;
                },
              ),
              SizedBox(height: 25.h),
              if (!isLogin)
                AppTextField(
                  label: 'Confirm Password',
                  controller: _confirmPassController,
                  validator: (value) {
                    if (value == null || value != _passController.text) {
                      return 'Không trùng khớp';
                    }
                    return null;
                  },
                ),
              SizedBox(height: 35.h),
              AppButton(
                name: isLogin ? 'Đăng Nhập' : 'Đăng ký',
                ontap: () {
                  if(!(_formKey.currentState?.validate() ?? false)) return;
                  String email = _emailController.text;
                  String pass = _passController.text;
                  isLogin 
                    ? AuthController.signIn(email: email, password: pass, ref: ref)
                    : AuthController.signUp(ref: ref, email: email, pass: pass);
                },
              ),
              SizedBox(
                height: 12.h,
              ),
              GestureDetector(
                onTap: () {
                  ref.read(isLoginProvider.notifier).state = !isLogin;
                },
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyLarge,
                    text: isLogin
                        ? 'Bạn chưa có tài khoản? '
                        : 'Bạn đã có tài khoản? ',
                    children: <TextSpan>[
                      TextSpan(
                        text: isLogin ? 'SignUp' : 'SignIn',
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryElement),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
