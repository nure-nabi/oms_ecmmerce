import 'dart:convert';
import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/component/loading_overlay.dart';
import 'package:oms_ecommerce/core/services/routeHelper/route_name.dart';
import 'package:oms_ecommerce/screen/profile/block/image_picker_block/image_picker_event.dart';
import 'package:oms_ecommerce/screen/profile/block/image_picker_block/image_picker_state.dart';
import 'package:oms_ecommerce/screen/profile/block/profile_bloc/profile_bloc.dart';
import 'package:oms_ecommerce/screen/profile/block/profile_bloc/profile_event.dart';
import 'package:oms_ecommerce/screen/profile/block/profile_bloc/profile_state.dart';
import 'package:oms_ecommerce/screen/profile/block/profile_edit/edit_profile_bloc.dart';
import 'package:oms_ecommerce/screen/profile/block/profile_edit/edit_profile_event.dart';
import 'package:oms_ecommerce/screen/profile/block/profile_edit/edit_profile_state.dart';
import 'package:oms_ecommerce/storage/hive_storage.dart';
import 'package:oms_ecommerce/utils/image_picker_utils.dart';

import '../../core/constant/colors_constant.dart';
import '../../core/constant/textstyle.dart';
import '../../utils/custome_toast.dart';
import '../widget/text_field_decoration.dart';
import 'block/image_picker_block/image_picker_block.dart';

import 'package:flutter/services.dart';

class EditProfile extends StatefulWidget {
  final String title;

  const  EditProfile({super.key, required this.title});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool isEmpty = false;

  String base64Image = "";
  String filePath = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Color(0xfff5fdff),
      appBar: AppBar(
        automaticallyImplyLeading: false,
      //  backgroundColor: gPrimaryColor,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Bootstrap.chevron_left,size: 20,)),
        elevation: 0,
        title: Text(widget.title),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (BuildContext context, state) {
          if (state is ProfileLoadedState) {
            fullNameController.text = state.userInfoResMode!.user!.full_name!.trim();
            phoneController.text = state.userInfoResMode!.user!.phone!.trim();
            emailController.text = state.userInfoResMode!.user!.email!.trim();
            String imagePath = state.userInfoResMode!.user!.image_full_url!;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    _buildProfileImageSection(context,imagePath),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: fullNameController,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          isEmpty = true;
                          Fluttertoast.showToast(msg: isEmpty.toString());
                          // context.read<ProfileBloc>().add(ProfileReqEvent());
                        }
                      },
                      decoration: TextFormDecoration.decoration(
                        hintText: "Full Name",
                        hintStyle: hintTextStyle,
                        prefixIcon: Icons.person,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: phoneController,
                      onChanged: (value) {},
                      decoration: TextFormDecoration.decoration(
                        hintText: "Phone Number",
                        hintStyle: hintTextStyle,
                        prefixIcon: Icons.phone,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: emailController,
                      onChanged: (value) {},
                      decoration: TextFormDecoration.decoration(
                        hintText: "Email",
                        hintStyle: hintTextStyle,
                        prefixIcon: Icons.email,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                     // width: MediaQuery.of(context).size.width,
                      child: BlocConsumer<EditProfileBloc,EditProfileState>(
                        builder: (BuildContext context, state) {
                          if(state is EditProfileInitialState){
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:gPrimaryColor,
                                    padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 15), // Padding for the button itself
                                  ),
                                  onPressed: (){
                                  //  Fluttertoast.showToast(msg: "msg");
                                    LoadingOverlay.show(context);
                                   BlocProvider.of<EditProfileBloc>(context).add(EditProfileReqEvent(userName: fullNameController.text.trim(), phone: phoneController.text.trim(),image: filePath));
                                  }, child: Text("Update Profile",)),
                            );
                          } else  if(state is EditProfileLoadingState){
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:gPrimaryColor,
                                    padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 15), // Padding for the button itself
                                  ),
                                  onPressed: (){
                                    BlocProvider.of<EditProfileBloc>(context).add(EditProfileReqEvent(userName: fullNameController.text.trim(), phone: phoneController.text.trim(),image: filePath));
                                  }, child: Text("Update Profile",style: TextStyle(color: Colors.white))),
                            );
                          }else  if(state is EditProfileLoadedState){
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:gPrimaryColor,
                                    padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 15), // Padding for the button itself
                                  ),
                                  onPressed: (){
                                 //   BlocProvider.of<EditProfileBloc>(context).add(EditProfileReqEvent(userName: fullNameController.text.trim(), phone: phoneController.text.trim(),image: base64Image));
                                  }, child: Text("Update Profile",style: TextStyle(color: Colors.white) )),
                            );
                          }else{
                            return Container();
                          }
                        },

                        listener: (BuildContext context, Object? state) {
                          if(state is EditProfileLoadedState){
                            CustomToast.showCustomRoast(context: context!, message: "Profile updated successfully!",
                                icon: Bootstrap.check_circle,iconColor: Colors.green);
                            Navigator.pushReplacementNamed(context, homeNavbar,
                            arguments: 3);
                          }
                        },)
                    )
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  // Extracted widget for profile image section
  Widget _buildProfileImageSection(BuildContext context, String imagePath) {
    return BlocConsumer<ImagePickerBlock, ImagePickerState>(
      listener: (context, state) {
        if (state is ImagePickerLoadedState) {
        //  Fluttertoast.showToast(msg: state.file!.name);
        }
      },
      builder: (context, state) {
        // Determine which image to show
        Widget? imageWidget ;
        if(state is ImagePickerLoadedState){

          if(state.getPickedImage !=null){
            base64Image = state.getPickedImage!;
           // Fluttertoast.showToast(msg: state.getPickedImage!);
           filePath = state.file!.path;
            Uint8List bytes = base64Decode(state.getPickedImage!);
             imageWidget = CircleAvatar(
              radius: 50,
              backgroundImage: MemoryImage(bytes),
            );
          }else{
             if(imagePath.isNotEmpty){
               base64Image =  ImagePickerUtils().urlImageToBase64(imagePath);
             }

             imageWidget = CircleAvatar(
              radius: 50,
              backgroundImage: imagePath.isNotEmpty
                  ? NetworkImage(imagePath)
                  : const AssetImage("assets/images/pro1.jpg"),
            );
          }


        } else if(state is ImagePickerInitialState){
          imageWidget = CircleAvatar(
            radius: 50,
            backgroundImage: imagePath.isNotEmpty
                ? NetworkImage(imagePath)
                : const AssetImage("assets/images/pro1.jpg"),
          );
        }

        return Stack(
          children: [
            imageWidget!,
           Positioned(
             right: -10,
             bottom: -5,
             child:  IconButton(
             onPressed: () => context.read<ImagePickerBlock>().add(CameraCaptureEvent()),
             icon: const Icon(Bootstrap.camera, color: Colors.orange),
           ),)
          ],
        );
      },
    );
  }

}
