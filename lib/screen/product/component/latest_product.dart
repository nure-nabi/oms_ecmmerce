import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/component/loading_overlay.dart';
import 'package:oms_ecommerce/core/constant/colors_constant.dart';
import 'package:oms_ecommerce/screen/product/bloc/ProductLatestBloc.dart';
import 'package:oms_ecommerce/screen/product/bloc/ProductLatestEvent.dart';
import 'package:oms_ecommerce/screen/product/bloc/ProductLatestState.dart';
import 'package:oms_ecommerce/screen/product/product_list.dart';
import 'package:oms_ecommerce/screen/service/sharepref/get_all_pref.dart';
import 'package:oms_ecommerce/screen/wish_list/bloc/wishlist_bloc.dart';
import 'package:oms_ecommerce/screen/wish_list/bloc/wishlist_event.dart';
import 'package:oms_ecommerce/screen/wish_list/bloc/wishlist_state.dart';
import 'package:oms_ecommerce/storage/hive_storage.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constant/asstes_list.dart';
import '../../../theme/theme_data.dart';
import '../../../utils/check_network.dart';
import '../../cart/bloc/add_cart/add_cart_bloc.dart';
import '../../cart/bloc/add_cart/add_cart_event.dart';
import '../../cart/bloc/add_cart/add_cart_state.dart';
import '../../cart/bloc/cart_bloc.dart';
import '../../cart/bloc/cart_event.dart';
import '../../main/home_page.dart';
import '../../../utils/custome_toast.dart';
import '../bloc/product_bloc/product_list_bloc.dart';
import '../bloc/product_bloc/product_list_event.dart';
import '../product_details.dart';

class LatestProduct extends StatefulWidget {
  const LatestProduct({super.key});

  @override
  State<LatestProduct> createState() => _LatestProductState();
}

class _LatestProductState extends State<LatestProduct> {

