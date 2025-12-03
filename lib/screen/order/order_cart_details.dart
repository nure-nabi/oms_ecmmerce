

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/core/constant/colors_constant.dart';
import 'package:oms_ecommerce/core/services/routeHelper/route_name.dart';
import 'package:oms_ecommerce/screen/address/bloc/address_bloc.dart';
import 'package:oms_ecommerce/screen/address/bloc/address_event.dart';
import 'package:oms_ecommerce/screen/address/bloc/address_state.dart';
import 'package:oms_ecommerce/screen/order/bloc/order_bloc.dart';
import 'package:oms_ecommerce/screen/order/bloc/order_event.dart';
import 'package:oms_ecommerce/screen/order/bloc/order_state.dart';

import '../../component/loading_overlay.dart';
import '../../core/constant/textstyle.dart';
import '../../payment/handle_order.dart';
import '../address/model/address_model.dart';
import '../cart/bloc/cart_bloc.dart';
import '../cart/bloc/cart_event.dart';
import '../cart/model/cart_model.dart';
import '../profile/block/profile_bloc/profile_bloc.dart';
import '../profile/block/profile_bloc/profile_event.dart';
import '../profile/block/profile_bloc/profile_state.dart';
import '../widget/text_field_decoration.dart';

class OrderCartDetails extends StatefulWidget {
  List<String>? checkedValue;
  List<CartProductModel>? tempCartList;
  String? shipping_cost;
  AddressResponseModel addressResponseModel;


  OrderCartDetails({
    super.key,
    required this.checkedValue,
    required this.tempCartList,
    required this.addressResponseModel,  this.shipping_cost
  });

