import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';

import 'dash_board_page/presentation/screen/dash_board_screen.dart';

class GeneralPageWithNavBar extends StatefulWidget {
  const GeneralPageWithNavBar({super.key});

  @override
  State<GeneralPageWithNavBar> createState() => _GeneralPageWithNavBarState();
}

class _GeneralPageWithNavBarState extends State<GeneralPageWithNavBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    DashBoardScreen(),
    DashBoardScreen(),
    DashBoardScreen(),
    DashBoardScreen(),
  ];

  final PageStorageBucket _bucket = PageStorageBucket();

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
        onPressed: () {},
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
