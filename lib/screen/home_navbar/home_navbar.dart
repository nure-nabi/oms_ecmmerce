
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/screen/cart/cart_screen.dart';
import 'package:oms_ecommerce/screen/main/home_page.dart';
import 'package:oms_ecommerce/screen/web_view/site_web_view.dart';

import '../../core/constant/colors_constant.dart';
import '../../core/constant/textstyle.dart';
import '../../utils/check_network.dart';
import '../../utils/custome_toast.dart';
import '../cart/cart.dart';
import '../category/category_subcategory_list.dart';
import '../main/home.dart';
import '../profile/profile_page.dart';
import '../wish_list/wish_list_page.dart';

class HomeNavbar extends StatefulWidget {
  final int? index;
  const HomeNavbar({super.key,this.index});

  @override
  State<HomeNavbar> createState() => _HomeNavbarState();
}

class _HomeNavbarState extends State<HomeNavbar> {
  int currentIndex = 0;
  int valueMap=0;
  Color color = Colors.green;
  static  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
   // HomePage(),
    CategorySubcategoryList(),
    WishListPage(leading: false,),
    //CartScreen(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    if(widget.index == 3 && valueMap ==0){
      currentIndex =  widget.index!;
     // v = widget.index!;
      Fluttertoast.showToast(msg: valueMap.toString());
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        // return PopSys;
      },
      child: Scaffold(
        //body: currentIndex == 0 ?   const PostScreen() : ProfileScreen(),
        body: Center(
          child: _widgetOptions.elementAt(currentIndex),
        ),
        bottomNavigationBar:  BottomNavigationBar(

            items:   [
              BottomNavigationBarItem(
                  icon: Icon(EvaIcons.home,
                    color: currentIndex == 0 ? gPrimaryColor : Colors.grey,
                  ), label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Bootstrap.grid_3x3_gap_fill,
                    color: currentIndex == 1 ? gPrimaryColor : Colors.grey,
                  ), label: 'Category'
              ),
              BottomNavigationBarItem(
                  icon: Icon(EvaIcons.heart,
                    color: currentIndex == 2 ? gPrimaryColor : Colors.grey,
                  ), label: 'Wishlist'
              ),
              BottomNavigationBarItem(
                  icon: Icon(EvaIcons.people,
                    color: currentIndex == 3 ? gPrimaryColor : Colors.grey,
                  ), label: 'Me'
              )
            ],
            currentIndex: currentIndex,

            onTap: (val) {
              CheckNetwork.check().then((network){
                if(!network){
                  CustomToast.showCustomRoast(context:context, message: "No network found.", icon: Bootstrap.check_circle,iconColor: Colors.red);
                }else{
                  setState(() {
                    valueMap = 2;
                    currentIndex = val;
                  });
                }
              });
            },
            selectedLabelStyle: bottomAppBarTextStyle,
            unselectedLabelStyle: bottomAppBarTextStyle,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: gPrimaryColor,
            unselectedItemColor: Colors.grey,
            iconSize: 20,
            elevation: 0

        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //    Navigator.push(context, MaterialPageRoute(builder: (context)=>SiteWebView()));
        //   },
        //   child: Icon(Bootstrap.webcam),
        // ),
      ),
    );
  }
}
