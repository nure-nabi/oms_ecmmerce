import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/core/constant/colors_constant.dart';
import 'package:oms_ecommerce/screen/address/bloc/address_bloc.dart';
import 'package:oms_ecommerce/screen/address/bloc/address_event.dart';
import 'package:oms_ecommerce/screen/address/bloc/address_state.dart';
import 'package:oms_ecommerce/screen/order/bloc/order_bloc.dart';
import 'package:oms_ecommerce/screen/order/bloc/order_event.dart';
import 'package:oms_ecommerce/screen/order/bloc/order_state.dart';
import 'package:oms_ecommerce/screen/profile/block/profile_bloc/profile_state.dart';

import '../../component/loading_overlay.dart';
import '../../constant/asstes_list.dart';
import '../../core/constant/textstyle.dart';
import '../../core/services/routeHelper/route_name.dart';
import '../../payment/handle_order.dart';
import '../../utils/custome_toast.dart';
import '../profile/block/profile_bloc/profile_bloc.dart';
import '../profile/block/profile_bloc/profile_event.dart';
import '../widget/text_field_decoration.dart';

class OrderDetails extends StatefulWidget {
  String productCode;
  String productName;
  String productImage;
  String productQuantity;
  String productPrice;
  String shipping_cost;

  OrderDetails({
    super.key,
    required this.productCode,
    required this.productName,
    required this.productImage,
    required this.productQuantity,
    required this.productPrice,
    required this.shipping_cost,
  });

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  TextEditingController emailController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  int selectedValue = 0;
  int selectedConnectIps = 0;
  int billingId = 0;
  int shoppingId = 0;
  double shoppingCost = 0;
  int count = 1;

