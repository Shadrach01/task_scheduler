import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:task_scheduler/core/commons/helper/navigator.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';
import 'package:task_scheduler/features/add_project/presentation/screen/add_project_screen.dart';
import 'package:task_scheduler/features/all_tasks/presentation/screen/all_tasks_screen.dart';
import 'package:task_scheduler/features/today_task/presentation/screen/today_task_screen.dart';
import 'package:task_scheduler/features/user_profile_screen/controller/input_user_details_controller.dart';
import 'package:task_scheduler/features/user_profile_screen/presentation/screen/user_details_screen.dart';

import 'dash_board_page/presentation/screen/dash_board_screen.dart';

class GeneralPageWithNavBar extends ConsumerStatefulWidget {
  const GeneralPageWithNavBar({super.key});

  @override
  ConsumerState<GeneralPageWithNavBar> createState() =>
      _GeneralPageWithNavBarState();
}

class _GeneralPageWithNavBarState extends ConsumerState<GeneralPageWithNavBar> {
  final InputUserDetailsController _controller = InputUserDetailsController();
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    DashBoardScreen(),
    TodayTaskScreen(),
    AllTasksScreen(),
    UserProfileScreen(),
  ];

  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  void initState() {
    // Load user data from Hive when the widget is first created
    _controller.loadUserDetailsFromHive(ref);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appHeight = context.appHeight;
    final appWidth = context.appWidth;
    return Scaffold(
      body: PageStorage(
        bucket: _bucket,
        child: _pages[_currentIndex],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade900,
        shape: CircleBorder(),
        onPressed: () => AppNavigator.push(context, AddProjectScreen()),
        child: Icon(
          Icons.add,
          size: appHeight * .044,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(appWidth * .07),
        ),
        child: BottomAppBar(
          height: appHeight * .08,
          padding: EdgeInsets.symmetric(horizontal: appWidth * .09),
          shape: CircularNotchedRectangle(),
          color: Colors.blueGrey.withOpacity(.13),
          notchMargin: 9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => _onItemTapped(0),
                child: Icon(
                  IconlyBold.home,
                  color:
                      _currentIndex == 0 ? Colors.blue.shade900 : Colors.grey,
                ),
              ),
              InkWell(
                onTap: () => _onItemTapped(1),
                child: Icon(
                  IconlyBold.calendar,
                  color:
                      _currentIndex == 1 ? Colors.blue.shade900 : Colors.grey,
                ),
              ),
              SizedBox(width: appWidth * .09),
              InkWell(
                onTap: () => _onItemTapped(2),
                child: Icon(
                  IconlyBold.paper,
                  color:
                      _currentIndex == 2 ? Colors.blue.shade900 : Colors.grey,
                ),
              ),
              InkWell(
                onTap: () => _onItemTapped(3),
                child: Icon(
                  IconlyBold.user_2,
                  color:
                      _currentIndex == 3 ? Colors.blue.shade900 : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to handle icon taps
  void _onItemTapped(int index) {
    setState(() {
      // Update the index to navigate to the respective page
      _currentIndex = index;
    });
  }
}
