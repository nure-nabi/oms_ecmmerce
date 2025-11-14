import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/screen/brand/bloc/brand_bloc.dart';
import 'package:oms_ecommerce/screen/brand/bloc/brand_state.dart';
import 'package:oms_ecommerce/screen/brand/bloc/brand_wise_products_bloc/brand_wise_products_bloc.dart';
import 'package:oms_ecommerce/screen/brand/bloc/brand_wise_products_bloc/brand_wise_products_event.dart';
import 'package:oms_ecommerce/screen/brand/bloc/brand_wise_products_bloc/brand_wisw_products_state.dart';
import 'package:oms_ecommerce/screen/product/product_details.dart';

import '../../component/loading_overlay.dart';
import '../../core/constant/colors_constant.dart';
import '../../core/services/routeHelper/route_name.dart';
import '../../utils/custome_toast.dart';
import '../cart/bloc/add_cart/add_cart_bloc.dart';
import '../cart/bloc/add_cart/add_cart_event.dart';
import '../cart/bloc/add_cart/add_cart_state.dart';
import '../cart/bloc/cart_bloc.dart';
import '../cart/bloc/cart_event.dart';
import '../cart/bloc/cart_state.dart';
import '../service/sharepref/get_all_pref.dart';
import '../wish_list/bloc/wishlist_bloc.dart';
import '../wish_list/bloc/wishlist_event.dart';
import 'bloc/top_category_product_bloc.dart';
import 'bloc/top_category_product_event.dart';
import 'bloc/top_category_product_state.dart';



class TopCategoryProductListPage extends StatefulWidget {
  int categoryId;
  TopCategoryProductListPage({super.key,required this.categoryId});

  @override
  State<TopCategoryProductListPage> createState() => _BrandProductListPageState();
}

class _BrandProductListPageState extends State<TopCategoryProductListPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    // Initial load
    context.read<TopCategoryProductsBloc>().add(TopCategoryProductsReqEvent(limit: 20, offset: 0, categoryId: widget.categoryId));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        // Load more when 200px from bottom
        context.read<TopCategoryProductsBloc>().add(TopCategoryProductsLazyLoadEvent(limit: 20, offset: 0, categoryId: widget.categoryId));
      }
    });
  }


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Top Category Product",style: GoogleFonts.poppins(
          letterSpacing: 1
        ),),
        leading: InkWell(
            onTap: (){
                           Navigator.pop(context); // Proceed with back navigation
            },
            child: Icon(Bootstrap.chevron_left)),
       // backgroundColor: gPrimaryColor,
        actions: [
          getCartData()
        ],
      ),
      body: BlocConsumer<TopCategoryProductsBloc,TopCategoryProductsState>(
        builder: (BuildContext context, state) {
          if(state is TopCategoryProductsLoadingState){
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
          } else
           if(state is TopCategoryProductsLoadedState){
            return SingleChildScrollView(
              controller: _scrollController,
              child: Stack(
                children: [
                  GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: state.product!.length + 1,
                    itemBuilder: (BuildContext context, int index) {

                      if (index >= state.product!.length) {
                        return SizedBox.shrink();
                      }
                      final info = state.product![index];
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
                                color: Colors.white,
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
                                              context.read<TopCategoryProductsBloc>().add(TopCategoryProductsWishListFlagReqEvent(

                                                  flag: true, index: index));
                                            }else{
                                              //  context.read<WishlistBloc>().add(WishlistReqEvent());
                                              LoadingOverlay.show(context);
                                              BlocProvider.of<WishlistBloc>(context).add(WishlistRemovedEvent(
                                                  item_code: info.product_code!,product_code: info.product_code!,context: context));
                                              context.read<TopCategoryProductsBloc>().add(TopCategoryProductsWishListFlagReqEvent(
                                                  flag: false, index: index));
                                            }
                                          }else{
                                            CustomToast.showCustomRoast(context: context, message: "You are not login!", icon: Bootstrap.check_circle,iconColor: Colors.red);
                                          }

                                        },
                                        child: Icon(info.is_wishlisted! ?
                                        Bootstrap.heart_fill : Bootstrap.heart,
                                            color:info.is_wishlisted! ?
                                            Colors.red :  Colors.grey.shade400),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                // Product list
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Column(

                                    children: [
                                      ProductAllItem(
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
                  // if (state.isLoadingMore)
                  if (state.isLoadingMore!)
                    Positioned(
                      bottom: 50,
                      left: 0,
                      right: 0,
                      child: Center(
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
                      ),
                    ),
                ],
              ),
            );

          }else if(state is TopCategoryProductsEmptyState){
            return const Center(
              child: Text("No data found...."),
            );
          }else{
             return SizedBox();
           }
        },
        listener: (context, state) {
          if (state is TopCategoryProductsErrorState) {
            Fluttertoast.showToast(msg: state.errorMsg!);
          }
        },
      ),
    );
  }
  Widget getCartData(){
    return InkWell(
      onTap: (){
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => CartPage(
        //           leading: true,
        //         )));
        Navigator.pushNamed(context, cartPage,
            arguments: true
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            icon: Icon(Bootstrap.cart),
            onPressed: () {
              Navigator.pushNamed(context, cartPage,
                  arguments: true
              );
            },
          ),
          Positioned(
            right: 8,
            top: 8,
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if(state is CartLoadedState){
                  return CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 10,
                    child: Text(
                      state.cartResModel!.cart!.items.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  );
                }else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
class ProductAllItem extends StatelessWidget {
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
                color: Colors.green.shade700
            ),),
          RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 14),
              children: [
                TextSpan(
                    text: 'Rs ',
                    style:
                    GoogleFonts.poppins(fontSize: 10, color: Colors.black)),
                TextSpan(
                  text: price,
                  style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.purple),
                ),
              ],
            ),
          ),
          // const SizedBox(height: 8),
          if(variation! == "0")

            stockQuantity! > 0 ? Row(
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
            ) : Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(top: 5),
                child: Text("Out of stock",style: GoogleFonts.poppins(
                    color: Colors.red,
                    fontWeight: FontWeight.w600
                ),),
              ),
            ),
        ],
      ),
    );
  }
}