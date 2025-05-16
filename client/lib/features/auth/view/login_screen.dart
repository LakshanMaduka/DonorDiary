import 'package:donardiary/core/constants/app_colors_const.dart';
import 'package:donardiary/core/constants/route_names.dart';
import 'package:donardiary/core/reusable_widgets/custom_elevation_button.dart';
import 'package:donardiary/core/reusable_widgets/iconed_textformfeild.dart';
import 'package:donardiary/core/reusable_widgets/loader.dart';
import 'package:donardiary/features/auth/view_model/auth_view_model.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../home/view/home_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<LoginScreen> {
  final authViewModel = AuthViewModel();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      setState(() {}); // Rebuild on focus change
    });

    _passwordFocusNode.addListener(() {
      setState(() {});
    });
    _confirmPasswordFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _userNameFocusNode.dispose();
    _emailController.dispose();
    _confirmPasswordController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final isLoading = ref.watch(authViewModelProvider)?.isLoading == true;

    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
          data: (data) {
            //if (authViewModel.isRegister != true) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Login Successful"),
            ));
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>  HomeScreen()));
            // } else {
            //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            //     content: Text("Register Successful"),
            //   ));
            //   setState(() {
            //     _emailController.clear();
            //     _passwordController.clear();
            //     authViewModel.toggleRegistration();
            //   });
            // }
          },
          error: (error, st) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(error.toString()),
              ));
          },
          loading: () {});
    });

    return SafeArea(
      child: Scaffold(
          body: isLoading
              ? const CustomLoadingIndicator()
              : Padding(
                  padding: EdgeInsets.only(top: 30.h, left: 20.w, right: 20.w),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 100.h,
                            width: double.infinity,
                            child: Image.asset("assets/logo/logo2.png"),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          SizedBox(
                            width: 300.w,
                            child: Text(
                              "Welcome Back!",
                              style: textTheme.titleLarge,
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          CustomTextFormField(
                            controller: _emailController,
                            prefixIcon: Icon(
                              Icons.person,
                              size: 25.sp,
                              color: _emailFocusNode.hasFocus
                                  ? AppColors.appBrown
                                  : AppColors.appAsh,
                            ),
                            hintText: "Email Address",
                            focusNode: _emailFocusNode,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email is required";
                              } else if (EmailValidator.validate(value) ==
                                  false) {
                                return "Invalid Email";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          CustomTextFormField(
                            controller: _passwordController,
                            prefixIcon: Icon(
                              Icons.lock,
                              color: _passwordFocusNode.hasFocus
                                  ? AppColors.appBrown
                                  : AppColors.appAsh,
                            ),
                            obscureText: authViewModel.showPassword,
                            focusNode: _passwordFocusNode,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  authViewModel.togglePasswordShow();
                                });
                              },
                              icon: Icon(
                                authViewModel.showPassword
                                    ? FontAwesomeIcons.eyeSlash
                                    : FontAwesomeIcons.eye,
                                size: 18.sp,
                                color: _passwordFocusNode.hasFocus
                                    ? AppColors.appBrown
                                    : AppColors.appAsh,
                              ),
                            ),
                            hintText: "Password",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password is required";
                              } else if (value.length < 6) {
                                return "Password must be at least 6 characters";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          CustomButton(
                              text: "Login",
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await ref
                                      .read(authViewModelProvider.notifier)
                                      .login(
                                          email: _emailController.text,
                                          password: _passwordController.text);
                                }

                                // final res = await ref.read(authViewModelProvider.notifier).login(email: _emailController.text, password: _passwordController.text);
                                // final val = switch(res){
                                //                       Left(value:final value) => value,
                                //                       Right(value:final value) => value.toString(),
                                // };
                                // if(val == "success"){
                                //   Navigator.pushNamed(context, "/home");
                                //
                              }

                              // authViewModel.login(user);

                              ),
                          Align(
                            alignment: Alignment
                                .centerRight, // Aligns the TextButton to the right
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forget Password?",
                                style: textTheme.bodyLarge!.copyWith(
                                  color: AppColors.appBrown,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          Center(
                            child: RichText(
                                text: TextSpan(
                                    style: textTheme.titleMedium,
                                    children: <TextSpan>[
                                  const TextSpan(
                                      text:  "Don't have an account? "),
                                  TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          setState(() {
                                            _passwordController.clear();
                                            _confirmPasswordController.clear();
                                            _emailController.clear();

                                            context.goNamed(RouteNames.register);
                                          });
                                        },
                                      text:  "Sign Up",
                                      style: textTheme.bodyLarge!.copyWith(
                                          color: AppColors.appRed,
                                          fontWeight: FontWeight.bold))
                                ])),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
    );
  }
}
