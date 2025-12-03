import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../component/loading_overlay.dart';
import '../../../core/constant/colors_constant.dart';
import '../../../core/services/routeHelper/route_name.dart';
import '../../../theme/theme_data.dart';
import '../../../utils/custome_toast.dart';
import '../../../utils/hieght_width_map.dart';
import '../../cart/bloc/add_cart/add_cart_bloc.dart';
import '../../cart/bloc/add_cart/add_cart_event.dart';
import '../../cart/bloc/add_cart/add_cart_state.dart';
import '../../cart/bloc/cart_bloc.dart';
import '../../cart/bloc/cart_event.dart';
import '../../cart/bloc/cart_state.dart';
import '../../service/sharepref/get_all_pref.dart';
import '../../wish_list/bloc/wishlist_bloc.dart';
import '../../wish_list/bloc/wishlist_event.dart';
import '../bloc/random_product_bloc/random_product_list_bloc.dart';
import '../bloc/random_product_bloc/random_product_list_event.dart';
import '../bloc/random_product_bloc/random_product_list_state.dart';
import '../model/random_product_model.dart';
import '../product_details.dart';

class RandomWiseProductHome extends StatefulWidget {
  const RandomWiseProductHome({super.key});

  @override
  State<RandomWiseProductHome> createState() => _RandomWiseProductHomeState();
}

class _RandomWiseProductHomeState extends State<RandomWiseProductHome> {
  @override
  void initState() {
    super.initState();
    // Initial load
    context.read<RandomProductListBloc>().add(RandomProductListReqEvent());
  }


