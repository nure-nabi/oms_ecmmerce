import 'dart:ffi';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/component/loading_overlay.dart';

import 'package:oms_ecommerce/screen/profile/block/image_picker_block/image_picker_block.dart';
import 'package:oms_ecommerce/screen/profile/block/image_picker_block/image_picker_event.dart';
import 'package:oms_ecommerce/screen/profile/block/image_picker_block/image_picker_state.dart';
import 'package:oms_ecommerce/screen/profile/block/profile_bloc/profile_event.dart';
import 'package:oms_ecommerce/theme/theme_bloc.dart';

import '../../core/constant/colors_constant.dart';
import '../../core/constant/textstyle.dart';
import '../../core/services/routeHelper/route_name.dart';
import '../../theme/theme_data.dart';
import '../../utils/custome_toast.dart';
import '../address/address_page.dart';
import '../login/google_auth_service/auth_service.dart';
import '../widget/gredient_container.dart';
import '../widget/text_field_decoration.dart';
import '../wish_list/wish_list_page.dart';
import 'block/profile_bloc/profile_bloc.dart';
import 'block/profile_bloc/profile_state.dart';

class ProfilePage extends StatefulWidget {
  final bool? leading;

  const ProfilePage({super.key, this.leading = false});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    //context.read<ClassBloc>().add(ClassReqClearEvent());
    context.read<ProfileBloc>().add(ProfileReqEvent());
    });
  }

  @override
  Widget build(BuildContext context) {

  return   BlocBuilder<ThemeBloc,ThemeMode>(builder: (BuildContext context, state) {
    final bool isDarkMode = state == ThemeMode.dark;

    // Use isDarkMode to choose colors
    final Color backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    return Scaffold(
      // backgroundColor: Color(0xfff5fdff),
      // backgroundColor: gPrimaryColor.withOpacity(0.1),
        appBar: AppBar(
          automaticallyImplyLeading: false,

          title: Row(
            children: [
              Text('My Profile',style: GoogleFonts.poppins(
                  letterSpacing: 1
              )),

            ],
          ),
          centerTitle: true,
          elevation: 0,
          //   backgroundColor: Color(0xff003466),
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (BuildContext context, state) {
            if (state is ProfileLoadingState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: backgroundColor,
                      child: Card(
                        // color: gPrimaryColor,
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0,bottom: 0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: const AssetImage("assets/images/pro1.jpg"),
                                  )
                                // Container(
                                //   width: 30,
                                //   height: 70,
                                //   decoration: const BoxDecoration(
                                //     //  color: Colors.orange,
                                //       borderRadius: BorderRadius.all(Radius.circular(100)),
                                //       image: DecorationImage(
                                //           image: AssetImage("assets/images/pro1.jpg"),
                                //           fit: BoxFit.cover)),
                                // ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        child: Column(
                          children: [

                            SizedBox(height: 5,),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                // border: Border.all(width: 1,color: Colors.grey)
                              ),
                              child: Row(
                                //  mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Bootstrap.person,size: 20,),
                                  SizedBox(width: 10,),
                                  InkWell(
                                      onTap: (){
                                        Fluttertoast.showToast(msg: "Please login");
                                      },
                                      child: Text("My Profile",style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500
                                      ),)),
                                  Spacer(),
                                  Icon(Bootstrap.chevron_right,color: Colors.grey.shade400,size: 20,),

                                ],
                              ),
                            ),
                            Divider(color: Colors.grey.shade300,),
                            //SizedBox(height: 5,),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                // border: Border.all(width: 1,color: Colors.grey)
                              ),
                              child: Row(

                                children: [
                                  Icon(Bootstrap.shop,size: 20,),
                                  SizedBox(width: 10,),
                                  InkWell(
                                      onTap: (){
                                        Fluttertoast.showToast(msg: "Please login");
                                      },
                                      child: Text("Orders",style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500
                                      ),)),

                                ],
                              ),
                            ),
                            Divider(color: Colors.grey.shade300,),
                            SizedBox(height: 10,),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                // border: Border.all(width: 1,color: Colors.grey)
                              ),
                              child: Row(
                                children: [
                                  Icon(Bootstrap.file_earmark,size: 20,),
                                  SizedBox(width: 10,),
                                  InkWell(
                                      onTap: (){

                                        Fluttertoast.showToast(msg: "Please login");
                                      },
                                      child: Text("My Address",style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500
                                      ),)),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //legitimacy
                    //compliance
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15,bottom: 5,top: 5),
                          child: Text("Compliance & legitimacy",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              color: textColor,
                              fontSize: 16
                          ),),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Card(
                            child: Column(
                              children: [
                                SizedBox(height: 5,),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    // border: Border.all(width: 1,color: Colors.grey)
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Bootstrap.journal,size: 20,),
                                      SizedBox(width: 10,),
                                      InkWell(
                                          onTap: (){
                                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressPage()));
                                            Navigator.pushNamed(context, privacyPolicyPage,
                                                arguments: "privacy_policy"
                                            );
                                          },
                                          child: Text("Privacy Policy",style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500
                                          ),)),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15,),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    // border: Border.all(width: 1,color: Colors.grey)
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Bootstrap.arrow_return_left,size: 20,),
                                      SizedBox(width: 10,),
                                      InkWell(
                                          onTap: (){
                                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressPage()));
                                            Navigator.pushNamed(context, privacyPolicyPage,
                                                arguments: "return_refund_policy"
                                            );
                                          },
                                          child: Text("Return Refund Policy",style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500
                                          ),)),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15,),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    // border: Border.all(width: 1,color: Colors.grey)
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Bootstrap.file_earmark_text_fill,size: 20,),
                                      SizedBox(width: 10,),
                                      InkWell(
                                          onTap: (){
                                            Navigator.pushNamed(context, privacyPolicyPage,
                                                arguments: "medical_certifications"
                                            );
                                          },
                                          child: Text("Medical Certifications",style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500
                                          ),)),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15,),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    // border: Border.all(width: 1,color: Colors.grey)
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Bootstrap.briefcase_fill,size: 20,),
                                      SizedBox(width: 10,),
                                      InkWell(
                                          onTap: (){
                                            Navigator.pushNamed(context, privacyPolicyPage,
                                                arguments: "business_registration"
                                            );
                                          },
                                          child: Text("Business Registration",style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500
                                          ),)),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, loginPath);
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(50)),
                                  color: Colors.green

                              ),
                              child: Icon(Bootstrap.box_arrow_right,color: Colors.white,size: 15,),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Text("Login",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600
                          ),),
                        ],
                      ),
                    )

                  ],
                ),
              );
            }else if (state is ProfileLoadedState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if(state.userInfoResMode!.user != "")
                      Container(
                        //color: gPrimaryColor,
                        child: Card(
                          // color: gPrimaryColor,
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10,bottom: 5),
                            child: Row(
                              children: [
                                Expanded(
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: state.userInfoResMode!.user!.image_full_url!.isNotEmpty
                                          ? NetworkImage( state.userInfoResMode!.user!.image_full_url!)
                                          : const AssetImage("assets/images/pro1.jpg"),
                                    )
                                  // Container(
                                  //   width: 30,
                                  //   height: 70,
                                  //   decoration: const BoxDecoration(
                                  //     //  color: Colors.orange,
                                  //       borderRadius: BorderRadius.all(Radius.circular(100)),
                                  //       image: DecorationImage(
                                  //           image: AssetImage("assets/images/pro1.jpg"),
                                  //           fit: BoxFit.cover)),
                                  // ),
                                ),
                                SizedBox(width: 20,),
                                Expanded(
                                    flex: 4,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              //  color: Colors.red,
                                              padding: EdgeInsets.only(right: 30,top: 5),
                                              child: Text(state.userInfoResMode!.user!.full_name!,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                   color: textColor
                                                ),),
                                            ),
                                            Positioned(
                                                top: 1,
                                                right: 5,
                                                child: InkWell(
                                                    onTap: (){
                                                      Navigator.pushNamed(context, profileEdit,
                                                        arguments: state.userInfoResMode!.user!.full_name!,


                                                      );
                                                    },
                                                    child: Icon(Bootstrap.pencil_square,size: 20,color: Colors.orange,)))
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Text(state.userInfoResMode!.user!.phone!,style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            color: textColor
                                        ),),
                                        SizedBox(height: 5,),
                                        Text(state.userInfoResMode!.user!.email!,style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            color: textColor
                                        ),),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    if(state.userInfoResMode!.user != "")
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15,bottom: 5,top: 5),
                            child: Text("General",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: lightColorScheme.onSurface,
                              fontSize: 16,

                            ),),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Card(
                              child: Column(
                                children: [
                                  SizedBox(height: 5,),
                                  InkWell(
                                    onTap: (){
                                      Navigator.pushNamed(context, profileEdit,
                                        arguments: state.userInfoResMode!.user!.full_name!,
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        // border: Border.all(width: 1,color: Colors.grey)
                                      ),
                                      child: Row(
                                        //  mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Bootstrap.person,size: 20,),
                                          SizedBox(width: 10,),
                                          InkWell(
                                              onTap: (){
                                                Navigator.pushNamed(context, profileEdit,
                                                  arguments: state.userInfoResMode!.user!.full_name!,
                                                );
                                              },
                                              child: Text("My Profile",style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500
                                              ),)),
                                          Spacer(),
                                          Icon(Bootstrap.chevron_right,color: Colors.grey.shade400,size: 15,),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(color: Colors.grey.shade400,height: 1,),
                                  InkWell(
                                    onTap: (){
                                      Navigator.pushNamed(context, profileEdit,
                                        arguments: state.userInfoResMode!.user!.full_name!,
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        // border: Border.all(width: 1,color: Colors.grey)
                                      ),
                                      child: Row(
                                        //  mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Bootstrap.person,size: 20,),
                                          SizedBox(width: 10,),
                                          InkWell(
                                              onTap: (){
                                                Navigator.pushNamed(context, changePasswordPage
                                                );
                                              },
                                              child: Text("Change password",style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500
                                              ),)),
                                          Spacer(),
                                          Icon(Bootstrap.chevron_right,color: Colors.grey.shade400,size: 15,),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(color: Colors.grey.shade400,height: 1,),
                                  SizedBox(height: 10,),
                                  InkWell(
                                    onTap: (){
                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressPage()));
                                      //  Navigator.pushNamed(context, orderPage);
                                      Navigator.pushNamed(context, orderActivityPage);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        // border: Border.all(width: 1,color: Colors.grey)
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Bootstrap.shop,size: 20,),
                                          SizedBox(width: 10,),
                                          InkWell(
                                              onTap: (){
                                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressPage()));
                                                //  Navigator.pushNamed(context, orderPage);
                                                Navigator.pushNamed(context, orderActivityPage);
                                              },
                                              child: Text("Orders",style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500
                                              ),)),
                                          Spacer(),
                                          Icon(Bootstrap.chevron_right,color: Colors.grey.shade400,size: 15,),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(color: Colors.grey.shade400,height: 1,),
                                  SizedBox(height: 10,),
                                  InkWell(
                                    onTap: (){
                                      //  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressPage()));
                                      Navigator.pushNamed(context, addressShow, arguments: state.userInfoResMode!.addresses!);


                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        // border: Border.all(width: 1,color: Colors.grey)
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Bootstrap.file_earmark,size: 20,),
                                          SizedBox(width: 10,),
                                          InkWell(
                                              onTap: (){
                                                //  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressPage()));
                                                Navigator.pushNamed(context, addressShow, arguments: state.userInfoResMode!.addresses!);


                                              },
                                              child: Text("My Address",style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500
                                              ),)),
                                          Spacer(),
                                          Icon(Bootstrap.chevron_right,color: Colors.grey.shade400,size: 15,),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(color: Colors.grey.shade400,height: 1,),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                    SizedBox(height: 12,),
                    //legitimacy
                    //compliance
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15,bottom: 5,top: 5),
                          child: Text("Compliance & legitimacy",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: textColor,
                              fontSize: 16
                          ),),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Card(
                            child: Column(
                              children: [
                                SizedBox(height: 5,),
                                InkWell(
                                  onTap: (){
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressPage()));
                                    Navigator.pushNamed(context, privacyPolicyPage,
                                        arguments: "privacy_policy"
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      // border: Border.all(width: 1,color: Colors.grey)
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Bootstrap.journal,size: 20,),
                                        SizedBox(width: 10,),
                                        InkWell(
                                            onTap: (){
                                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressPage()));
                                              Navigator.pushNamed(context, privacyPolicyPage,
                                                  arguments: "privacy_policy"
                                              );
                                            },
                                            child: Text("Privacy Policy",style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500
                                            ),)),
                                        Spacer(),
                                        Icon(Bootstrap.chevron_right,color: Colors.grey.shade400,size: 15,),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(color: Colors.grey.shade400,height: 1,),
                                SizedBox(height: 10,),
                                InkWell(
                                  onTap: (){
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressPage()));
                                    Navigator.pushNamed(context, privacyPolicyPage,
                                        arguments: "return_refund_policy"
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      // border: Border.all(width: 1,color: Colors.grey)
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Bootstrap.arrow_return_left,size: 20,),
                                        SizedBox(width: 10,),
                                        InkWell(
                                            onTap: (){
                                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressPage()));
                                              Navigator.pushNamed(context, privacyPolicyPage,
                                                  arguments: "return_refund_policy"
                                              );
                                            },
                                            child: Text("Return Refund Policy",style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500
                                            ),)),
                                        Spacer(),
                                        Icon(Bootstrap.chevron_right,color: Colors.grey.shade400,size: 15,),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(color: Colors.grey.shade400,height: 1,),
                                SizedBox(height: 10,),
                                InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(context, privacyPolicyPage,
                                        arguments: "medical_certifications"
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      // border: Border.all(width: 1,color: Colors.grey)
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Bootstrap.file_earmark_text_fill,size: 20,),
                                        SizedBox(width: 10,),
                                        InkWell(
                                            onTap: (){
                                              Navigator.pushNamed(context, privacyPolicyPage,
                                                  arguments: "medical_certifications"
                                              );
                                            },
                                            child: Text("Medical Certifications",style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500
                                            ),)),
                                        Spacer(),
                                        Icon(Bootstrap.chevron_right,color: Colors.grey.shade400,size: 15,),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(color: Colors.grey.shade400,height: 1,),
                                SizedBox(height: 10,),
                                InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(context, privacyPolicyPage,
                                        arguments: "business_registration"
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      // border: Border.all(width: 1,color: Colors.grey)
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Bootstrap.briefcase_fill,size: 20,),
                                        SizedBox(width: 10,),
                                        InkWell(
                                            onTap: (){
                                              Navigator.pushNamed(context, privacyPolicyPage,
                                                  arguments: "business_registration"
                                              );
                                            },
                                            child: Text("Business Registration",style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500
                                            ),)),

                                        Spacer(),
                                        Icon(Bootstrap.chevron_right,color: Colors.grey.shade400,size: 15,),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(color: Colors.grey.shade400,height: 1,),
                                SizedBox(width: 10,),
                                InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(context, complainGrievancePage,);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      // border: Border.all(width: 1,color: Colors.grey)
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Bootstrap.emoji_grimace,size: 20,),
                                        SizedBox(width: 10,),
                                        InkWell(
                                            onTap: (){
                                              Navigator.pushNamed(context, complainGrievancePage,);
                                            },
                                            child: Text("Complain or Grievance",style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500
                                            ),)),

                                        Spacer(),
                                        Icon(Bootstrap.chevron_right,color: Colors.grey.shade400,size: 15,),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(color: Colors.grey.shade400,height: 1,),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    InkWell(
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
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(50)),
                                  color: Colors.red

                              ),
                              child: const Icon(Bootstrap.power,color: Colors.white,size: 23,),
                            ),
                            SizedBox(width: 5,),
                            Text("Logout",style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600
                            ),),
                          ],
                        ),
                      ),
                    )

                  ],
                ),
              );
            } else if(state is ProfileErrorState){
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                     margin: EdgeInsets.only(top: 5),
                     // padding: EdgeInsets.all(5),
                      height: 120,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10,bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          //9801104847
                          children: [
                            Column(
                              children: [
                                Expanded(
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: AssetImage("assets/icons/gargimage.png"),
                                    )

                                ),
                                SizedBox(height: 10,),
                                Text("User Name")
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        child: Column(
                          children: [

                            SizedBox(height: 5,),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                // border: Border.all(width: 1,color: Colors.grey)
                              ),
                              child: Row(
                                //  mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Bootstrap.person,size: 20,),
                                  SizedBox(width: 10,),
                                  InkWell(
                                      onTap: (){
                                        CustomToast.showCustomRoast(context: context, message: "Please login", icon: Bootstrap.check_circle,iconColor: Colors.red);
                                      },
                                      child: Text("My Profile",style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500
                                      ),)),
                                  Spacer(),
                                  Icon(Bootstrap.chevron_right,color: Colors.grey.shade400,size: 20,),

                                ],
                              ),
                            ),
                            Divider(color: Colors.grey.shade300,),
                            //SizedBox(height: 5,),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                // border: Border.all(width: 1,color: Colors.grey)
                              ),
                              child: Row(

                                children: [
                                  Icon(Bootstrap.shop,size: 20,),
                                  SizedBox(width: 10,),
                                  InkWell(
                                      onTap: (){
                                        CustomToast.showCustomRoast(context: context, message: "Please login", icon: Bootstrap.check_circle,iconColor: Colors.red);
                                      },
                                      child: Text("Orders",style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500
                                      ),)),

                                ],
                              ),
                            ),
                            Divider(color: Colors.grey.shade300,),
                            SizedBox(height: 10,),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                // border: Border.all(width: 1,color: Colors.grey)
                              ),
                              child: Row(
                                children: [
                                  Icon(Bootstrap.file_earmark,size: 20,),
                                  SizedBox(width: 10,),
                                  InkWell(
                                      onTap: (){
                                        CustomToast.showCustomRoast(context: context, message: "Please login", icon: Bootstrap.check_circle,iconColor: Colors.red);
                                      },
                                      child: Text("My Address",style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500
                                      ),)),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //legitimacy
                    //compliance
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15,bottom: 5,top: 5),
                          child: Text("Compliance & legitimacy",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              color: gPrimaryColor,
                              fontSize: 16
                          ),),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Card(
                            child: Column(
                              children: [
                                SizedBox(height: 5,),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    // border: Border.all(width: 1,color: Colors.grey)
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Bootstrap.journal,size: 20,),
                                      SizedBox(width: 10,),
                                      InkWell(
                                          onTap: (){
                                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressPage()));
                                            Navigator.pushNamed(context, privacyPolicyPage,
                                                arguments: "privacy_policy"
                                            );
                                          },
                                          child: Text("Privacy Policy",style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500
                                          ),)),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15,),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    // border: Border.all(width: 1,color: Colors.grey)
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Bootstrap.arrow_return_left,size: 20,),
                                      SizedBox(width: 10,),
                                      InkWell(
                                          onTap: (){
                                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressPage()));
                                            Navigator.pushNamed(context, privacyPolicyPage,
                                                arguments: "return_refund_policy"
                                            );
                                          },
                                          child: Text("Return Refund Policy",style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500
                                          ),)),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15,),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    // border: Border.all(width: 1,color: Colors.grey)
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Bootstrap.file_earmark_text_fill,size: 20,),
                                      SizedBox(width: 10,),
                                      InkWell(
                                          onTap: (){
                                            Navigator.pushNamed(context, privacyPolicyPage,
                                                arguments: "medical_certifications"
                                            );
                                          },
                                          child: Text("Medical Certifications",style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500
                                          ),)),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15,),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    // border: Border.all(width: 1,color: Colors.grey)
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Bootstrap.briefcase_fill,size: 20,),
                                      SizedBox(width: 10,),
                                      InkWell(
                                          onTap: (){
                                            Navigator.pushNamed(context, privacyPolicyPage,
                                                arguments: "business_registration"
                                            );
                                          },
                                          child: Text("Business Registration",style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500
                                          ),)),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, loginPath);
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(50)),
                                  color: Colors.green

                              ),
                              child: Icon(Bootstrap.box_arrow_right,color: Colors.white,size: 15,),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Text("Login",style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600
                          ),),
                        ],
                      ),
                    )

                  ],
                ),
              );
            }else{
              return Container();
            }

          },
        ));
  },);
  }
}
class OrdersReturnsSection extends StatelessWidget {
  const OrdersReturnsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Orders & Returns',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 _buildTab("InProgress", Bootstrap.wallet_fill,Colors.blue),
                 _buildTab("ToPay", Bootstrap.cash,Colors.blue),
                 _buildTab("Delivered", Bootstrap.truck,Colors.blue),
               ],
             )

          ],
        ),
      ),
    );
  }
  Widget _buildTab(String title, IconData icon,Color color) {
    return Column(
      children: [
        Icon(icon,color: color,),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color:  Colors.black,
          ),
        ),
      ],
    );
  }
}