  @override
  State<OrderCartDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderCartDetails> {
  TextEditingController emailController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  int selectedValue = 0;
  int selectedConnectIps = 0;
  int billingId = 0;
  int shoppingId = 0;
  double shoppingCost = 0;
  int count = 1;

  double subTotal = 0.0;


  @override
  void initState() {
   // context.read<AddressBloc>().add(AddressReqEvent());
    BlocProvider.of<ProfileBloc>(context).add(ProfileReqEvent());
    subTotalShow();
    super.initState();
  }

  subTotalShow(){
    for(var v in widget.tempCartList!){
      subTotal += double.parse(v.sell_price!) * int.parse(v.quantity!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:  Text("Order Summary",style: GoogleFonts.poppins(
              letterSpacing: 1
          ),),
          //backgroundColor: primaryColor,
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Bootstrap.chevron_left,
              )),
        ),
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              //Profile
              //Profile
              BlocBuilder<ProfileBloc,ProfileState>(builder: (BuildContext context, state) {
                if(state is ProfileLoadedState){
                  WidgetsBinding.instance.addPostFrameCallback((_){
                    emailController.text = state.userInfoResMode!.user!.email!;
                  });
                }
                return SizedBox.shrink();
              },),
              // BlocConsumer<ProfileBloc,ProfileState>(builder: (BuildContext context, state) {
              //   return SizedBox.shrink();
              // },
              //   listener: (BuildContext context, state) {
              //     if(state is ProfileLoadedState){
              //         emailController.text = state.userInfoResMode!.user!.email!;
              //     }
              //   },),
              //Address
              BlocBuilder<AddressBloc, AddressState>(
                builder: (BuildContext context, state) {
                  if (state is AddressLoadedState) {
                return  Column(
                  children: [
                    ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.addressResponseModel!.addresses!.length,
                            itemBuilder: (context, index) {
                              bool isAlternate = index % 2 == 0;
                              if (state.addressResponseModel!.addresses![index]
                                  .default_shipping ==
                                  'Y') {
                                shoppingId =
                                state.addressResponseModel!.addresses![index].id!;
                                shoppingCost = double.parse(state.addressResponseModel!.addresses![index].city!.shipping_cost!);
                              }
                              if (state.addressResponseModel!.addresses![index]
                                  .default_billing ==
                                  'Y')
                                billingId =
                                state.addressResponseModel!.addresses![index].id!;
                              return Container(
                                color: index == 1 ? Colors.white : Colors.white60,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    if (state.addressResponseModel!.addresses![index].default_shipping == 'Y')
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    "Shipping Address",
                                                    textAlign: TextAlign.start,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 15,
                                                        color: gPrimaryColor,
                                                        fontWeight: FontWeight.w600),
                                                  ),
                                                  InkWell(
                                                    onTap: ()=> Navigator.pushNamed(context,addressShow),
                                                    child: Container(
                                                      padding: EdgeInsets.only(left: 10,right: 10,bottom: 3,top: 3),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(width: 1,color: gPrimaryColor),
                                                        borderRadius: BorderRadius.all(Radius.circular(5))
                                                      ),
                                                      child: Text("Change",style: GoogleFonts.poppins(
                                                        color: gPrimaryColor,
                                                        fontSize: 16
                                                      ),),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Text(
                                              state.addressResponseModel!
                                                  .addresses![index].full_name!,
                                              style: GoogleFonts.poppins(
                                                  color: Colors.grey),
                                            ),
                                            Text(
                                              state.addressResponseModel!
                                                  .addresses![index].address!,
                                              style: GoogleFonts.poppins(
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (state.addressResponseModel!.addresses![index].default_billing == 'Y')
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    "Billing Address",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 15,
                                                      color: gPrimaryColor,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: ()=> Navigator.pushNamed(context,addressShow),
                                                    child: Container(
                                                      padding: EdgeInsets.only(left: 10,right: 10,bottom: 3,top: 3),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(width: 1,color: gPrimaryColor),
                                                          borderRadius: BorderRadius.all(Radius.circular(5))
                                                      ),
                                                      child: Text("Change",style: GoogleFonts.poppins(
                                                          color: gPrimaryColor,
                                                          fontSize: 16
                                                      ),),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                state.addressResponseModel!.addresses![index].full_name!,
                                                style: GoogleFonts.poppins(color: Colors.grey),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                state.addressResponseModel!.addresses![index].address!,
                                                style: GoogleFonts.poppins(color: Colors.grey),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            }
                        ),
      
                  ],
                );
      
                    // return GridView.builder(
                    //     itemCount: state.addressResponseModel!.addresses!.length,
                    //     physics: NeverScrollableScrollPhysics(),
                    //     shrinkWrap: true,
                    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //         crossAxisCount: 2,
                    //         crossAxisSpacing: 2,
                    //         mainAxisSpacing: 2,
                    //         childAspectRatio: 1.5),
                    //     itemBuilder: (context, index) {
                    //       bool isAlternate = index % 2 == 0;
                    //       if (state.addressResponseModel!.addresses![index]
                    //               .default_shipping ==
                    //           'Y') {
                    //         shoppingId =
                    //             state.addressResponseModel!.addresses![index].id!;
                    //         shoppingCost = double.parse(state
                    //             .addressResponseModel!
                    //             .addresses![index]
                    //             .city!
                    //             .shipping_cost!);
                    //       }
                    //       if (state.addressResponseModel!.addresses![index]
                    //               .default_billing ==
                    //           'Y')
                    //         billingId =
                    //             state.addressResponseModel!.addresses![index].id!;
                    //       return Container(
                    //         color: index == 1 ? Colors.white : Colors.white60,
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             if (state.addressResponseModel!.addresses![index]
                    //                     .default_shipping ==
                    //                 'Y')
                    //               Column(
                    //                 crossAxisAlignment: CrossAxisAlignment.start,
                    //                 children: [
                    //                   Text(
                    //                     "Shipping Address",
                    //                     style: GoogleFonts.poppins(
                    //                         fontSize: 15,
                    //                         fontWeight: FontWeight.w600),
                    //                   ),
                    //                   Text(
                    //                     state.addressResponseModel!
                    //                         .addresses![index].full_name!,
                    //                     style: GoogleFonts.poppins(
                    //                         color: Colors.grey),
                    //                   ),
                    //                   Text(
                    //                     state.addressResponseModel!
                    //                         .addresses![index].address!,
                    //                     style: GoogleFonts.poppins(
                    //                         color: Colors.grey),
                    //                   ),
                    //                 ],
                    //               ),
                    //             if (state.addressResponseModel!.addresses![index]
                    //                     .default_billing ==
                    //                 'Y')
                    //               Column(
                    //                 crossAxisAlignment: CrossAxisAlignment.start,
                    //                 children: [
                    //                   Text(
                    //                     "Billing Address",
                    //                     style: GoogleFonts.poppins(
                    //                         fontSize: 15,
                    //                         fontWeight: FontWeight.w600),
                    //                   ),
                    //                   Text(
                    //                     state.addressResponseModel!
                    //                         .addresses![index].full_name!,
                    //                     style: GoogleFonts.poppins(
                    //                         color: Colors.grey),
                    //                   ),
                    //                   Text(
                    //                     state.addressResponseModel!
                    //                         .addresses![index].address!,
                    //                     style: GoogleFonts.poppins(
                    //                         color: Colors.grey),
                    //                   ),
                    //                 ],
                    //               ),
                    //           ],
                    //         ),
                    //       );
                    //     }
                    //     );
                  } else {
                    return Container();
                  }
                },
              ),
              //details
              SizedBox(
                height: 10,
              ),
              //likt product
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.tempCartList!.length,
                  itemBuilder: (context, index){
                  var info = widget.tempCartList![index];
                    return   Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(child: ClipRRect(
                                  child: CachedNetworkImage(
                                    imageUrl: info.image_full_url!,
                                    width: 70,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        info.product_name!,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        'Rs. ${info.sell_price!}',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        'Qty ${info.quantity!}',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500),
                                      ),
      
      
      
                                    ]
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              ),
      
              SizedBox(
                height: 10,
              ),
              //subtotla
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Card(
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "SubTotal(${widget.tempCartList!.length} item)",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(),
                              ),
                              Text(
                                'Rs.${subTotal}',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Shipping Fee SubTotal",
                                style: GoogleFonts.poppins(),
                              ),
                             // Text(shoppingCost.toStringAsFixed(2),
                              Text(widget.shipping_cost!,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      // ------------------ CASH ON DELIVERY ------------------
                      Expanded(
                        flex: 1,
                        child: RadioListTile<int>(
                          title: const Text("Cash on delivery"),
                          value: 1,
                          groupValue: selectedValue,
                          activeColor: gPrimaryColor,
                          onChanged: (int? value) {
                            setState(() {
                              selectedValue = value!;
                              selectedConnectIps = 0;
                            });
                          },
                        ),
                      ),

                      // ------------------ CONNECT IPS ------------------
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              if(selectedConnectIps == 0){
                                selectedConnectIps = 5;
                                selectedValue = 0;
                              }else if(selectedConnectIps == 5){
                                selectedConnectIps = 0;
                              }
                            });
                          },
                          child: Container(
                            //width: MediaQuery.of(context).size.width,

                            decoration: BoxDecoration(
                              color: selectedConnectIps == 5 ? Colors.white : Colors.white,
                              border: Border.all( color: selectedConnectIps == 5 ? Colors.orange : Colors.white,)
                            ),
                            child: Image.asset(
                              'assets/images/connect_ips.png',
                              height: 60,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),


              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  bottomSheetShow();
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 20, top: 10, bottom: 30),
                    child: Row(
                      children: [
                        Icon(
                          Bootstrap.receipt,
                          size: 15,
                          color: gPrimaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Invoice and Contact Info",
                          style: GoogleFonts.poppins(),
                        ),
                        Spacer(),
                        Icon(
                          Bootstrap.chevron_right,
                          size: 15,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
      
                Column(
                  children: [
                    RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'Total: ',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 16,
                              )),
                          TextSpan(
                              text:
                              'Rs.${subTotal! + shoppingCost}',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                  color: gPrimaryColor))
                        ])),
                    Text(
                      "All taxes included",
                      style: GoogleFonts.poppins(color: Colors.grey),
                    )
                  ],
                )
      
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, bottom: 8, top: 10),
              child: InkWell(
                onTap: () {
                  if (selectedValue > 0 || selectedConnectIps > 0) {
                    if( emailController.text.isNotEmpty) {
                      if(selectedConnectIps == 5){
                        LoadingOverlay.show(context);
                        handleConfirmOrderIPS(
                            payment_method: selectedConnectIps == 5 ? "IPS" : "c",
                            billing_address: billingId.toString(),
                            shipping_address: shoppingId.toString(),
                            invoice_email: emailController.text.trim(),
                            selected_items:  widget.checkedValue,
                            totalAmount:(subTotal! + shoppingCost),
                            context: context
                        );
                      }else{
                      LoadingOverlay.show(context);
                      context.read<CartBloc>().add(CartItemsBuyEvent(
                          payment_method: selectedValue > 0 ? "C" : "IPS",
                          billing_address: billingId.toString(),
                          shipping_address: shoppingId.toString(),
                          invoice_email: emailController.text.trim(),
                          selected_items: widget.checkedValue,
                          context: context));
                    }
                    }else{
                      Fluttertoast.showToast(
                          msg: "Please select invoice email");
                    }
      
                  } else  {
                    Fluttertoast.showToast(
                        msg: "Please select payment type ");
                  }
                },
                child: Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: Color(0xff003466),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                    child: Text(
                      "Place Order",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future bottomSheetShow() {
    return showModalBottomSheet(
        //  isScrollControlled: false, // Allows full-screen expansion if needed
        //  backgroundColor: Colors.transparent, // Removes default background
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        "Invoice and Contact info",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, fontSize: 23),
                      ),
                      Spacer(),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Bootstrap.x))
                    ],
                  ),
                  //
                  SizedBox(
                    height: 50,
                  ),

                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "* ",
                        style: GoogleFonts.poppins(color: Colors.red)),
                    TextSpan(
                        text: "Email",
                        style: GoogleFonts.poppins(color: Colors.black))
                  ])),

                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: emailController,
                    onChanged: (value) {
                      if (value.isEmpty) {}
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter recipient email';
                      }
                      return null;
                    },
                    decoration: TextFormDecoration.decoration(
                      hintText: "Email",
                      hintStyle: hintTextStyle,
                      prefixIcon: Icons.person,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 8, top: 10),
                    child: InkWell(
                      onTap: () {
                        if (_globalKey.currentState!.validate()) {
                         // emailController.text = "";
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        height: 50,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            color: Color(0xff003466),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Center(
                          child: Text(
                            "Confirm",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
