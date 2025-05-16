import 'package:donardiary/core/common_providers/auth_state_provider.dart';
import 'package:donardiary/core/reusable_widgets/loader.dart';
import 'package:donardiary/features/home/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors_const.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final vm = ref.watch(homeViewModelProvider);
    final homeVm = ref.read(homeViewModelProvider.notifier);
    return vm.when(
      loading: () => const Center(child: CustomLoadingIndicator()),
      error: (error, stack) => ScaffoldMessenger(child: Text(error.toString())),
      data: (user) {
        return Scaffold(
          body: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),

              SizedBox(
                height: 100.h,
                width: double.infinity,
                child: Image.asset("assets/logo/logo2.png"),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome \n${user?.username}",
                          style: textTheme.titleLarge!.copyWith(
                            fontSize: 35.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 70.h,
                              padding: EdgeInsets.all(10.r),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: AppColors.appRed,
                              ),
                              child: Center(
                                child: Text(
                                  "Total \nDonations",
                                  style: textTheme.bodyLarge!.copyWith(
                                    color: AppColors.appWhite,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Container(
                              height: 70.h,
                              width: 70.h,
                              padding: EdgeInsets.all(10.r),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: AppColors.appWhite,
                                border: Border.all(
                                  color: AppColors.appRed,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "${user?.previousDonations?.length}",
                                  style: textTheme.bodyLarge!.copyWith(
                                    color: AppColors.appRed,
                                    fontSize: 20.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 155.h,
                    width: 155.h,
                    child: Stack(children: [
                      Center(
                        child: Image.asset(
                          user!.previousDonations!.length > 20
                              ? "assets/medals/gold.png"
                              : user.previousDonations!.length > 10
                                  ? "assets/medals/silver.png"
                                  : "assets/medals/bronze.png",
                          height: 155.h,
                          width: 155.h,
                        ),
                      ),
                      Positioned(
                        top: 52.h,
                        left: 33.h,
                        child: user.profileUrl != null
                            ? CircleAvatar(
                                radius: 45.r,
                                backgroundColor: AppColors.appRed,
                                backgroundImage: NetworkImage(user.profileUrl!),
                              )
                            : CircleAvatar(
                                radius: 45.r,
                                backgroundColor: AppColors.appWhite,
                                child: Icon(
                                  Icons.person,
                                  color: AppColors.appRed,
                                  size: 50.sp,
                                ),
                              ),
                      ),
                    ]),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                height: 70.h,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.appWhite,
                  border: Border.all(
                    color: AppColors.appRed,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Days Since \nLast Donation",
                          style: textTheme.bodyLarge!.copyWith(
                            color: AppColors.appRed,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9.r),
                          color: AppColors.appRed,
                        ),
                        child: Center(
                          child: Text(
                            "${homeVm.daysSinceLastDonation} Days",
                            style: textTheme.bodyLarge!.copyWith(
                              color: AppColors.appWhite,
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Previous Donations",
                    style: textTheme.bodyLarge!.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: user.previousDonations?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          side: const BorderSide(
                            color: AppColors.appRed,
                            width: 2,
                          ),
                        ),
                        leading: CircleAvatar(
                          radius: 30.r,
                          backgroundColor: AppColors.appRed,
                          child: Icon(Icons.water_drop_outlined,
                              color: AppColors.appWhite, size: 30.sp),
                        ),
                        title: Text(
                          "${user.previousDonations?[index].donationLocation}",
                          style: textTheme.bodyLarge!.copyWith(
                              color: AppColors.appBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          "${user.previousDonations?[index].donationDate}",
                          style: textTheme.bodyLarge!.copyWith(
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Text('Total Donations: ${homeVm.totalDonationsCount}'),
              // Text('Last Donation: ${homeVm.lastDonationFormatted}'),
              // // Or if you need daysSinceLastDonation directly:

              // ElevatedButton(
              //   onPressed: () {
              //     final dio = ref.watch(dioClientProvider);
              //     HomeRepository(dio).testApi();
              //   },
              //   child: const Text("Test API"),
              // ),
              // TextButton(
              //   onPressed: () {
              //     ref.watch(authStateProvider.notifier).logout();
              //     context.go("/");
              //   },
              //   child: Text("LogOut"),
              // ),
            ],
          ),
        );
      },
    );
  }
}
