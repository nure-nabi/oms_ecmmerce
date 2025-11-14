import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/component/loading_overlay.dart';
import 'package:oms_ecommerce/core/constant/colors_constant.dart';
import 'package:oms_ecommerce/screen/wish_list/bloc/wishlist_bloc.dart';
import 'package:oms_ecommerce/screen/wish_list/bloc/wishlist_event.dart';
import 'package:oms_ecommerce/screen/wish_list/bloc/wishlist_state.dart';
import 'package:oms_ecommerce/storage/hive_storage.dart';
import 'package:shimmer/shimmer.dart';

import '../cart/bloc/add_cart/add_cart_bloc.dart';
import '../cart/bloc/add_cart/add_cart_event.dart';
import '../cart/bloc/add_cart/add_cart_state.dart';
import '../cart/bloc/cart_bloc.dart';
import '../cart/bloc/cart_event.dart';
import '../cart/cart.dart';
import '../widget/app_bar.dart';

class WishListPage extends StatefulWidget {
  bool leading;
   WishListPage({super.key, this.leading=false});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {

  @override
  void initState() {
    context.read<WishlistBloc>().add(WishlistReqEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
     // backgroundColor: Color(0xffEBF0F1),
      appBar: AppBarShow(
        leadingFlag: widget.leading,
       // backgroundColor: gPrimaryColor,
        leading:widget.leading ? InkWell(
            onTap: ()=>Navigator.pop(context),
            child: Icon(Bootstrap.chevron_left)):null,
        title: "Wishlist",
        onCartPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CartPage(
                    leading: true,
                  )));
        },
      ),
      body: Padding(
        //  CustomToast.showCustomRoast(context: context, message: "Please login", icon: Bootstrap.check_circle,iconColor: Colors.red);
        padding: EdgeInsets.only(left: 5,right: 5),
        child:  BlocBuilder<WishlistBloc,WishlistState>(builder: (BuildContext context, state) {
          if(state is WishlistLoadingState){
            return Align(
              alignment: Alignment.center,
              child: Container(
                height: 40,
                width: 40,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
            );
          }else if(state is WishlistLoadedState){
            return state.response.wishlist.isNotEmpty ? ListView.builder(
              itemCount: state.response.wishlist.length,
              itemBuilder: (context, index) {
                var info =state.response.wishlist[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0), // Adjust the radius as needed
                  ),
                  elevation: 0,
                  child: Container(
                  //  height: 125,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: CachedNetworkImage(
                                imageUrl: info.productModel!.main_image_full_url! != "" ? info.productModel!.main_image_full_url!
                                    : info.productModel!.image_full_url! != "" ? info.productModel!.image_full_url!
                                    : "https://iiserbpr.ac.in/imges/people/imges/noimage.png",
                                width: 70,
                                height: 50,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Container(),
                                errorWidget: (context, url, error) =>
                                    Icon(Bootstrap.image),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                                flex:4,
                                child: Container(
                                //  color: Colors.red,
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(info.productModel!.product_name!,maxLines: 2,overflow: TextOverflow.ellipsis,style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                      )),
                                      SizedBox(height: 5,),
                                      Text(info.productModel!.sell_price!,style: GoogleFonts.poppins(

                                      ),)

                                    ],
                                  ),
                                )
                            ),
                            Expanded(
                                flex:1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    InkWell(
                                        onTap:() {
                                         // context.read<WishlistBloc>().add(WishlistReqEvent());
                                          LoadingOverlay.show(context);
                                          context.read<WishlistBloc>().add(WishlistRemovedEvent(
                                              item_code: info.id!.toString(),product_code:info.product_code,context: context));
                                        },
                                        child: Icon(Bootstrap.trash,color: Colors.red,))
                                  ],
                                )
                            ),
                          ],
                        ),
                        if(int.parse(info.productModel!.stock_quantity!) > 0)...[
                          Row(
                            children: [
                              Spacer(),
                              InkWell(
                                onTap: (){
                                  LoadingOverlay.show(context);
                                  BlocProvider.of<AddCartBloc>(context).add(
                                    AddCartReqEvent(
                                        productCode: info.product_code,
                                        price: info.productModel!.sell_price!,
                                        quantity: "1",
                                        context: context
                                    ),
                                  );
                                  // Listen for state changes and then dispatch the cart event
                                  BlocProvider.of<AddCartBloc>(context).stream.firstWhere((state) {
                                    // Define your condition for when the operation is complete
                                    return state is AddCartLoadedState; // or whatever your success state is
                                  }).then((_) {
                                    context.read<CartBloc>().add(CartReqEvent(count:0,checkedCart:false));
                                    context.read<WishlistBloc>().add(WishlistReqEvent());
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3), // Grey shadow
                                        spreadRadius: 2, // How far the shadow spreads
                                        blurRadius: 3, // How soft the shadow is
                                        offset: const Offset(0, 2), // Shadow position (x,y)
                                      ),
                                    ],
                                  ),
                                  child: Icon(Bootstrap.cart_plus,color: gPrimaryColor,size: 18,),
                                ),
                              )

                            ],
                          )
                        ]else...[
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text("Out of stock",style: GoogleFonts.poppins(
                              color: Colors.red
                            ),),
                          )
                        ]

                      ],
                    ),
                  ),
                );
              },
            ) : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Icon(Bootstrap.heart, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 20),
                  const Text(
                    'Oops!! Your wishlist is empty.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Let\'s do some shopping and fill it up.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Divider(thickness: 1),

                ],
              ),
            );
          }else if(state is WishlistErrorState){
            return Center(child: Text("You are not logedin!",style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600
            ),),);
          } else{
            return SizedBox.shrink();
          }
        },),
      ),

    );
  }
}
