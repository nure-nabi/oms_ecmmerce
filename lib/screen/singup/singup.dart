import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/core/constant/asstes_list.dart';
import 'package:oms_ecommerce/core/services/routeHelper/route_name.dart';
import 'package:oms_ecommerce/screen/singup/block/register_bloc.dart';
import 'package:oms_ecommerce/screen/singup/block/register_event.dart';
import 'package:oms_ecommerce/screen/singup/block/register_state.dart';
import 'package:oms_ecommerce/screen/singup/model/register_model.dart';
import 'package:oms_ecommerce/screen/widget/gredient_container.dart';

import '../../core/constant/colors_constant.dart';
import '../service/sharepref/set_all_pref.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({super.key});

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Scaffold(
       // backgroundColor: Colors.transparent,
        body: BlocConsumer<RegisterBloc,RegisterState>(
          builder: (BuildContext context, state) {
          if(state is RegisterInitialState){
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
                      'Create an account',
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
                          'First Name',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black38),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: firstNameController,
                          decoration: InputDecoration(
                            hintText: 'First Name',
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter first name';
                            }
                            return null; // Valid input
                          },

                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Last Name',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black38),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: lastNameController,
                          decoration: InputDecoration(
                            hintText: 'Last Name',
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter last name';
                            }
                            return null; // Valid input
                          },
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Email',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black38),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
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
                            prefixIcon: Icon(Icons.email),
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
                            if (value != null && value.isNotEmpty) {
                              if (!EmailValidator.validate(value)) {
                                return 'Please enter a valid email';
                              }
                            }
                            return null; // Valid input
                          },
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Mobile Number',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black38),
                        ),
                        if(Platform.isAndroid)
                        const SizedBox(height: 5),
                        if(Platform.isAndroid)
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: phoneController,
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black38),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: Icon(Icons.phone),
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
                              return 'Please enter mobile number';
                            }
                            return null; // Valid input
                          },
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Password',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black38),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            } else if (value.length < 6) {
                              return 'Please enter minimum 6 password';
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
                          controller: confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Confirm Password ",
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            } else if (value != passwordController.text) {
                              return 'Passwords do not match';
                            }else if (value.length < 6) {
                              return 'Please enter minimum 6 password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
// Terms and Policy
//                     Row(
//                       children: [
//                         Checkbox(value: true, onChanged: (val) {}),
//                         Expanded(
//                           child: RichText(
//                             text: TextSpan(
//                               style:
//                               TextStyle(color: Colors.grey[700], fontSize: 12),
//                               children: [
//                                 TextSpan(
//                                   text:
//                                   'By clicking on "Create Account", I agree on ',
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 11,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.black38),
//                                 ),
//                                 TextSpan(
//                                   text: 'Terms of Use',
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.blue),
//                                 ),
//                                 TextSpan(text: ' & '),
//                                 TextSpan(
//                                   text: 'Privacy Policy',
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 11,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.blue),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async{
                              if(_formKey.currentState!.validate()){
                                await SetAllPref.verificationEmail(value: emailController.text.trim());
                                BlocProvider.of<RegisterBloc>(context).add(
                                    RegisterReqEvent(
                                        registerReqModel: RegisterReqModel(
                                          firstName: firstNameController.text.trim(),
                                          lastName: lastNameController.text.trim(),
                                          password: passwordController.text.trim(),
                                          phone:phoneController.text.trim(),
                                          email:emailController.text.trim(),)));
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
                            child: Text('CREATE ACCOUNT',
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
            return Container();
          }
        },
          listener: (BuildContext context, Object? state) async {
            if(state is RegisterLoadedState){
              Navigator.pushNamed(context,
                  verificationRegister,
                arguments: state.registerResModel!.code.toString()
              );
            await  SetAllPref.verificationEmail(value: state.registerResModel!.email!);
            }else if(state is RegisterErrorState){
               Fluttertoast.showToast(msg:state.errorMsg!);
            }
          },),
      ),
    );
  }
}
