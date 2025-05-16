import 'package:donardiary/core/constants/app_colors_const.dart';
import 'package:donardiary/core/reusable_widgets/custom_elevation_button.dart';
import 'package:donardiary/core/reusable_widgets/iconed_textformfeild.dart';
import 'package:donardiary/core/services/cityListService/cityListService.dart';
import 'package:donardiary/core/services/districtListService/district_list_service.dart';
import 'package:donardiary/core/services/imagePickerService/image_picker_service.dart';
import 'package:donardiary/features/auth/view_model/auth_view_model.dart';
import 'package:donardiary/features/home/view_model/home_view_model.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends ConsumerStatefulWidget {
  ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
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
  String? selectedImageUrl;
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
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final user = ref.watch(homeViewModelProvider).value;
    final districtListProvider =
        ref.watch(districtListNotifierProvider.notifier);
    final cityListProvider = ref.watch(cityListNotifierProvider.notifier);
    _emailController.text = user!.email ?? "";
    _userNameController.text = user.username ?? "";
    _phoneNumberController.text = user.phoneNumber ?? "";
    _bloodType = user.booldGroup ?? "";
    _district = user.district ?? "";
    _city = user.nearestCity ?? "";
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: Center(
                  child: Column(
                    children: [
                      const Text(
                        'Profile Details',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                          onTap: () {
                            // ref
                            //     .read(imagePickerServiceProvider.notifier)
                            //     .pickFromGallery();
                          },
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 70,
                                backgroundImage: user!.profileUrl != null
                                    ? NetworkImage(user.profileUrl!)
                                    : _getProfileImage(),
                              ),
                              // Positioned(
                              //   bottom: 0,
                              //   right: 0,
                              //   child: Container(
                              //     height: 40,
                              //     width: 40,
                              //     decoration: BoxDecoration(
                              //       color: Colors.white,
                              //       shape: BoxShape.circle,
                              //       border: Border.all(
                              //           color: AppColors.appRed, width: 2),
                              //     ),
                              //     child: const Icon(
                              //       Icons.camera_alt,
                              //       color: AppColors.appRed,
                              //     ),
                              //   ),
                              // ),
                            ],
                          )),
                      const SizedBox(height: 10),
                      // const Text(
                      //   'Tap to change profile picture',
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomTextFormField(
                readOnly: true,
                controller: _emailController,
                prefixIcon: Icon(
                  Icons.email,
                  size: 25.sp,
                ),
                hintText: "Email Address",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email is required";
                  } else if (EmailValidator.validate(value) == false) {
                    return "Invalid Email";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomTextFormField(
                readOnly: true,
                controller: _userNameController,
                prefixIcon: Icon(
                  Icons.person,
                  size: 25.sp,
                ),
                hintText: "User Name",
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
              DropdownMenu(
                enabled: false,
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
                      enabled: false,
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
                      inputDecorationTheme: const InputDecorationTheme(
                        filled: true,
                      ),
                      width: double.infinity,
                      hintText: "District",
                      onSelected: (distict) {
                        setState(() {
                          // _district = distict!.nameEn;
                          // filterdCityList =
                          //     cityListProvider.getCityByDistrictId(distict.id);
                          // _city = "";
                        });
                      },
                      dropdownMenuEntries: districtListProvider.districtsList,
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    child: DropdownMenu(
                      enabled: false,
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
                      inputDecorationTheme: const InputDecorationTheme(
                        filled: true,
                      ),
                      width: double.infinity,
                      hintText: "Nearest City",
                      onSelected: (city) {
                        setState(() {
                          // _city = city!.nameEn;
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
                readOnly: true,
                controller: _phoneNumberController,
                prefixIcon: Icon(
                  Icons.phone,
                  size: 25.sp,
                ),
                hintText: "Phone Number",
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
              CustomButton(
                  text: "LogOut",
                  onPressed: () {
                    ref.watch(authViewModelProvider.notifier).logout();
                    context.go("/");

                    // Navigator.pushNamedAndRemoveUntil(
                    //     context, "/", (route) => false);
                  })
            ],
          ),
        ),
      ),
    );
  }

  ImageProvider _getProfileImage() {
    return const AssetImage('assets/medals/pf.png');
  }
}
