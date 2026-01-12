import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../component/loading_overlay.dart';
import '../../constant/asstes_list.dart';
import '../../core/constant/colors_constant.dart';
import '../../core/services/routeHelper/route_name.dart';
import '../../utils/hieght_width_map.dart';
import '../cart/bloc/add_cart/add_cart_bloc.dart';
import '../cart/bloc/add_cart/add_cart_event.dart';
import '../cart/bloc/add_cart/add_cart_state.dart';
import '../cart/bloc/cart_bloc.dart';
import '../cart/bloc/cart_event.dart';
import '../cart/bloc/cart_state.dart';
import '../product/product_details.dart';
import '../wish_list/bloc/wishlist_bloc.dart';
import '../wish_list/bloc/wishlist_event.dart';
import 'bloc/category_product/category_product_bloc.dart';
import 'bloc/category_product/category_product_event.dart';
import 'bloc/category_product/category_product_state.dart';

class CategoryWiseProductsPage extends StatefulWidget {
  final int categoryId;
  final String title;
   CategoryWiseProductsPage({super.key,required this.categoryId,required this.title});

  @override
  State<CategoryWiseProductsPage> createState() => _CategoryWiseProductsPageState();
}

class _CategoryWiseProductsPageState extends State<CategoryWiseProductsPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    // Initial load
    context.read<CategoryProductBloc>().add(CategoryProductsReqEvent(limit: 20, offset: 0, categoryId: widget.categoryId));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        // Load more when 200px from bottom
        context.read<CategoryProductBloc>().add(CategoryProductsReqEvent(limit: 20, offset: 0, categoryId: widget.categoryId));
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.title,style: GoogleFonts.poppins(
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
      body: BlocConsumer<CategoryProductBloc,CategoryProductState>(
        builder: (BuildContext context, state) {
          if(state is CategoryProductsLoadingState){
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
          if(state is CategoryProductsLoadedState){
            return SingleChildScrollView(
              controller: _scrollController,
              child: Stack(
                children: [
                  state.product!.isNotEmpty ?  GridView.builder(
                    padding:  EdgeInsets.symmetric(horizontal: 10),
                    shrinkWrap: true,
                    physics:  NeverScrollableScrollPhysics(),
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ScreenHieght.getCrossAxisCount(context),
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      // Dynamically adjust based on screen size
                      childAspectRatio: screenWidth / (screenHeight / 1.4),
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
                          elevation: 2,
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
                                        imageUrl: info.image_full_url != "" ? info.image_full_url!: info.main_image_full_url!,
                                        width: 200,
                                        height: 140,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Container(),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(AssetsList.gargImage),
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      right: 5,
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        padding: const EdgeInsets.all(7),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              100),
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
                                        child: InkWell(
                                          onTap: (){
                                            LoadingOverlay.show(context);
                                            BlocProvider.of<WishlistBloc>(context).add(WishlistSaveEvent(
                                                productCode: info.product_code!,context: context));
                                          },
                                          child: Icon(
                                            Bootstrap.heart,
                                            size: 15,
                                            color: gPrimaryColor,
                                          ),
                                        ),
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
                  )
                      :Center(child: Text("item not found"),),
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

          }else if(state is CategoryProductsEmptyState){
            return const Center(
              child: Text("item not found"),
            );
          }else{
            return SizedBox();
          }
        },
        listener: (context, state) {
          if (state is CategoryProductsErrorState) {
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
