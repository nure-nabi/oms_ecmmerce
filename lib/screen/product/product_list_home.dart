import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/screen/product/product_details.dart';
import 'package:oms_ecommerce/utils/hieght_width_map.dart';

import '../../component/loading_overlay.dart';
import '../../utils/custome_toast.dart';
import '../brand/brand_product.dart';
import '../service/sharepref/get_all_pref.dart';
import '../wish_list/bloc/wishlist_bloc.dart';
import '../wish_list/bloc/wishlist_event.dart';
import 'bloc/product_bloc/product_list_bloc.dart';
import 'bloc/product_bloc/product_list_event.dart';
import 'bloc/product_bloc/product_list_state.dart';

class ProductListHome extends StatefulWidget {
  final ScrollController scrollController;
   ProductListHome({super.key,required this.scrollController});

  @override
  State<ProductListHome> createState() => _ProductListHomeState();
}

class _ProductListHomeState extends State<ProductListHome> {

  @override
  void initState() {
    super.initState();
    // Initial load
    context.read<ProductListBloc>().add(ProductListReqEvent(limit: 20, offset: 0));
    widget.scrollController.addListener(() {

      if (widget.scrollController.position.pixels >= widget.scrollController.position.maxScrollExtent - 200) {
        // Load more when 200px from bottom
        context.read<ProductListBloc>().add(ProductListLazyLoadEvent(limit: 20, offset: 0));
      }
    });
  }


  //final ScrollController _scrollController = ScrollController();
  List<String> items = List.generate(20, (index)=> "Item $index");

  Future<void>  loadModeData()async{
    await Future.delayed(Duration(seconds: 2));
    List<String> newItem = List.generate(20, (index) => "New Item ${items.length + index}");
    setState(() {
      items.addAll(newItem);
    });

  }

  @override
  void dispose() {
   // widget.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return  BlocConsumer<ProductListBloc,ProductListState>(
      builder: (BuildContext context, state) {
        if(state is ProductListInitialState){
          return  Center(
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
        } else if(state is ProductListLoadedState){

          return Stack(
            children: [
              GridView.builder(
                padding:  EdgeInsets.symmetric(horizontal: 10),
                shrinkWrap: true,
                physics:  NeverScrollableScrollPhysics(),
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: ScreenHieght.getCrossAxisCount(context),
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  // Dynamically adjust based on screen size
                  childAspectRatio: screenWidth / (screenHeight / 1.5),
                ),
                itemCount: state.product.length + 1,
                itemBuilder: (BuildContext context, int index) {

                  if (index >= state.product.length) {
                    return const SizedBox.shrink();
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
                            productImage: info.image_full_url,
                            stock_quantity: info.stock_quantity,
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
                        padding: const EdgeInsets.only(top: 5,left: 5,right: 5),
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
                                    imageUrl: info.main_image_full_url!.isNotEmpty ? info.main_image_full_url! : info.image_full_url!,
                                    width: 200,
                                    height: 140,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        Container(),
                                    errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
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
                                            context.read<ProductListBloc>().add(ProductWishListUpdateEvent(
                                                index: index,flag: true,limit: 20));
                                          }else{
                                            //  context.read<WishlistBloc>().add(WishlistReqEvent());
                                            LoadingOverlay.show(context);
                                            BlocProvider.of<WishlistBloc>(context).add(WishlistRemovedEvent(
                                                item_code: info.product_code!,product_code: info.product_code!,context: context));
                                            context.read<ProductListBloc>().add(ProductWishListUpdateEvent(
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
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Column(

                                children: [
                                  ProductAllItem(
                                    name:  info.product_name!,
                                    brand: "Product's brand",
                                    price:  info.sell_price!,
                                    productCode: info.product_code,
                                    average_rating: info.average_rating,
                                    review_count: info.review_count,
                                    stock_quantity: info.stock_quantity,
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
              // if (state.isLoadingMore)
              if (state.isLoadingMore)
                Positioned(
                  bottom: 50,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      height: 40,
                      width: 40,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow:  [
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
                  ),
                ),
            ],
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
          return  Center(
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
        if (state is ProductListErrorState) {
          Fluttertoast.showToast(msg: state.errorMsg);
        }
      },
    );
  }
}
