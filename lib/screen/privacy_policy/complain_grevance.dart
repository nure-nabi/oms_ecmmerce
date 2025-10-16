import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/core/constant/colors_constant.dart';
import 'package:oms_ecommerce/screen/privacy_policy/bloc/compain_bloc/complain_bloc.dart';
import 'package:oms_ecommerce/screen/privacy_policy/bloc/compain_bloc/complain_event.dart';
import 'package:oms_ecommerce/screen/privacy_policy/bloc/compain_bloc/complain_state.dart';

import '../../core/constant/textstyle.dart';
import '../../utils/whatsapp.dart';
import '../profile/block/image_picker_block/image_picker_block.dart';
import '../profile/block/image_picker_block/image_picker_event.dart';
import '../profile/block/image_picker_block/image_picker_state.dart';
import '../widget/text_field_decoration.dart';
import 'package:flutter/services.dart';


class ComplainGrievance extends StatefulWidget {
  const ComplainGrievance({super.key});

  @override
  State<ComplainGrievance> createState() => _ComplainGrievanceState();
}

class _ComplainGrievanceState extends State<ComplainGrievance> {
  final globalKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  String imagePath = "";
  String base64Image = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Complain or Grievance"),
          backgroundColor: gPrimaryColor,
          leading: InkWell(
            onTap: ()=>Navigator.pop(context),
              child: Icon(Bootstrap.chevron_left)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  TextFormField(
                    controller: phoneController,
                    onChanged: (value) {
                      if (value.isEmpty) {

                      }
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please enter phone";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: TextFormDecoration.decoration(
                      hintText: "Phone",
                      hintStyle: hintTextStyle,
                      prefixIcon: Icons.phone,
                    ),
                  ),
                  TextFormField(
                    controller: cityController,
                    onChanged: (value) {
                      if (value.isEmpty) {

                      }
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please enter city";
                      }
                      return null;
                    },
                    decoration: TextFormDecoration.decoration(
                      hintText: "City",
                      hintStyle: hintTextStyle,
                      prefixIcon: Icons.location_city,
                    ),
                  ),
                  TextFormField(
                    controller: remarkController,
                    maxLines: 3,
                    onChanged: (value) {
                      if (value.isEmpty) {

                      }
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please enter remark";
                      }
                      return null;
                    },
                    decoration: TextFormDecoration.decoration(
                      hintText: "Write remark.....",
                      hintStyle: hintTextStyle,
                    ),
                  ),
                  SizedBox(height: 10,),

                  Text("Attachement",style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600
                  ),),
                  SizedBox(height: 5,),
                  BlocConsumer<ImagePickerBlock,ImagePickerState>(
                      builder: (context,state){
                        if(state is ImagePickerInitialState){
                          return InkWell(
                            onTap: (){
                              context.read<ImagePickerBlock>().add(GalleryImageEvent());
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey,width: 1),
                                  borderRadius: BorderRadius.all(Radius.circular(5))
                              ),
                              child: Icon(Bootstrap.camera),
                            ),
                          );
                        } else if(state is ImagePickerLoadedState){
                          if(state.getPickedImage !=null){
                            base64Image = state.getPickedImage!;
                            Uint8List bytes = base64Decode(state.getPickedImage!);
                           return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               SizedBox(height: 10,),
                               InkWell(
                                 onTap: (){
                                   context.read<ImagePickerBlock>().add(GalleryImageEvent());
                                 },
                                 child: Container(
                                   padding: EdgeInsets.all(5),
                                   decoration: BoxDecoration(
                                       border: Border.all(color: Colors.grey,width: 1),
                                       borderRadius: BorderRadius.all(Radius.circular(5))
                                   ),
                                   child: Icon(Bootstrap.camera),
                                 ),
                               ),
                               SizedBox(height: 5,),
                               Container(
                                 width: MediaQuery.of(context).size.width,  // specify width
                                 height: 200, // specify height
                                 decoration: BoxDecoration(
                                   border: Border.all(color: Colors.grey),
                                   borderRadius: BorderRadius.circular(8),
                                 ),
                                 child: bytes != null && bytes.isNotEmpty
                                     ? Image.memory(
                                   bytes,
                                   fit: BoxFit.cover, // or BoxFit.contain based on your needs
                                   errorBuilder: (context, error, stackTrace) {
                                     return Icon(Icons.error, color: Colors.red);
                                   },
                                 )
                                     : Placeholder(), // or any fallback widget
                               )
                             ],
                           );
                          }
                          return Text("Loaded");
                        }else{
                          return Container();
                        }

                      },
                      listener: (context,state){
                        if(state is ImagePickerLoadedState){
                          imagePath = state.path.toString();
                          Fluttertoast.showToast(msg: state.path.toString());
                        }
                      })
                ],
              )

            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,bottom: 3,top: 10),
          child: InkWell(
            onTap: (){
              if(globalKey.currentState!.validate()) {
                context.read<ComplainBloc>().add(ComplainReqEvent(
                    name: nameController.text.trim(),
                    email: emailController.text.trim(),
                    city: cityController.text.trim(),
                    phone: phoneController.text.trim(),
                    remark: remarkController.text.trim(),
                    imagePath: imagePath
                )
                );
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(Bootstrap.whatsapp),
          onPressed: () async{
            // Example usage:
            try {
              await WhatsAppLauncher.openChat(
                phone: '+9779869502131',
                message: 'Hello, I need assistance',
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(e.toString())),
              );
            }
          },),
      ),
    );
  }


}