  int i = 0;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<RandomProductListBloc,RandomProductListState>(
      builder: (BuildContext context, state) {
        if(state is RandomProductListInitialState){
          return Center(
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
        } else if(state is RandomProductListLoadedState){

          return SingleChildScrollView(

            child: Stack(
              children: [
                GridView.builder(
                  padding:  EdgeInsets.symmetric(horizontal: 10),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: ScreenHieght.getCrossAxisCount(context),
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                    // Dynamically adjust based on screen size
                    childAspectRatio: screenWidth / (screenHeight / 1.4),
                  ),
                  itemCount: state.product.length + 1,
                  itemBuilder: (BuildContext context, int index) {

                    if (index >= state.product.length) {
                      return SizedBox.shrink();
                    }
                    final info = state.product[index];

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetails(
                              productCode: info.product_code!,
                              productName: info.product_name!,
                              sellingPrice: double.parse(info.sell_price!),
                              stock_quantity: info.stock_quantity,
                              productImage: info.image_full_url,
                              variation: info.has_variations,),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(top: 5,left: 5,right: 5),
                          decoration: const BoxDecoration(
                            // color: Colors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(5))
                          ),
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
                                      imageUrl: info.main_image_full_url != "" ? info.main_image_full_url! : info.image_full_url!,

                                      width: 200,
                                      height: 140,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          Container(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
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
                                              context.read<RandomProductListBloc>().add(RandomProductWishListUpdateEvent(
                                                  index: index,flag: true,limit: 20));
                                            }else{
                                              //  context.read<WishlistBloc>().add(WishlistReqEvent());
                                              LoadingOverlay.show(context);
                                              BlocProvider.of<WishlistBloc>(context).add(WishlistRemovedEvent(
                                                  item_code: info.product_code!,product_code: info.product_code!,context: context));
                                              context.read<RandomProductListBloc>().add(RandomProductWishListUpdateEvent(
                                                  index: index,flag: false,limit: 20));
                                            }
                                          }else{
                                            CustomToast.showCustomRoast(context: context, message: "You are not login!", icon: Bootstrap.check_circle,iconColor: Colors.red);
                                          }

                                        },
                                        child: Icon(info.is_wishlisted! ?
                                        Bootstrap.heart_fill : Bootstrap.heart,
                                            color:info.is_wishlisted! ?
                                            Colors.red :  Colors.grey.shade400),
                                      )),
                                  // Positioned(
                                  //   top: 5,
                                  //   right: 5,
                                  //   child: InkWell(
                                  //     onTap: (){
                                  //       LoadingOverlay.show(context);
                                  //       BlocProvider.of<WishlistBloc>(context).add(WishlistSaveEvent(
                                  //           productCode: info.product_code!,context: context));
                                  //       context.read<ProductListBloc>().add(ProductWishListUpdateEvent(
                                  //           index: index,flag: true,limit: 20));
                                  //     },
                                  //     child: Icon(
                                  //       info.is_wishlisted!?
                                  //       Bootstrap.heart_fill : Bootstrap.heart_fill,
                                  //       size: 25,
                                  //       color:  info.is_wishlisted!? Colors.red.shade800 : Colors.grey.shade400,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Product list
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                child: Column(

                                  children: [
                                    ProductAllItem(
                                      latestProductModel: info,
                                      name:  info.product_name!,
                                      brand: "Product's brand",
                                      price:  info.sell_price!,
                                      productCode: info.product_code,
                                      average_rating: info.average_rating,
                                      review_count: info.review_count,
                                      variation: info.has_variations.toString(),
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
                ),

              ],
            ),
          );

          // return Column(
          //   children: [
          //     GridView.builder(
          //       padding: const EdgeInsets.symmetric(horizontal: 10),
          //       shrinkWrap: true,
          //       physics: NeverScrollableScrollPhysics(),
          //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //         crossAxisCount: 2,
          //         mainAxisSpacing: 2,
          //         crossAxisSpacing: 2,
          //         childAspectRatio: 0.68,
          //       ),
          //       itemCount: state.product.length,
          //       itemBuilder: (BuildContext context, int index) {
          //         // If this is the loading indicator position
          //
          //         Fluttertoast.showToast(msg: state.product.length.toString());
          //         // Regular item
          //
          //           final info = state.product[index];
          //           return InkWell(
          //             onTap: () {
          //               // Navigator.push(
          //               //   context,
          //               //   MaterialPageRoute(
          //               //     builder: (context) => ProductDetails(productCode: info.product_code!, productName: info.product_name!, sellingPrice: double.parse(info.sell_price!), productImage: info.image_full_url,),
          //               //   ),
          //               // );
          //             },
          //             child: Card(
          //               elevation: 2,
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(8),
          //               ),
          //               child: Container(
          //                 decoration: const BoxDecoration(
          //                     color: Colors.white,
          //                     borderRadius: BorderRadius.all(
          //                         Radius.circular(10))
          //                 ),
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Stack(
          //                       children: [
          //                         ClipRRect(
          //                           borderRadius: const BorderRadius.only(
          //                             topRight: Radius.circular(5),
          //                             topLeft: Radius.circular(5),
          //                           ),
          //                           child: CachedNetworkImage(
          //                             imageUrl: info.image_full_url!,
          //                             width: 200,
          //                             height: 140,
          //                             fit: BoxFit.cover,
          //                             placeholder: (context, url) =>
          //                                 Container(),
          //                             errorWidget: (context, url, error) =>
          //                                 Icon(Icons.error),
          //                           ),
          //                         ),
          //                         Positioned(
          //                           top: 5,
          //                           right: 5,
          //                           child: Container(
          //                             height: 30,
          //                             width: 30,
          //                             padding: const EdgeInsets.all(7),
          //                             decoration: BoxDecoration(
          //                               borderRadius: BorderRadius.circular(
          //                                   100),
          //                               color: gPrimaryColor,
          //                             ),
          //                             child: Icon(Bootstrap.heart, size: 15,
          //                                 color: Colors.white),
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                     const SizedBox(height: 10),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           );
          //
          //       },
          //     ),
          //   ],
          // );

        }else{
          return Center(
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
        }
      },
      listener: (context, state) {
        if (state is RandomProductListErrorState) {
          Fluttertoast.showToast(msg: state.errorMsg);
        }
      },
    );
  }

}
class ProductAllItem extends StatelessWidget {
  final RandomProductModel latestProductModel;
  final String name;
  final String brand;
  final String price;
  final String? productCode;
  final String? average_rating;
  final int? review_count;
  final String? variation;
  final int? stockQuantity;

  const ProductAllItem({
    super.key,
    required this.latestProductModel,
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
            style: const TextStyle(
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(brand,
              style: const TextStyle(
                  overflow: TextOverflow.ellipsis, color: Colors.grey)),
          const SizedBox(height: 5),
          if(variation == "1")
            Text("Staring at",style: GoogleFonts.poppins(
              //  color: Colors.green.shade700
            ),),
          RichText(
            text: TextSpan(
              style: TextStyle( fontSize: 14),
              children: [
                TextSpan(
                    text: 'Rs ',
                    style:
                    GoogleFonts.poppins(fontSize: 10,color: lightColorScheme.primary)),
                TextSpan(
                  text: price,
                  style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,

                      color: lightColorScheme.primary
                  ),
                ),
              ],
            ),
          ),
          // const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RatingBar.builder(
                initialRating: double.parse(average_rating!),
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

              Spacer(),
              if(variation! == "0")
                InkWell(
                  onTap: () {
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
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100), // Fully circular
                      // color: gPrimaryColor,
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
