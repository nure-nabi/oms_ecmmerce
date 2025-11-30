import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/component/loading_overlay.dart';
import 'package:oms_ecommerce/core/constant/asstes_list.dart';
import 'package:oms_ecommerce/core/services/routeHelper/route_name.dart';
import 'package:oms_ecommerce/screen/forget_password/bloc/change_password/change_password_bloc.dart';
import 'package:oms_ecommerce/screen/forget_password/bloc/change_password/change_password_event.dart';
import 'package:oms_ecommerce/screen/singup/block/register_bloc.dart';
import 'package:oms_ecommerce/screen/singup/block/register_event.dart';
import 'package:oms_ecommerce/screen/singup/block/register_state.dart';
import 'package:oms_ecommerce/screen/singup/model/register_model.dart';
import 'package:oms_ecommerce/screen/widget/gredient_container.dart';

import '../../../core/constant/colors_constant.dart';
import '../../login/google_auth_service/auth_service.dart';
import '../bloc/change_password/change_password_state.dart';


class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newConfirmationPasswordController = TextEditingController();
  bool isOldPasswordObscured = true;
  bool isNewPasswordObscured = true;
  bool isConfirmPasswordObscured = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //context.read<ChangePasswordBloc>().add(ChangePasswordClearReqEvent());
  }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        body: BlocConsumer<ChangePasswordBloc,ChangePasswordState>(
          builder: (BuildContext context, state) {
            if(state is ChangePasswordInitialState){
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
                      const SizedBox(height: 10),
                      Text(
                        'Change Password',
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 10),

                      Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                'Old Password',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black38),
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                controller: oldPasswordController,
                                obscureText: isOldPasswordObscured,
                                decoration: InputDecoration(
                                  hintText: "Old Password",
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black38,
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: Icon(Icons.password),

                                  // 👇 Password visibility toggle button
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isOldPasswordObscured ? Icons.visibility_off : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isOldPasswordObscured = !isOldPasswordObscured;
                                      });
                                    },
                                  ),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                ),

                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter old password';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'New Password',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black38),
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                controller: newPasswordController,
                                obscureText: isNewPasswordObscured,
                                decoration: InputDecoration(
                                  hintText: "New Password",
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black38),
                                  fillColor: Colors.white,
                                  filled: true,
                                  // 👇 Password visibility toggle button
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isNewPasswordObscured ? Icons.visibility_off : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isNewPasswordObscured = !isNewPasswordObscured;
                                      });
                                    },
                                  ),
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter old password';
                                  }else if (newPasswordController.text.length < 8) {
                                    return 'Please enter minimum 8 characters';
                                  }
                                  return null; // Valid input
                                },
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Confirm Password *',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black38),
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                controller: newConfirmationPasswordController,
                                obscureText: isConfirmPasswordObscured,
                                decoration: InputDecoration(
                                  hintText: "Confirm Password ",
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black38),
                                  fillColor: Colors.white,
                                  filled: true,
                                  // 👇 Password visibility toggle button
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isConfirmPasswordObscured ? Icons.visibility_off : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isConfirmPasswordObscured = !isConfirmPasswordObscured;
                                      });
                                    },
                                  ),
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please confirm your password';
                                  } else if (value != newPasswordController.text) {
                                    return 'Passwords do not match';
                                  }else if (newConfirmationPasswordController.text.length < 8) {
                                    return 'Please enter minimum 8 characters';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),

                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async{
                                    if(_formKey.currentState!.validate()){
                                      LoadingOverlay.show(context);
                                      context.read<ChangePasswordBloc>().add(
                                          ChangePasswordReqEvent(
                                              oldPassword: oldPasswordController.text.trim(),
                                              newPassword: newPasswordController.text.trim(),
                                              newConfirmPassword:newConfirmationPasswordController.text.trim()
                                          ));

                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: gPrimaryColor, // Make button bg transparent
                                    shadowColor: Colors.transparent, // Remove default shadow
                                  ),
                                  child: Text('Change Password',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white)),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          )),

                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Center(
                            child: Text(
                              'Already have an account',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      const SizedBox(height: 20),
                      Visibility(
                        visible: false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.facebook, size: 30),
                              onPressed: () {},
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              icon: const Icon(Icons.facebook, size: 30),
                              onPressed: () {},
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              icon: const Icon(Icons.apple, size: 30),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }else{
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
                      const SizedBox(height: 10),
                      Text(
                        'Change Password',
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 10),

                      Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                'Old Password',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black38),
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                controller: oldPasswordController,
                                obscureText: isOldPasswordObscured,
                                decoration: InputDecoration(
                                  hintText: "Old Password",
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black38,
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  prefixIcon: Icon(Icons.password),

                                  // 👇 Password visibility toggle button
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isOldPasswordObscured ? Icons.visibility_off : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isOldPasswordObscured = !isOldPasswordObscured;
                                      });
                                    },
                                  ),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                ),

                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter old password';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'New Password',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black38),
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                controller: newPasswordController,
                                obscureText: isNewPasswordObscured,
                                decoration: InputDecoration(
                                  hintText: "New Password",
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black38),
                                  fillColor: Colors.white,
                                  filled: true,
                                  // 👇 Password visibility toggle button
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isNewPasswordObscured ? Icons.visibility_off : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isNewPasswordObscured = !isNewPasswordObscured;
                                      });
                                    },
                                  ),
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter old password';
                                  }else if (newPasswordController.text.length < 8) {
                                    return 'Please enter minimum 8 characters';
                                  }
                                  return null; // Valid input
                                },
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Confirm Password *',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black38),
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                controller: newConfirmationPasswordController,
                                obscureText: isConfirmPasswordObscured,
                                decoration: InputDecoration(
                                  hintText: "Confirm Password ",
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black38),
                                  fillColor: Colors.white,
                                  filled: true,
                                  // 👇 Password visibility toggle button
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isConfirmPasswordObscured ? Icons.visibility_off : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isConfirmPasswordObscured = !isConfirmPasswordObscured;
                                      });
                                    },
                                  ),
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please confirm your password';
                                  } else if (value != newPasswordController.text) {
                                    return 'Passwords do not match';
                                  }else if (newConfirmationPasswordController.text.length < 8) {
                                    return 'Please enter minimum 8 characters';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),

                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async{
                                    if(_formKey.currentState!.validate()){
                                      LoadingOverlay.show(context);
                                      context.read<ChangePasswordBloc>().add(
                                          ChangePasswordReqEvent(
                                              oldPassword: oldPasswordController.text.trim(),
                                              newPassword: newPasswordController.text.trim(),
                                              newConfirmPassword:newConfirmationPasswordController.text.trim()
                                          ));

                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: gPrimaryColor, // Make button bg transparent
                                    shadowColor: Colors.transparent, // Remove default shadow
                                  ),
                                  child: Text('Change Password',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white)),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          )),

                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Center(
                            child: Text(
                              'Already have an account',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      const SizedBox(height: 20),
                      Visibility(
                        visible: false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.facebook, size: 30),
                              onPressed: () {},
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              icon: const Icon(Icons.facebook, size: 30),
                              onPressed: () {},
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              icon: const Icon(Icons.apple, size: 30),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
          listener: (BuildContext context, Object? state) {
            if(state is ChangePasswordLoadedState){
              AuthService.logout(context);
              // Navigator.pushNamedAndRemoveUntil(
              //   context,
              //   loginPath,
              //       (Route<dynamic> route) => false, // This removes all routes
              // );
            }else if(state is ChangePasswordErrorState){
              Fluttertoast.showToast(msg: state.errorMsg!);
            }
          },),
      ),
    );
  }
}
