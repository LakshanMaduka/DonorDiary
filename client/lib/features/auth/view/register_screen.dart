import 'package:donardiary/core/constants/app_colors_const.dart';
import 'package:donardiary/core/reusable_widgets/custom_elevation_button.dart';
import 'package:donardiary/core/reusable_widgets/iconed_textformfeild.dart';
import 'package:donardiary/core/reusable_widgets/loader.dart';
import 'package:donardiary/core/services/cityListService/cityListService.dart';
import 'package:donardiary/core/services/districtListService/district_list_service.dart';
import 'package:donardiary/core/services/imagePickerService/image_picker_service.dart';
import 'package:donardiary/features/auth/model/previous_donation_model.dart';
import 'package:donardiary/features/auth/model/user_model.dart';
import 'package:donardiary/features/auth/view_model/auth_view_model.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';


class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final authViewModel = AuthViewModel();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _placeFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  String _bloodType = "";
  String _district = "";
  String _city = "";
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

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
    _userNameFocusNode.addListener(() {
      setState(() {});
    });

    _phoneNumberFocusNode.addListener(() {
      setState(() {});
    });
    _placeFocusNode.addListener(() {
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

    _passwordController.dispose();
  
    _phoneNumberFocusNode.dispose();
    _phoneNumberController.dispose();
    _dateController.dispose();
    _placeController.dispose();
    _placeFocusNode.dispose();

    super.dispose();
  }

  final List<DropdownMenuEntry> bloodTypes = const [
    DropdownMenuEntry(value: "A+", label: "A+"),
    DropdownMenuEntry(value: "A-", label: "A-"),
    DropdownMenuEntry(value: "B+", label: "B+"),
    DropdownMenuEntry(value: "B-", label: "B-"),
    DropdownMenuEntry(value: "AB+", label: "AB+"),
    DropdownMenuEntry(value: "AB-", label: "AB-"),
    DropdownMenuEntry(value: "O+", label: "O+"),
    DropdownMenuEntry(value: "O-", label: "O-"),
  ];

  late List<DropdownMenuEntry> filterdCityList = [
    const DropdownMenuEntry(value: "", label: "Please select District First"),
  ];

  String? selectedImageUrl;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final isLoading = ref.watch(authViewModelProvider)?.isLoading == true;
    final authViewModel = ref.watch(authViewModelProvider.notifier);
    final districtListProvider =
        ref.watch(districtListNotifierProvider.notifier);
    final cityListProvider = ref.watch(cityListNotifierProvider.notifier);

    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
          data: (data) {
            context.go("/login");
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Register Successful"),
            ));
            setState(() {
              _emailController.clear();
              _passwordController.clear();
              _confirmPasswordController.clear();
              _userNameController.clear();
              _phoneNumberController.clear();
              _dateController.clear();
              _placeController.clear();
              authViewModel.previousDoners.clear();
              _bloodType = "";
            });
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
                            width: 300.w,
                            child: Text(
                              "Register!",
                              style: textTheme.titleLarge,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Center(
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  GestureDetector(
                                      onTap: () {
                                        ref
                                            .read(imagePickerServiceProvider
                                                .notifier)
                                            .pickFromGallery();
                                      },
                                      child: Stack(
                                        children: [
                                          Consumer(builder: (_, ref, __) {
                                            // when loding show a loader

                                            final imageUrl = ref.watch(
                                                imagePickerServiceProvider);
                                            return imageUrl.when(data: (image) {
                                              selectedImageUrl = image;
                                              return CircleAvatar(
                                                radius: 50,
                                                backgroundImage: image != null
                                                    ? NetworkImage(image)
                                                    : _getProfileImage(),
                                              );
                                            }, error: (error, st) {
                                              ScaffoldMessenger.of(context)
                                                ..hideCurrentSnackBar()
                                                ..showSnackBar(SnackBar(
                                                  content:
                                                      Text(error.toString()),
                                                ));
                                              return CircleAvatar(
                                                radius: 50,
                                                backgroundImage:
                                                    _getProfileImage(),
                                              );
                                            }, loading: () {
                                              return const CircleAvatar(
                                                radius: 50,
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            });
                                          }),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: AppColors.appRed,
                                                    width: 2),
                                              ),
                                              child: const Icon(
                                                Icons.camera_alt,
                                                color: AppColors.appRed,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Tap to change profile picture',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          CustomTextFormField(
                            controller: _emailController,
                            prefixIcon: Icon(
                              Icons.email,
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
                            controller: _userNameController,
                            prefixIcon: Icon(
                              Icons.person,
                              size: 25.sp,
                              color: _userNameFocusNode.hasFocus
                                  ? AppColors.appBrown
                                  : AppColors.appAsh,
                            ),
                            hintText: "User Name",
                            focusNode: _userNameFocusNode,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "User name is required";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          // CustomTextFormField(
                          //   controller: _nicController,
                          //   prefixIcon: Icon(
                          //     Icons.perm_identity,
                          //     size: 25.sp,
                          //     color: _nicFocusNode.hasFocus
                          //         ? AppColors.appBrown
                          //         : AppColors.appAsh,
                          //   ),
                          //   hintText: "NIC Number",
                          //   focusNode: _nicFocusNode,
                          //   validator: (value) {
                          //     if (value!.isEmpty) {
                          //       return "NIC is required";
                          //     }
                          //     return null;
                          //   },
                          // ),
                          // SizedBox(
                          //   width: 20.w,
                          // ),
                          DropdownMenu(
                            label: _bloodType.isEmpty
                                ? Text(
                                    "Blood Type",
                                    style: textTheme.bodyLarge!.copyWith(
                                      color: AppColors.appAsh,
                                    ),
                                  )
                                : Text(
                                    _bloodType,
                                    style: textTheme.bodyLarge,
                                  ),
                            inputDecorationTheme: const InputDecorationTheme(
                              filled: true,
                            ),
                            width: double.infinity,
                            hintText: "Blood Type",
                            onSelected: (bloodType) {
                              setState(() {
                                _bloodType = bloodType;
                              });
                            },
                            dropdownMenuEntries: bloodTypes,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: DropdownMenu(
                                  label: _district.isEmpty
                                      ? Text(
                                          "District",
                                          style: textTheme.bodyLarge!.copyWith(
                                            color: AppColors.appAsh,
                                          ),
                                        )
                                      : Text(
                                          _district,
                                          style: textTheme.bodyLarge,
                                        ),
                                  inputDecorationTheme:
                                      const InputDecorationTheme(
                                    filled: true,
                                  ),
                                  width: double.infinity,
                                  hintText: "District",
                                  onSelected: (distict) {
                                    setState(() {
                                      _district = distict!.nameEn;
                                      filterdCityList = cityListProvider
                                          .getCityByDistrictId(distict.id);
                                      _city = "";
                                    });
                                  },
                                  dropdownMenuEntries:
                                      districtListProvider.districtsList,
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Expanded(
                                child: DropdownMenu(
                                  label: _city.isEmpty
                                      ? Text(
                                          "Nearest City",
                                          style: textTheme.bodyLarge!.copyWith(
                                            color: AppColors.appAsh,
                                          ),
                                        )
                                      : Text(
                                          _city,
                                          style: textTheme.bodyLarge,
                                        ),
                                  inputDecorationTheme:
                                      const InputDecorationTheme(
                                    filled: true,
                                  ),
                                  width: double.infinity,
                                  hintText: "Nearest City",
                                  onSelected: (city) {
                                    setState(() {
                                      _city = city!.nameEn;
                                    });
                                  },
                                  dropdownMenuEntries: filterdCityList,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),

                          CustomTextFormField(
                            controller: _phoneNumberController,
                            prefixIcon: Icon(
                              Icons.phone,
                              size: 25.sp,
                              color: _phoneNumberFocusNode.hasFocus
                                  ? AppColors.appBrown
                                  : AppColors.appAsh,
                            ),
                            hintText: "Phone Number",
                            focusNode: _phoneNumberFocusNode,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Phone Number is required";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          // CustomTextFormField(
                          //   controller: _addressController,
                          //   prefixIcon: Icon(
                          //     Icons.location_on,
                          //     size: 25.sp,
                          //     color: _addressFocusNode.hasFocus
                          //         ? AppColors.appBrown
                          //         : AppColors.appAsh,
                          //   ),
                          //   hintText: "Address",
                          //   focusNode: _addressFocusNode,
                          //   validator: (value) {
                          //     if (value!.isEmpty) {
                          //       return "Address is required";
                          //     }
                          //     return null;
                          //   },
                          // ),
                          // SizedBox(
                          //   height: 20.h,
                          // ),
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
                          CustomTextFormField(
                            controller: _confirmPasswordController,
                            focusNode: _confirmPasswordFocusNode,
                            prefixIcon: Icon(
                              Icons.lock,
                              color: _confirmPasswordFocusNode.hasFocus
                                  ? AppColors.appBrown
                                  : AppColors.appAsh,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  authViewModel.toggleConfirmPasswordShow();
                                });
                              },
                              icon: Icon(
                                authViewModel.showConfirmPassword
                                    ? FontAwesomeIcons.eyeSlash
                                    : FontAwesomeIcons.eye,
                                size: 18.sp,
                                color: _confirmPasswordFocusNode.hasFocus
                                    ? AppColors.appBrown
                                    : AppColors.appAsh,
                              ),
                            ),
                            obscureText: authViewModel.showConfirmPassword,
                            hintText: "Confirm Password",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password is required";
                              } else if (value != _passwordController.text) {
                                return "Password does not match";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          const Text("Please add previous donations"),
                          SizedBox(
                            height: 20.h,
                          ),
                          //add a button to add previous donations it should include a date and a location and it should be added to a list

                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  onTap: () {
                                    _showDatePicker();
                                  },
                                  readOnly: true,
                                  controller: _dateController,
                                  hintText: "Date",
                                  prefixIcon: Icon(
                                    Icons.calendar_today_rounded,
                                    size: 25.sp,
                                    color: AppColors.appAsh,
                                  ),
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return "Date is required";
                                  //   }
                                  //   return null;
                                  // },
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Expanded(
                                child: CustomTextFormField(
                                  focusNode: _placeFocusNode,
                                  controller: _placeController,

                                  hintText: "Place",
                                  prefixIcon: Icon(
                                    Icons.place_outlined,
                                    size: 25.sp,
                                    color: _confirmPasswordFocusNode.hasFocus
                                        ? AppColors.appBrown
                                        : AppColors.appAsh,
                                  ),
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return "Date is required";
                                  //   }
                                  //   return null;
                                  // },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          CustomButton(
                            text: "Add",
                            onPressed: () {
                              authViewModel.addPreviousDonations(
                                PreviousDonationModel(
                                  donationDate: _dateController.text,
                                  donationLocation: _placeController.text,
                                ),
                              );
                              _dateController.clear();
                              _placeController.clear();
                              setState(() {});

                              // Add your logic to add previous donation
                            },
                          ),

                          authViewModel.previousDoners.isEmpty
                              ? const SizedBox.shrink()
                              : Container(
                                  height: 100.h,
                                  width: double.infinity,
                                  padding: EdgeInsets.only(top: 10.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: AppColors.appAsh.withOpacity(0.2),
                                  ),
                                  child: ListView.builder(
                                    itemCount:
                                        authViewModel.previousDoners.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(
                                          "${authViewModel.previousDoners[index].donationDate} - ${authViewModel.previousDoners[index].donationLocation}",
                                          style: textTheme.bodyLarge,
                                        ),
                                        trailing: IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () {
                                            authViewModel.previousDoners
                                                .removeAt(index);
                                            setState(() {});
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                          SizedBox(
                            height: 20.h,
                          ),
                          CustomButton(
                              text: "Register",
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ref
                                      .read(authViewModelProvider.notifier)
                                      .signUP(UserModel(
                                        email: _emailController.text,
                                        username: _userNameController.text,
                                        district: _district,
                                        nearestCity: _city,
                                        profileUrl: selectedImageUrl,
                                        booldGroup: _bloodType,
                                        phoneNumber:
                                            _phoneNumberController.text,
                                        password: _passwordController.text,
                                        previousDonations:
                                            authViewModel.previousDoners,
                                      ))
                                      .then((_) {});
                                }
                              }

                              // authViewModel.login(user);

                              ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Center(
                            child: RichText(
                                text: TextSpan(
                                    style: textTheme.titleMedium,
                                    children: <TextSpan>[
                                  const TextSpan(
                                      text: "Already have an account? "),
                                  TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          setState(() {
                                            _passwordController.clear();
                                            _confirmPasswordController.clear();
                                            _emailController.clear();
                                            _userNameController.clear();
                                            _phoneNumberController.clear();
                                            _dateController.clear();
                                            _placeController.clear();
                                            authViewModel.previousDoners
                                                .clear();
                                            context.go("/login");
                                          });
                                        },
                                      text: "Log In",
                                      style: textTheme.bodyLarge!.copyWith(
                                          color: AppColors.appRed,
                                          fontWeight: FontWeight.bold))
                                ])),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
    );
  }

  ImageProvider _getProfileImage() {
    return const AssetImage('assets/medals/pf.png');
  }

  Future<void> _showDatePicker() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null) {
      final formatedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      setState(() {
        _dateController.text = formatedDate;
      });
    }
  }
}
