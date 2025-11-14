import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/core/constant/colors_constant.dart';
import 'package:oms_ecommerce/screen/contact_us/bloc/contactus_bloc.dart';
import 'package:oms_ecommerce/screen/contact_us/bloc/contactus_event.dart';

import '../../core/constant/textstyle.dart';
import '../../scroll/scroll_bloc.dart';
import '../../scroll/scroll_state.dart';
import '../widget/text_field_decoration.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final globalKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: BlocBuilder<ScrollBloc,ScrollState>(builder: (BuildContext context, state) {
          if(state is ScrollLoadingState){
            return AppBar(
              bottomOpacity: 55,
              title: Row(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text("Garg Dental",style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      // color: Colors.blueAccent
                    ),),
                  ),

                ],
              ),
              actions: [
                Icon(Bootstrap.chevron_bar_left)
              ],
              elevation: 0,
              leading: InkWell(
                  onTap: ()=>Navigator.pop(context),
                  child: Icon(Bootstrap.chevron_left)),
              // backgroundColor: Colors.lightBlue,
            );
          }else if(state is ScrollLoadedState){
            return AppBar(
              bottomOpacity: 55,
              title: Row(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text("Garg Dental",style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      // color: Colors.blueAccent
                    ),),
                  ),

                ],
              ),
              elevation: 0,
              leading: InkWell(
                  onTap: ()=>Navigator.pop(context),
                  child: Icon(Bootstrap.chevron_left)),
              // backgroundColor: Colors.lightBlue,
            );
          }else{
            return AppBar(
              bottomOpacity: 55,
              title: Row(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text("Garg Dental",style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      // color: Colors.blueAccent
                    ),),
                  ),

                ],
              ),
              elevation: 0,
              leading: InkWell(
                  onTap: ()=>Navigator.pop(context),
                  child: Icon(Bootstrap.chevron_left)),
              // backgroundColor: Colors.lightBlue,
            );
          }
        },),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: globalKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  onChanged: (value) {
                    if (value.isEmpty) {

                    }
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please enter name";
                    }
                    return null;
                  },
                  decoration: TextFormDecoration.decoration(
                    hintText: "Full Name",
                    hintStyle: hintTextStyle,
                    prefixIcon: Icons.person,
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: emailController,
                  onChanged: (value) {
                    if (value.isEmpty) {

                    }
                  },
                  validator: (value){
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: TextFormDecoration.decoration(
                    hintText: "email",
                    hintStyle: hintTextStyle,
                    prefixIcon: Icons.email,
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: messageController,
                  maxLines: 3,
                  onChanged: (value) {
                    if (value.isEmpty) {

                    }
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please enter message";
                    }
                    return null;
                  },
                  decoration: TextFormDecoration.decoration(
                    hintText: "Write message",
                    hintStyle: hintTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10,bottom: 3,top: 10),
        child: InkWell(
          onTap: (){
            if(globalKey.currentState!.validate()) {
              context.read<ContactusBloc>().add(ContactReqEvent(
                  name: nameController.text.trim(),
                  email: emailController.text.trim(),
                  message: messageController.text.trim()));
              nameController.text = "";
              emailController.text = "";
              messageController.text = "";
            }else{
              Fluttertoast.showToast(msg: "All fields required!");
            }
          },
          child: Container(
            height: 50,
            padding: EdgeInsets.only(left: 7),
            decoration: BoxDecoration(
                color: Color(0xff003466),
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: Center(
              child: Text("Save",style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600
              ),),
            ),
          ),
        ),
      ),
    );
  }
}
