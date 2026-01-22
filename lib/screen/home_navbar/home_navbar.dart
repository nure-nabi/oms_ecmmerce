import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../core/constant/colors_constant.dart';
import '../../core/constant/textstyle.dart';
import '../category/category_subcategory_list.dart';
import '../main/home.dart';
import '../profile/profile_page.dart';
import '../wish_list/wish_list_page.dart';

class HomeNavbar extends StatefulWidget {
  final int? index;
  const HomeNavbar({super.key, this.index});

  @override
  State<HomeNavbar> createState() => _HomeNavbarState();
}

class _HomeNavbarState extends State<HomeNavbar> {
  int currentIndex = 0;

  // Keep screens alive (NO REBUILD)
  static final List<Widget> _screens = <Widget>[
    HomeScreen(),
    CategorySubcategoryList(),
    WishListPage(leading: false),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      currentIndex = widget.index!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Future.value(false),
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: _screens,
        ),
      
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: gPrimaryColor,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: bottomAppBarTextStyle,
          unselectedLabelStyle: bottomAppBarTextStyle,
          iconSize: 20,
          elevation: 0,
      
          onTap: (index) {
            if (index == currentIndex) return;
            setState(() {
              currentIndex = index;
            });
          },
      
          items: const [
            BottomNavigationBarItem(
              icon: Icon(EvaIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Bootstrap.grid_3x3_gap_fill),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(EvaIcons.heart),
              label: 'Wishlist',
            ),
            BottomNavigationBarItem(
              icon: Icon(EvaIcons.people),
              label: 'Me',
            ),
          ],
        ),
      ),
    );
  }
}