  double subTotal = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<AddressBloc>().add(AddressReqEvent());
      context.read<OrderBloc>().add(OrderCartEvent(count: int.parse(widget.productQuantity),
          productPrice: double.parse(widget.productPrice)));
      BlocProvider.of<ProfileBloc>(context).add(ProfileReqEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:  Text("Order Summary",style: GoogleFonts.poppins(
            letterSpacing: 1
          ),),
         // backgroundColor: gPrimaryColor,
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Bootstrap.chevron_left,
              )),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
      
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
                return ListView.builder(
                       physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.addressResponseModel!.addresses!.length,
                        itemBuilder: (context, index) {
                          bool isAlternate = index % 2 == 0;
                          if (state.addressResponseModel!.addresses![index].default_shipping == 'Y') {
                            shoppingId =  state.addressResponseModel!.addresses![index].id!;
                            shoppingCost = double.parse(state.addressResponseModel!.addresses![index].city!.shipping_cost!);
                         //   Fluttertoast.showToast(msg: shoppingCost.toString());
                          }
                          if (state.addressResponseModel!.addresses![index].default_billing == 'Y') billingId = state.addressResponseModel!.addresses![index].id!;
                          return Container(
                        //    color: index == 1 ? Colors.white : Colors.white60,
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
                                                 //   color: gPrimaryColor,
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
                                                    //  color: gPrimaryColor,
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
                                                //  color: gPrimaryColor,
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
                                                      //color: gPrimaryColor,
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
                    );

                  } else {
                    return Container();
                  }
                },
              ),
              //details
              SizedBox(
                height: 10,
              ),
              BlocBuilder<OrderBloc,OrderState>(builder: (BuildContext context, OrderState state) {
                if(state is OrderLoadedState){
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(child: ClipRRect(
                                child: CachedNetworkImage(
                                  imageUrl: widget.productImage,
                                  width: 70,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(AssetsList.gargImage),
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
                                        widget.productName,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        'Rs. ${widget.productPrice}',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        'Qty ${state.count.toString()}',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500),
                                      ),

                                      Row(
                                        children: [
                                          const Expanded(child: SizedBox.shrink()),
                                          Expanded(child:
                                          Row(
                                            // crossAxisAlignment: CrossAxisAlignment.,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                  onTap: (){
                                                    LoadingOverlay.show(context);
                                                    count = state.count!;
                                                    if(count == 1){
                                                      count = 1;
                                                    }else{
                                                      count--;
                                                    }
                                                    context.read<OrderBloc>().add(OrderCartEvent(
                                                        count: count,
                                                        productPrice: double.parse(widget.productPrice) * count,
                                                      qtyUpdate: "Update"
                                                    ));
                                                  },
                                                  child: Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: BoxDecoration(
                                                          color: Colors.orange,
                                                          borderRadius: BorderRadius.all(Radius.circular(50))
                                                      ),
                                                      child: const Icon(Bootstrap.dash,color: Colors.white,))),
                                              const SizedBox(width: 5,),
                                              //Text(state.count.toString() =="0" ? info.quantity.toString() : state.count.toString()),
                                              Text(state.count.toString()),
                                              const SizedBox(width: 5,),
                                              InkWell(
                                                  onTap: (){
                                                    LoadingOverlay.show(context);
                                                    count = state.count!;
                                                    count++;
                                                    //count
                                                    context.read<OrderBloc>().add(OrderCartEvent(count:
                                                    count,productPrice: (double.parse(widget.productPrice) * count),qtyUpdate: "Update"));
                                                  },
                                                  child: Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: BoxDecoration(
                                                          color: Colors.orange,
                                                          borderRadius: BorderRadius.all(Radius.circular(50))
                                                      ),
                                                      child: const Icon(Bootstrap.plus,color: Colors.white))),

                                              const SizedBox(width:5,),
                                            ],
                                          ))
                                        ],
                                      )



                                    ]
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }else{
                  return Container();
                }
              },),

              SizedBox(
                height: 10,
              ),
              //subtotla
              BlocConsumer<OrderBloc,OrderState>(builder: (BuildContext context, state) {
                if(state is OrderLoadedState)
                {
                  return  Padding(
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
                                    "SubTotal(1 item)",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(),
                                  ),
                                  Text(
                                    //'Rs.${double.parse(widget.productPrice) * double.parse(widget.productQuantity)}',
                                    'Rs.${state.subTotal}',
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
                                  Text(widget.shipping_cost,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }else{
                  return Container();
                }
              }
                , listener: (BuildContext context, state) {

                if(state is OrderLoadedState){
                  subTotal = state.subTotal! + double.parse(widget.shipping_cost);
                }
                },),
      
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
                        onTap: () {
                          setState(() {
                            if (selectedConnectIps == 0) {
                              selectedConnectIps = 5;
                              selectedValue = 0;
                            } else if (selectedConnectIps == 5) {
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
      
                BlocBuilder<OrderBloc,OrderState>(builder: (BuildContext context, state) {
                  if(state is OrderLoadedState){
                    return Column(
                      children: [
                        RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Total: ',
                                  style: GoogleFonts.poppins(
                                  //  color: Colors.black,
                                    fontSize: 16,
                                  )),
                              TextSpan(
                                  text:
                                  'Rs.${state.subTotal! + shoppingCost}',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                     color: Colors.black
                                     // color: gPrimaryColor
                                  ))
                            ])),
                        Text(
                          "All taxes included",
                          style: GoogleFonts.poppins(color: Colors.grey),
                        )
                      ],
                    );
                  }else{
                    return Container();
                  }
                },),
      
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, bottom: 8, top: 10),
              child: InkWell(
                onTap: () {
                  if (selectedValue > 0 || selectedConnectIps > 0) {
                    if( emailController.text.isNotEmpty){

                      if(selectedConnectIps == 5){
                        LoadingOverlay.show(context);
                        handleConfirmOrderIPS(
                            payment_method: selectedConnectIps == 5 ? "IPS" : "c",
                            billing_address: billingId.toString(),
                            shipping_address: shoppingId.toString(),
                            invoice_email: emailController.text.trim(),
                            product_code: widget.productCode,
                            quantity: count.toString(),
                            totalAmount: subTotal,
                            context: context
                        );
                      }else{
                        LoadingOverlay.show(context);
                        context.read<OrderBloc>().add(OrderReqEvent(
                            payment_method: selectedValue > 0 ? "C" : "IPS",
                            billing_address: billingId.toString(),
                            shipping_address: shoppingId.toString(),
                            invoice_email: emailController.text.trim(),
                            product_code: widget.productCode,
                            quantity: count.toString(),
                            context: context
                        ));
                      }


                    }else{
                      CustomToast.showCustomRoast(context: context, message: "Please select invoice email", icon: Bootstrap.check_circle,iconColor: Colors.red);
                    }
                  } else  {
                    CustomToast.showCustomRoast(context: context, message: "Please select payment type", icon: Bootstrap.check_circle,iconColor: Colors.red);
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
