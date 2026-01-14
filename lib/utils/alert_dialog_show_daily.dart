import 'package:cached_network_image/cached_network_image.dart';
import 'package:connect_ips_flutter/connect_ips_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../core/constant/textstyle.dart';
import '../screen/profile/block/profile_bloc/profile_bloc.dart';
import '../screen/profile/block/profile_bloc/profile_event.dart';
import '../screen/profile/block/profile_bloc/profile_state.dart';
import '../screen/widget/text_field_decoration.dart';
import '../storage/hive_storage.dart';

void showFlashSaleAlert(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: _buildFlashSaleContent(context),
      ),
    ),
  );
}

Widget _buildFlashSaleContent(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      // Flash Sale Header HiveStorage.get(UserKey.offerImage.name)
      //Image.network("https://garg.omsok.com/storage/app/public/backend/productimages/A100001/fleximeter_strips_blue.jpeg",width: MediaQuery.of(context).size.width,)
      Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
            ),
            child: ClipRRect(
                borderRadius:BorderRadius.all(Radius.circular(5)),
                child:
                CachedNetworkImage(
                  imageUrl: HiveStorage.get(UserKey.offerImage.name),
                  //imageUrl: info.image_full_url!,
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  fit: BoxFit.fill,
                  placeholder: (context, url) =>
                      Container(),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error),
                )),
          ),
          Positioned(
            left: 10,
              top: 10,
              child: InkWell(
                onTap: ()=> Navigator.pop(context),
                  child: Icon(FontAwesome.circle_xmark,color: Colors.black,)))
        ],
      ),

      const SizedBox(height: 20),



      // Close Button
      SizedBox(

        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent, // Fill color
            foregroundColor: Colors.white, // Text color
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            side: const BorderSide(
              color: Colors.white, // Border color
              width: 1.0, // Border thickness
            ),
          ),
          child: const Text('CLOSE'),
        ),
      ),
    ],
  );
}


void showDeleteAccountAlert(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
     // backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: _accountDelete(context),
      ),
    ),
  );
}
//
Widget _accountDelete(BuildContext context){
  final _globalKey = GlobalKey<FormState>();
  final _deleteEditController = TextEditingController();
  return BlocConsumer<ProfileBloc, ProfileState>(builder: (BuildContext context, state) {
    if(state is ProfileLoadedState){
      return Form(
        key: _globalKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(child:
                  Row(
                    children: [
                      Icon(Bootstrap.exclamation_triangle,size: 20 ,color: Colors.red,),
                      SizedBox(width: 10,),
                      Text("Remove Account",style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold
                      ),)
                    ],)),
                  InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Bootstrap.x,size: 25,)),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red.shade100
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child:
                        Row(
                          children: [
                            Icon(Bootstrap.trash,color: Colors.red,size: 20,),
                            SizedBox(width: 5,),
                            Expanded(
                              child: Text("Warning: This action cannot be undone",
                                maxLines: 2,overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                    color: Colors.red.shade500,
                                    fontSize: 13
                                ),),
                            )
                          ],)),
                      ],
                    ),
                    Text("- Your account will be permanently deleted",
                        style: GoogleFonts.poppins( fontSize: 13)),
                    SizedBox(height: 5,),
                    Text("- All your data will be lost",
                        style: GoogleFonts.poppins( fontSize: 13)),
                    SizedBox(height: 5,),
                    Text("- This action is irreversible",
                        style: GoogleFonts.poppins( fontSize: 13)),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              RichText(
                text: TextSpan(
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black, // optional
                    ),
                    children: [
                      TextSpan(
                          text: 'To Confirm that you want to delete your account,',
                          style: GoogleFonts.poppins(
                              fontSize: 12
                          )
                      ),
                      TextSpan(
                          text: ' please type ',
                          style: GoogleFonts.poppins(
                            fontSize: 12,

                          )
                      ),
                      TextSpan(
                          text: 'DELETE ',
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      TextSpan(
                          text: 'in the field below:',
                          style: GoogleFonts.poppins(
                              fontSize: 12
                          )
                      ),
                    ]

                ),

              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _deleteEditController,
                onChanged: (value) {},
                decoration: TextFormDecoration.decoration(
                  hintText: "DELETE",
                  hintStyle: hintTextStyle,
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.grey.shade400, // text color
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.white, width: 1), // border
                          ),
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 10,),
                      TextButton(
                        onPressed: () {
                          if(_deleteEditController.isNotEmpty  || _deleteEditController.text.trim() == "DELETE"){
                            BlocProvider.of<ProfileBloc>(context).add(AccountRemovedEvent(context:context));
                          }else{
                            Fluttertoast.showToast(msg: "Please type DELETE in the field");
                          }
                          // Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red, // text color
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.white, width: 1), // border
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Bootstrap.trash,size: 15,),
                            SizedBox(width: 5,),
                            const Text(
                              "Remove Account",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )

                    ],
                  )
                ],
              )
            ],
          )
      );
    }else{
      return Text("");
    }
  }
    , listener: (BuildContext context, state) {  },);
}