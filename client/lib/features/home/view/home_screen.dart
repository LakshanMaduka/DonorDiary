import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:donardiary/core/constants/app_colors_const.dart';
import 'package:donardiary/features/home/view/blood_bank_page.dart';
import 'package:donardiary/features/home/view/blood_request_page.dart';
import 'package:donardiary/features/home/view/home_page.dart';
import 'package:donardiary/features/home/view/mobile_blood_bank_page.dart';
import 'package:donardiary/features/home/view/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final items = const [
    Icon(
      Icons.home,
      size: 30,
    ),
    Icon(Icons.location_on, size: 30),
    Icon(Icons.airport_shuttle_rounded, size: 30),
    Icon(Icons.notifications, size: 30),
    Icon(Icons.person, size: 30),
  ];

  final screens = [
    const HomePage(),
    const BloodBankPage(),
    MobileBloodBankPage(),
    const BloodRequestPage(),
     ProfilePage(),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: screens[index],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            iconTheme: const IconThemeData(
              color: AppColors.appWhite,
            ),
          ),
          child: CurvedNavigationBar(
              buttonBackgroundColor: AppColors.appRed,
              height: 55.h,
              index: index,
              onTap: (value) => setState(() {
                    index = value;
                  }),
              color: AppColors.appRed,
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: Colors.transparent,
              items: items),
        ),
      ),
    );

    // Scaffold(
    //   body: Center(
    //     child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    //       ElevatedButton(
    //         onPressed: () {
    //           final dio = ref.watch(dioClientProvider);
    //           HomeRepository(dio).testApi();
    //         },
    //         child: const Text("Test API"),
    //       ),
    //       TextButton(
    //         onPressed: () {
    //           ref.watch(authStateProvider.notifier).logout();
    //           context.go("/");
    //         },
    //         child: Text("LogOut"),
    //       ),
    //     ]),
    //   ),
    // );
  }
}
