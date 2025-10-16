import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/component/loading_overlay.dart';
import 'package:oms_ecommerce/core/constant/asstes_list.dart';

import 'package:oms_ecommerce/screen/login/block/login_block.dart';
import 'package:oms_ecommerce/screen/login/block/login_event.dart';
import 'package:oms_ecommerce/screen/login/block/login_state.dart';
import 'package:oms_ecommerce/screen/login/login_home_page.dart';
import 'package:oms_ecommerce/screen/login/model/login_req_model.dart';
import 'package:oms_ecommerce/screen/main/home_page.dart';
import 'package:oms_ecommerce/screen/widget/gredient_container.dart';

import '../../core/constant/colors_constant.dart';
import '../../core/services/routeHelper/route_name.dart';
import '../../native_android/check_naive.dart';
import '../../native_android/native_bridge.dart';
import 'google_auth_service/auth_service.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<LoginBlock>(context).add(LoginResetReqEvent());
    });

  }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Scaffold(
     //   backgroundColor: Colors.transparent,
        body: BlocConsumer<LoginBlock, LoginState>(
          builder: (BuildContext context, state) {
             if(state is LoginInitialState){
               return SingleChildScrollView(
                 child: Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Container(
                         margin: EdgeInsets.only(top: 17),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             InkWell(
                                 onTap: () async {
                                  Navigator.pop(context);
                                 },
                                 child: const Icon(Bootstrap.chevron_left)),

                           ],
                         ),
                       ),
                       const SizedBox(height: 80),
                       // Text(
                       //   'Already Registered?',
                       //   style: GoogleFonts.poppins(
                       //       fontSize: 18,
                       //       fontWeight: FontWeight.w600,
                       //       color: Colors.black),
                       // ),
                       // const SizedBox(height: 10),
                       Text(
                         'Sign in',
                         style: GoogleFonts.poppins(
                             fontSize: 17,
                             fontWeight: FontWeight.w600,
                             color: Colors.black),
                       ),
                       const SizedBox(height: 30),
                       Text(
                         'Email/Phone number',
                         style: GoogleFonts.poppins(
                             fontSize: 14,
                             fontWeight: FontWeight.w600,
                             color: Colors.black38),
                       ),
                       const SizedBox(height: 5),
                       TextField(
                         controller: emailController,
                         decoration: InputDecoration(
                           hintText: 'Email',
                           hintStyle: GoogleFonts.poppins(
                               fontSize: 14,
                               fontWeight: FontWeight.w600,
                               color: Colors.black38),
                           fillColor: Colors.white,
                           filled: true,
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(10),
                           ),
                           prefixIcon: Icon(Icons.person),
                           // For a more complete styling, you might also want to add:
                           enabledBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(10),
                             borderSide: BorderSide(
                                 color:
                                 Colors.grey), // Optional: customize border color
                           ),
                           focusedBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(10),
                             borderSide: BorderSide(
                                 color: Colors.blue), // Optional: focus color
                           ),
                         ),
                       ),
                       const SizedBox(height: 20),
                       Text(
                         'Password',
                         style: GoogleFonts.poppins(
                             fontSize: 14,
                             fontWeight: FontWeight.w600,
                             color: Colors.black38),
                       ),
                       const SizedBox(height: 5),
                       TextField(
                         controller: passwordController,
                         obscureText: true,
                         decoration: InputDecoration(
                           hintText: "Password",
                           hintStyle: GoogleFonts.poppins(
                               fontSize: 14,
                               fontWeight: FontWeight.w600,
                               color: Colors.black38),
                           fillColor: Colors.white,
                           filled: true,
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(10),
                           ),
                           prefixIcon: Icon(Icons.password),
                           // For a more complete styling, you might also want to add:
                           enabledBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(10),
                             borderSide: BorderSide(
                                 color:
                                 Colors.grey), // Optional: customize border color
                           ),
                           focusedBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(10),
                             borderSide: BorderSide(
                                 color: Colors.blue), // Optional: focus color
                           ),
                         ),
                       ),
                       const SizedBox(height: 0),
                       // Align(
                       //   alignment: Alignment.center,
                       //   child: TextButton(
                       //     onPressed: () {
                       //       // Handle lost password
                       //     },
                       //     child: Text(
                       //       'Forget your password?',
                       //       style: GoogleFonts.poppins(
                       //           fontSize: 14,
                       //           fontWeight: FontWeight.w600,
                       //           color: Colors.grey),
                       //     ),
                       //   ),
                       // ),
                       const SizedBox(height: 20),
                       SizedBox(
                         width: double.infinity,
                         child: ElevatedButton(
                           onPressed: () async {
                             BlocProvider.of<LoginBlock>(context).add(LoginReqEvent(loginReqModel: LoginReqModel(email: emailController.text, password: passwordController.text)));

                           },
                           style: ElevatedButton.styleFrom(
                             padding: const EdgeInsets.symmetric(vertical: 16),
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(10),
                             ),
                             backgroundColor: gPrimaryColor, // Make button bg transparent
                             shadowColor: Colors.transparent, // Remove default shadow
                           ),
                           child: Text('Sign in',
                               style: GoogleFonts.poppins(
                                   fontSize: 14,
                                   fontWeight: FontWeight.w600,
                                   color: Colors.white)),
                         ),
                       ),
                       const SizedBox(height: 20),
                       Center(
                         child: Text(
                           'Don\'t have an account?',
                           style: GoogleFonts.poppins(
                               fontSize: 14,
                               fontWeight: FontWeight.w600,
                               color: Colors.grey),
                         ),
                       ),
                       const SizedBox(height: 10),
                       const Center(child: Text('Or')),
                       const SizedBox(height: 20),
                       Visibility(
                         visible: false,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             InkWell(
                               onTap: (){
                                 LoadingOverlay.show(context);
                                 AuthService.loginWithGoogle(context);
                               },
                               child: Container(
                                 padding: EdgeInsets.all(10),
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.all(Radius.circular(50)),
                                   border: Border.all(color: Colors.black.withOpacity(0.2),)
                                 ),
                                 child: Row(
                                   children: [
                                     Image.asset("assets/images/googlesignin.png",width: 30,height: 30,),
                                     const SizedBox(width: 10,),
                                     Text("Sign in with google",style: GoogleFonts.poppins(
                                       fontWeight: FontWeight.w500
                                     ),)
                                   ],
                                 ),
                               ),
                             ),
                           ],
                         ),
                       ),
                       const SizedBox(height: 20),
                       Visibility(
                         visible: true,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             InkWell(
                               onTap: (){
                                 Navigator.pushNamed(context,singupPath);
                               },
                               child: Container(
                                 padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.all(Radius.circular(50)),
                                     border: Border.all(color: Colors.blue,)
                                 ),
                                 child: Text("CREATE AN ACCOUNT",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
                               ),
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ),
               );
             }else if(state is LoginLoadingState){
               return const Center(child: CircularProgressIndicator(),);
             }else if(state is LoginLoadedState){
               return Center(child: Text(""),);
             }else if(state is LoginErrorState){
               return Center(child: Text(state.errorMsg??""),);
             }else{
               return Container();
             }
          },
          listener: (BuildContext context,  state) {
            if(state is LoginLoadedState){
              //HomePage
              Fluttertoast.showToast(msg: "Login successfully");
              Navigator.pushNamed(context,homeNavbar);
            }
          },)

        // BlocBuilder<LoginBlock, LoginState>(builder: (BuildContext context, state) {
        //  if(state is LoginInitialState){
        //    return SingleChildScrollView(
        //      child: Padding(
        //        padding: const EdgeInsets.all(20.0),
        //        child: Column(
        //          crossAxisAlignment: CrossAxisAlignment.start,
        //          children: [
        //            Container(
        //              margin: EdgeInsets.only(top: 15),
        //              child: Row(
        //                mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                children: [
        //                  InkWell(
        //                      onTap: () async {
        //                        Navigator.push(
        //                            context,
        //                            MaterialPageRoute(
        //                                builder: (context) => MainPage()));
        //                      },
        //                      child: const Icon(Icons.arrow_circle_left_outlined)),
        //                  Image.asset(
        //                    AssetsList.appIcon,
        //                    width: 30,
        //                    height: 30,
        //                  )
        //                ],
        //              ),
        //            ),
        //            const SizedBox(height: 80),
        //            Text(
        //              'Already Registered?',
        //              style: GoogleFonts.poppins(
        //                  fontSize: 18,
        //                  fontWeight: FontWeight.w600,
        //                  color: Colors.black),
        //            ),
        //            const SizedBox(height: 10),
        //            Text(
        //              'Sign in',
        //              style: GoogleFonts.poppins(
        //                  fontSize: 17,
        //                  fontWeight: FontWeight.w600,
        //                  color: Colors.black),
        //            ),
        //            const SizedBox(height: 30),
        //            Text(
        //              'Email/Phone number',
        //              style: GoogleFonts.poppins(
        //                  fontSize: 14,
        //                  fontWeight: FontWeight.w600,
        //                  color: Colors.black38),
        //            ),
        //            const SizedBox(height: 5),
        //            TextField(
        //              controller: emailController,
        //              decoration: InputDecoration(
        //                hintText: 'Email',
        //                hintStyle: GoogleFonts.poppins(
        //                    fontSize: 14,
        //                    fontWeight: FontWeight.w600,
        //                    color: Colors.black38),
        //                fillColor: Colors.white,
        //                filled: true,
        //                border: OutlineInputBorder(
        //                  borderRadius: BorderRadius.circular(50),
        //                ),
        //                prefixIcon: Icon(Icons.person),
        //                // For a more complete styling, you might also want to add:
        //                enabledBorder: OutlineInputBorder(
        //                  borderRadius: BorderRadius.circular(50),
        //                  borderSide: BorderSide(
        //                      color:
        //                      Colors.grey), // Optional: customize border color
        //                ),
        //                focusedBorder: OutlineInputBorder(
        //                  borderRadius: BorderRadius.circular(50),
        //                  borderSide: BorderSide(
        //                      color: Colors.blue), // Optional: focus color
        //                ),
        //              ),
        //            ),
        //            const SizedBox(height: 20),
        //            Text(
        //              'Password',
        //              style: GoogleFonts.poppins(
        //                  fontSize: 14,
        //                  fontWeight: FontWeight.w600,
        //                  color: Colors.black38),
        //            ),
        //            const SizedBox(height: 5),
        //            TextField(
        //              controller: passwordController,
        //              obscureText: true,
        //              decoration: InputDecoration(
        //                hintText: "Password",
        //                hintStyle: GoogleFonts.poppins(
        //                    fontSize: 14,
        //                    fontWeight: FontWeight.w600,
        //                    color: Colors.black38),
        //                fillColor: Colors.white,
        //                filled: true,
        //                border: OutlineInputBorder(
        //                  borderRadius: BorderRadius.circular(50),
        //                ),
        //                prefixIcon: Icon(Icons.password),
        //                // For a more complete styling, you might also want to add:
        //                enabledBorder: OutlineInputBorder(
        //                  borderRadius: BorderRadius.circular(50),
        //                  borderSide: BorderSide(
        //                      color:
        //                      Colors.grey), // Optional: customize border color
        //                ),
        //                focusedBorder: OutlineInputBorder(
        //                  borderRadius: BorderRadius.circular(50),
        //                  borderSide: BorderSide(
        //                      color: Colors.blue), // Optional: focus color
        //                ),
        //              ),
        //            ),
        //            const SizedBox(height: 10),
        //            Align(
        //              alignment: Alignment.center,
        //              child: TextButton(
        //                onPressed: () {
        //                  // Handle lost password
        //                },
        //                child: Text(
        //                  'Lost your password?',
        //                  style: GoogleFonts.poppins(
        //                      fontSize: 14,
        //                      fontWeight: FontWeight.w600,
        //                      color: Colors.grey),
        //                ),
        //              ),
        //            ),
        //            const SizedBox(height: 20),
        //            SizedBox(
        //              width: double.infinity,
        //              child: ElevatedButton(
        //                onPressed: () {
        //                  BlocProvider.of<LoginBlock>(context).add(LoginReqEvent(
        //                      loginReqModel: LoginReqModel(
        //                          email: emailController.text,
        //                          password: passwordController.text)));
        //                },
        //                style: ElevatedButton.styleFrom(
        //                  padding: const EdgeInsets.symmetric(vertical: 16),
        //                  shape: RoundedRectangleBorder(
        //                    borderRadius: BorderRadius.circular(50),
        //                  ),
        //                  backgroundColor: btnColor, // Make button bg transparent
        //                  shadowColor: Colors.transparent, // Remove default shadow
        //                ),
        //                child: Text('Sign in',
        //                    style: GoogleFonts.poppins(
        //                        fontSize: 14,
        //                        fontWeight: FontWeight.w600,
        //                        color: Colors.white)),
        //              ),
        //            ),
        //            const SizedBox(height: 20),
        //            Center(
        //              child: Text(
        //                'Don\'t have an account?',
        //                style: GoogleFonts.poppins(
        //                    fontSize: 14,
        //                    fontWeight: FontWeight.w600,
        //                    color: Colors.grey),
        //              ),
        //            ),
        //            const SizedBox(height: 10),
        //            const Center(child: Text('Or')),
        //            const SizedBox(height: 20),
        //            Visibility(
        //              visible: false,
        //              child: Row(
        //                mainAxisAlignment: MainAxisAlignment.center,
        //                children: [
        //                  IconButton(
        //                    icon: const Icon(Icons.facebook, size: 30),
        //                    onPressed: () {},
        //                  ),
        //                  const SizedBox(width: 20),
        //                  IconButton(
        //                    icon: const Icon(Icons.facebook, size: 30),
        //                    onPressed: () {},
        //                  ),
        //                  const SizedBox(width: 20),
        //                  IconButton(
        //                    icon: const Icon(Icons.apple, size: 30),
        //                    onPressed: () {},
        //                  ),
        //                ],
        //              ),
        //            ),
        //          ],
        //        ),
        //      ),
        //    );
        //  }else if(state is LoginLoadingState){
        //    return CircularProgressIndicator();
        //  }else if(state is LoginLoadedState){
        //    return Center(child: Text(state.loginRespModel?.message??""),);
        //  }else if(state is LoginErrorState){
        //    return Center(child: Text(state.errorMsg??""),);
        //  }
        //  else{
        //    return Container();
        //  }
        // },),
      ),
    );
  }
}
