import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/core/constant/colors_constant.dart';
import 'package:oms_ecommerce/theme/theme_bloc.dart';
import 'package:oms_ecommerce/theme/theme_event.dart';

import '../core/services/routeHelper/route_name.dart';
import '../screen/cart/bloc/cart_bloc.dart';
import '../screen/cart/bloc/cart_state.dart';
import '../screen/login/google_auth_service/auth_service.dart';
import '../screen/profile/block/profile_bloc/profile_bloc.dart';
import '../screen/profile/block/profile_bloc/profile_event.dart';
import '../screen/profile/block/profile_bloc/profile_state.dart';
import '../storage/hive_storage.dart';
import 'loading_overlay.dart';

class DrawerShow extends StatefulWidget {
  const DrawerShow({super.key});

  @override
  State<DrawerShow> createState() => _DrawerShowState();
}

class _DrawerShowState extends State<DrawerShow> {
  @override
  void initState() {
    BlocProvider.of<ProfileBloc>(context).add(ProfileReqEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc,ThemeMode>(builder: (BuildContext context, state) {
      // final bool isDarkMode = state == ThemeMode.dark;
      // final Color backgroundColor = isDarkMode ? Colors.black : Colors.white;
      // final Color textColor = isDarkMode ? Colors.white : Colors.black;
      final bool isDarkMode = state == ThemeMode.dark;
      final Color backgroundColor = HiveStorage.hasPermission("Thememode") ? Colors.black : Colors.white;
      final Color textColor = HiveStorage.hasPermission("Thememode") ? Colors.black : Colors.white;
      return SafeArea(
          child: Container(
            color: backgroundColor,
            width: MediaQuery.of(context).size.width / 1.5,
            // color: onTertiaryContainer,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      titleSection(),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Bootstrap.brightness_high,),
                            SizedBox(width: 20,),
                            Text("Theme Mode",style: GoogleFonts.poppins(
                             //color:  textColor,
                            ),),
                            Spacer(),
                            Switch(
                                value: context.read<ThemeBloc>().state == ThemeMode.dark,
                                onChanged: (value){
                                  context.read<ThemeBloc>().add(ThemeReqEvent(isDark: value));
                                }
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 0,),
                      DrawerIconName(
                        name: "Home",
                        color: textColor,
                        iconName: Bootstrap.house,
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      Divider(),
                      DrawerIconName(
                        name: "Order",
                        color: textColor,
                        iconName: Bootstrap.shop,
                        onTap: () {
                          Navigator.pushNamed(context, orderActivityPage);
                        },
                      ),
                      Divider(),
                      DrawerIconName(
                        name: "Cart",
                        color: textColor,
                        iconName: Bootstrap.cart,
                        onTap: () {
                          Navigator.pushNamed(context, cartPage,
                              arguments: true);
                        },
                      ),
                      Divider(),
                      DrawerIconName(
                        name: "Wishlist",
                        color: textColor,
                        iconName: Bootstrap.heart,
                        onTap: () {
                          Navigator.pushNamed(context, wishListPage,
                              arguments: true);
                        },
                      ),
                      Divider(),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Contact us and help",style: GoogleFonts.poppins(),),
                            DrawerIconName(
                              color: textColor,
                              name: "Contact us",
                              iconName: Bootstrap.file_earmark_text_fill,
                              onTap: () {
                                Navigator.pushNamed(context, contactUsPage);
                              },
                            ),
                            Divider(),
                          ],
                        ),

                      )

                    ],
                  ),
                ),
                //  Spacer(),
                BlocBuilder<ProfileBloc, ProfileState>(builder: (BuildContext context, state) {
                  if(state is ProfileInitialState){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, loginPath);
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 25,
                                width: 25,
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    color: Colors.green

                                ),
                                child: Icon(Bootstrap.box_arrow_right,color: Colors.white,size: 15,),
                              ),
                              SizedBox(width: 5,),
                              Text("Login",style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600
                              ),),
                            ],
                          ),
                        ),
                      ),
                    );
                  }else
                    if(state is ProfileLoadingState){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, loginPath);
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 25,
                                width: 25,
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    color: Colors.green

                                ),
                                child: Icon(Bootstrap.box_arrow_right,color: Colors.white,size: 15,),
                              ),
                              SizedBox(width: 5,),
                              Text("Login",style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600
                              ),),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                    else if(state is ProfileLoadedState){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: InkWell(
                        onTap: (){
                          LoadingOverlay.show(context);
                          AuthService.logout(context);
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 25,
                                width: 25,
                                padding: EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    color: Colors.red

                                ),
                                child: const Icon(Bootstrap.power,color: Colors.white,size: 15,),
                              ),
                              SizedBox(width: 5,),
                              Text("Logout",style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600
                              ),),
                            ],
                          ),
                        ),
                      ),
                    );
                  }else if(state is ProfileErrorState){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, loginPath);
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 25,
                                width: 25,
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    color: Colors.green

                                ),
                                child: Icon(Bootstrap.box_arrow_right,color: Colors.white,size: 15,),
                              ),
                              SizedBox(width: 5,),
                              Text("Login",style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600
                              ),),
                            ],
                          ),
                        ),
                      ),
                    );
                  }else{
                    return Container();
                  }
                },),

              ],
            ),
          )
      );
    },);
  }

  Widget titleSection(){

    return Container(
        padding: EdgeInsets.all(8),
      //color: gPrimaryColor,
      child: BlocBuilder<ProfileBloc, ProfileState>(builder: (BuildContext context, state) {
        if(state is ProfileLoadingState){
          return Column(
            children: [
              const Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("assets/icons/gargimage.png"),
                ),
              ),
              SizedBox(height: 10,),
              Text("User Name",style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Colors.white
              ),),
              SizedBox(height: 10,),

            ],
          );
        }else if(state is ProfileLoadedState){
          return Column(
            children: [
              if(state.userInfoResMode != null)
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 40,
                  foregroundColor: Colors.red,
                  backgroundImage: state.userInfoResMode!.user!.image_full_url!.isNotEmpty
                      ? NetworkImage( state.userInfoResMode!.user!.image_full_url!)
                      : const AssetImage("assets/images/pro1.jpg"),
                ),
              ),
              SizedBox(height: 10,),
              if(state.userInfoResMode != null)
              Text(state.userInfoResMode!.user!.full_name!,),
              SizedBox(height: 10,),

            ],
          );
        }else if(state is ProfileErrorState){
          return Column(
            children: [
              const Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("assets/icons/gargimage.png"),
                ),
              ),
              SizedBox(height: 10,),
              Text("User Name",style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
               //   color: Colors.white
              ),),
              SizedBox(height: 10,),

            ],
          );
        }else{
          return Container();
        }
      },),
    );
  }

  Widget getCartData(){
    return InkWell(
      onTap: (){
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => CartPage(
        //           leading: true,
        //         )));
        Navigator.pushNamed(context, cartPage,
            arguments: true
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            icon: Icon(Bootstrap.cart),
            onPressed: () {
              Navigator.pushNamed(context, cartPage,
                  arguments: true
              );
            },
          ),
          Positioned(
            right: 8,
            top: 8,
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if(state is CartLoadedState){
                  return CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 10,
                    child: Text(
                      '${state.cartLenght.toString()}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  );
                }else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerIconName extends StatelessWidget {
  final String name;
  final IconData iconName;
  final Color color;
  final Function onTap;

  const DrawerIconName({
    super.key,
    required this.iconName,
    required this.name,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(
                iconName,
                size: 25.0,
              //  color: color,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                name,
                style: GoogleFonts.poppins(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