  @override
  void initState() {
    BlocProvider.of<ProductLatestBloc>(context).add(ProductLatestReqEvent());
    context.read<WishlistBloc>().add(WishlistReqEvent());
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ProductLatestBloc, ProductLatestState>(
      builder: (BuildContext context, state) {
        if (state is ProductLatestLoadingState) {
          return  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 15,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
              SizedBox(height: 5,),

              SizedBox(
                height: 227,
                child: ListView.separated(
                  separatorBuilder: (context,index)=> SizedBox(width: 5,),
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, index) {

                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          height: 234,
                          width: 170,
                          padding: EdgeInsets.only(top: 5,left: 5,right: 5),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(5))),

                        ),
                      ),
                    );
                  },

                ),
              ),
              //New Arrival
              SizedBox(height: 5,),

            ],
          );
        }  if (state is ProductLatestLoadedState) {
          return state.latestProductResModel!.products.isNotEmpty ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Latest Products",
                      style: GoogleFonts.poppins(
                     //   color: Color(0xff003466),
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        CheckNetwork.check().then((network){
                          if(!network){
                            CustomToast.showCustomRoast(context:context, message: "No network found.", icon: Bootstrap.check_circle,iconColor: Colors.red);
                          }else{
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductListPage()));
                          }
                        });

                      },
                      child: Row(
                        children: [
                          Text("SHOW MORE",style: GoogleFonts.poppins(
                           // color: gPrimaryColor,
                            fontSize: 13
                          ),),
                          SizedBox(width: 4,),
                          Icon(Bootstrap.chevron_right,size: 13,color: gPrimaryColor,)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Stack(
                children: [
                  Container(
                    height: 230,
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                         decoration: BoxDecoration(
                         gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.red.shade700,  // Darker red at the top
                            Colors.black,  // Lighter red at the bottom
                          ],
                        ),
                         )),

                      ],
                    ),
                  ),
                  Positioned(
                    top: 5, // Position it below the red container
                    left: 0,
                    right: 0,
                    child:  SizedBox(
                    height: 227,
                    child: ListView.separated(
                      separatorBuilder: (context,index)=> SizedBox(width: 5,),
                      itemCount: state.latestProductResModel!.products.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, index) {
                        final info = state.latestProductResModel!.products[index];

                      //  Fluttertoast.showToast(msg: state.wishListFlag![index].toString());
                        return InkWell(
                          onTap: () {
                            CheckNetwork.check().then((network){
                              if(!network){
                                CustomToast.showCustomRoast(context:context, message: "No network found.", icon: Bootstrap.check_circle,iconColor: Colors.red);
                              }else{
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetails(
                                      productCode: info.product_code!,
                                      productName: info.product_name!,
                                      stock_quantity: info.stock_quantity,
                                      //sellingPrice: info.sell_price! != "" ? double.parse(info.sell_price!) : 0.00,
                                      sellingPrice: info.sell_price! != "" ? double.parse(info.sell_price!) : double.parse(info.starting_price!),
                                      productImage: info.image_full_url != "" ?  info.image_full_url: info.main_image_full_url,
                                      variation: info.has_variations,
                                    ),
                                  ),
                                );
                              }
                            });


                          },
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Container(
                              height: 234,
                              width: 170,
                              padding: EdgeInsets.only(top: 5,left: 5,right: 5),
                              decoration: const BoxDecoration(
                                 // color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(5),
                                          topLeft: Radius.circular(5),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: info.image_full_url != "" ? info.image_full_url!: info.main_image_full_url!,
                                          width: 170,
                                          height: 100,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => Container(),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(AssetsList.gargImage),
                                        ),
                                        // child: Image.network(
                                        //   info.image_full_url!,
                                        //   width: 200,
                                        //   height: 140,
                                        //   fit: BoxFit.cover,
                                        // ),
                                      ),
                                      Positioned(
                                          top: 5,
                                          right: 5,
                                          child: InkWell(
                                            onTap: ()async{
                                              if(await GetAllPref.loginSuccess()){

                                                if(!info.is_wishlisted!){
                                                  LoadingOverlay.show(context);
                                                  BlocProvider.of<WishlistBloc>(context).add(WishlistSaveEvent(
                                                      productCode: info.product_code!,context: context));
                                                  context.read<ProductLatestBloc>().add(ProductLatestWishListFlagReqEvent(
                                                      flag: true, index: index));

                                                }else{
                                                //  context.read<WishlistBloc>().add(WishlistReqEvent());
                                                  LoadingOverlay.show(context);
                                                  BlocProvider.of<WishlistBloc>(context).add(WishlistRemovedEvent(
                                                      item_code: info.product_code!,product_code: info.product_code!,context: context));
                                                  context.read<ProductLatestBloc>().add(ProductLatestWishListFlagReqEvent(
                                                      flag: false, index: index));
                                                }
                                              }else{
                                                CustomToast.showCustomRoast(context: context, message: "You are not login!", icon: Bootstrap.check_circle,iconColor: Colors.red);
                                              }

                                               },
                                            child: Icon(
                                              info.is_wishlisted!?
                                              Bootstrap.heart_fill : Bootstrap.heart_fill,
                                              size: 25,
                                              color:  info.is_wishlisted!? Colors.red.shade800 : Colors.grey.shade400,
                                            ),
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // Product list
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Column(
                                      children: [
                                        ProductItem(
                                          name: info.product_name!,
                                          brand: "No brand",
                                          price: info.sell_price! != "" ? info.sell_price! : info.starting_price!,
                                          productCode: info.product_code,
                                          review_count: info.review_count,
                                          average_rating: info.average_rating!,
                                          variation: info.has_variations!.toString(),
                                          stockQuantity: info.stock_quantity,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },

                      // GridView.builder(
                      //   padding: const EdgeInsets.symmetric(horizontal: 10), // Padding around the grid
                      //   shrinkWrap: true, // Useful inside ScrollViews
                      //   physics: NeverScrollableScrollPhysics(), // Disable scrolling if nested
                      //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      //       crossAxisCount: 2,
                      //       mainAxisSpacing: 2,
                      //       crossAxisSpacing: 2,
                      //       childAspectRatio: 0.68
                      //
                      //   ),
                      //   itemCount: state.latestProductResModel!.products.length, // Total number of items
                      //   itemBuilder: (BuildContext context, int index) {
                      //   final info = state.latestProductResModel!.products[index];
                      //     return InkWell(
                      //       onTap: (){
                      //         Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //             builder: (context) => ProductDetails(productCode: info.product_code!, productName: info.product_name!, sellingPrice: double.parse(info.sell_price!), productImage: info.image_full_url,),
                      //           ),
                      //         );
                      //       },
                      //       child: Card(
                      //         elevation: 2,
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(8),
                      //         ),
                      //         child: Container(
                      //           decoration:  const BoxDecoration(
                      //               color: Colors.white,
                      //               borderRadius: BorderRadius.all(Radius.circular(10))
                      //           ),
                      //           child: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //
                      //               Stack(
                      //                 children: [
                      //                   ClipRRect(
                      //                     borderRadius: const BorderRadius.only(
                      //                       topRight: Radius.circular(5),
                      //                       topLeft:  Radius.circular(5),
                      //                     ),
                      //                     child: CachedNetworkImage(
                      //                       imageUrl: info.image_full_url!,
                      //                          width: 200,
                      //                          height: 140,
                      //                         fit: BoxFit.cover,
                      //                       placeholder: (context, url) => Container(),
                      //                       errorWidget: (context, url, error) => Icon(Icons.error),
                      //                     ),
                      //                     // child: Image.network(
                      //                     //   info.image_full_url!,
                      //                     //   width: 200,
                      //                     //   height: 140,
                      //                     //   fit: BoxFit.cover,
                      //                     // ),
                      //                   ),
                      //                   Positioned(
                      //                       top: 5,
                      //                       right: 5,
                      //                       child: Container(
                      //                         height: 30,
                      //                         width: 30,
                      //                         padding: const EdgeInsets.all(7),
                      //                         decoration: BoxDecoration(
                      //                           borderRadius: BorderRadius.circular(100), // Fully circular
                      //                           color: gPrimaryColor,
                      //
                      //                         ),
                      //                         child: Icon(Bootstrap.heart,size: 15,color: Colors.white,),
                      //                       )),
                      //                 ],
                      //               ),
                      //               SizedBox(height: 10,),
                      //               // Product list
                      //                Padding(
                      //                 padding: EdgeInsets.symmetric(horizontal: 5.0),
                      //                 child: Column(
                      //                   children: [
                      //                     ProductItem(
                      //                       name:  info.product_name!,
                      //                       brand: "Product's brand",
                      //                       price:  info.sell_price!,
                      //                       productCode: info.product_code,
                      //                     ),
                      //
                      //                   ],
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
                    ),
                  ),)
                ],
              ),
              //New Arrival
              SizedBox(height: 5,),

            ],
          ) : SizedBox.shrink();
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  // Shimmer placeholder widget
  Widget _buildShimmerItem() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: const BoxDecoration(
            color: Color(0xffEDDFE2),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 200,
              height: 140,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 16,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: double.infinity,
                    height: 14,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 100,
                    height: 14,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final String name;
  final String brand;
  final String price;
  final String? productCode;
  final String? average_rating;
  final int? review_count;
  final String? variation;
  final int? stockQuantity;

  const ProductItem({
    super.key,
    required this.name,
    required this.brand,
    required this.price,
    this.productCode,
    this.average_rating,
    this.review_count,
    this.variation,
    this.stockQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            maxLines: 1,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600
            ),
          ),
        //  const SizedBox(height: 2),
          Text(brand, style: const TextStyle(overflow: TextOverflow.ellipsis, color: Colors.grey)),
          const SizedBox(height: 1),
          if(variation == "1")
            Text("Staring at",style: GoogleFonts.poppins(
             color: Colors.green.shade700
            ),),
          RichText(
            text: TextSpan(
              style: TextStyle( fontSize: 14),
              children: [
                TextSpan(
                    text: 'Rs ',
                    style:
                        GoogleFonts.poppins(
                            fontSize: 10,
                            color: lightColorScheme.primary
                        )),
                TextSpan(
                  text: price,
                  style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: lightColorScheme.primary
                   //   color: Colors.purple
                  ),
                ),
              ],
            ),
          ),
         // const SizedBox(height: 8),
          Row(
           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RatingBar.builder(
                initialRating: double.parse(average_rating!.toString()),
                minRating: 1,
                itemSize: 12,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.green.shade800,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              Text("(${review_count.toString()})",style: GoogleFonts.poppins(
                fontSize: 8
              ),),
              //Text("(Image.asset(AssetsList.gargImage))"),
              Spacer(),
              if(variation! == "0")
              InkWell(
                onTap: () {
              if(stockQuantity! > 0){
                LoadingOverlay.show(context);
                BlocProvider.of<AddCartBloc>(context).add(
                  AddCartReqEvent(
                      productCode: productCode,
                      price: price,
                      quantity: "1",
                      context: context
                  ),
                );
                // Listen for state changes and then dispatch the cart event
                BlocProvider.of<AddCartBloc>(context)
                    .stream
                    .firstWhere((state) {
                  // Define your condition for when the operation is complete
                  return state
                  is AddCartLoadedState; // or whatever your success state is
                }).then((_) {
                  context.read<CartBloc>().add(CartReqEvent(count:0,checkedCart:false));
                });
              }else{
                CustomToast.showCustomRoast(
                    context: context,
                    message: "Out of Stock", icon: Bootstrap.check_circle,iconColor: Colors.red);

              }

                              },
                              child: Container(
              height: 30,
              width: 30,
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100), // Fully circular
              //  color: gPrimaryColor,
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
              child: Icon(Bootstrap.cart_plus,size: 15,color: gPrimaryColor,),
                              ),
                            )

            ],
          ),
        ],
      ),
    );
  }
}
