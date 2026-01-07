import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';


import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/component/loading_overlay.dart';
import 'package:oms_ecommerce/core/services/routeHelper/route_name.dart';
import 'package:oms_ecommerce/screen/cart/bloc/add_cart/add_cart_bloc.dart';
import 'package:oms_ecommerce/screen/cart/bloc/add_cart/add_cart_event.dart';
import 'package:oms_ecommerce/screen/cart/bloc/add_cart/add_cart_state.dart';
import 'package:oms_ecommerce/screen/cart/bloc/cart_state.dart';
import 'package:oms_ecommerce/screen/cart/cart.dart';
import 'package:oms_ecommerce/screen/product/bloc/product_details_bloc.dart';
import 'package:oms_ecommerce/screen/product/bloc/product_details_event.dart';
import 'package:oms_ecommerce/screen/product/bloc/product_details_state.dart';
import 'package:oms_ecommerce/screen/product/product_related/block/product_related_bloc.dart';
import 'package:oms_ecommerce/screen/product/product_related/block/product_related_event.dart';
import 'package:oms_ecommerce/screen/product/product_related/block/product_related_state.dart';
import 'package:oms_ecommerce/screen/service/sharepref/get_all_pref.dart';
import 'package:oms_ecommerce/theme/theme_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

import '../../constant/asstes_list.dart';
import '../../core/constant/colors_constant.dart';
import '../../storage/hive_storage.dart';
import '../../theme/theme_data.dart';
import '../../utils/custome_toast.dart';
import '../../utils/hieght_width_map.dart';
import '../address/bloc/address_bloc.dart';
import '../address/bloc/address_event.dart';
import '../address/bloc/address_state.dart';
import '../address/model/address_model.dart';
import '../cart/bloc/cart_bloc.dart';
import '../cart/bloc/cart_event.dart';
import '../profile/block/profile_bloc/profile_bloc.dart';
import '../profile/block/profile_bloc/profile_event.dart';
import '../profile/block/profile_bloc/profile_state.dart';
import '../web_view/web_view.dart';
import '../widget/app_bar.dart';
import '../wish_list/bloc/wishlist_bloc.dart';
import '../wish_list/bloc/wishlist_event.dart';

import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProductDetails extends StatefulWidget {
  final String? productCode;
  final String? productName;
  final double? sellingPrice;
  final String? productImage;
  final int? variation;
  final int? stock_quantity;
  final bool? leadingFlag;

  const ProductDetails(
      {super.key,
      required this.productCode,
      required this.productName,
      required this.sellingPrice,
      required this.productImage,
      required this.variation,
       this.stock_quantity,
       this.leadingFlag=false,
      });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late AddressResponseModel addressResponseModel;
  int count = 1;
  int stockQuantity = 1;
  bool _isExpanded1 = false;
  bool _isExpanded2 = false;
  bool _isExpanded3 = false;
  bool _isExpanded4 = false;
  int _currentIndex = 1;
  String shipping_cost = "0";
  final PageController _pageController = PageController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      BlocProvider.of<ProductDetailsBloc>(context)
          .add(ProductDetailsReqEvent(productCode: widget.productCode));
      BlocProvider.of<ProductRelatedBloc>(context)
          .add(ProductRelatedReqEvent(productCode: widget.productCode));
      context.read<ProfileBloc>().add(ProfileReqEvent());
      context.read<AddressBloc>().add(AddressReqEvent());
    });
    super.initState();
  }
  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index + 1; // +1 because index is 0-based
    });
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    Future<void> _shareContent(String imageUrl) async {
      try {
        // Show loading indicator
        final scaffoldMessenger = ScaffoldMessenger.of(context);
        scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Downloading image...')),
        );

        // Download the image
        final response = await http.get(Uri.parse(imageUrl));
        final bytes = response.bodyBytes;

        // Get temporary directory
        final directory = await getTemporaryDirectory();
        final imagePath = '${directory.path}/shared_image_${DateTime.now().millisecondsSinceEpoch}.jpg';

        // Save the image temporarily
        final imageFile = File(imagePath);
        await imageFile.writeAsBytes(bytes);

        // Share the image with text
        await Share.shareXFiles(
          [XFile(imagePath)],
          text: 'Check out this image I found!',
          subject: 'Shared Image',
        );

        // Optional: Clean up the temporary file after sharing
        await imageFile.delete();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sharing image: $e')),
        );
      }
    }




    return SafeArea(
      child: Scaffold(
        appBar: AppBarShow(
        //  backgroundColor: gPrimaryColor,
          leadingFlag: widget.leadingFlag!,
          leading: InkWell(
            onTap: ()=>Navigator.pop(context),
              child: Icon(Bootstrap.chevron_left)),
          title:widget.productName!.isNotEmpty ? widget.productName! : "Product",
          onCartPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CartPage(
                          leading: true,
                        )));
          },
        ),
        body:widget.productName!.isNotEmpty ? SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             // call profile
              BlocConsumer<ProfileBloc, ProfileState>(
                listener: (context, state) {
                  if (state is ProfileLoadedState) {
                    shipping_cost = state.userInfoResMode!.addresses![0].city!.shipping_cost!;
                  }
                },
                builder: (context, state) {
                  return SizedBox.shrink(); // or your UI widget
                },
              ),
              //call address
              BlocConsumer<AddressBloc, AddressState>(
                listener: (context, state) {
                  if (state is AddressLoadedState) {
                    // Navigate after a delay to avoid context issues
                    addressResponseModel = state.addressResponseModel!;
                    // WidgetsBinding.instance.addPostFrameCallback((_) {
                    //   addressResponseModel = state.addressResponseModel!;
                    //
                    // });
                  }
                },
                builder: (context, state) {
                  return SizedBox.shrink(); // or your UI widget
                },
              ),

              BlocConsumer<ProductDetailsBloc, ProductDetailsState>(
                builder: (BuildContext context, state) {
                  if (state is ProductDetailsLoadingState) {
                    return Column(
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 350,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                          ),
                        )
                      ],
                    );
                  }  else if (state is ProductDetailsLoadedState) {
                    stockQuantity = state.productDetailsReqModel!.productDetailsResModel!.stock_quantity!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(state.productDetailsReqModel!.productDetailsResModel!.filesFullUrl!.isNotEmpty)...[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Stack(
                              children: [
                                PageView.builder(
                                  onPageChanged: onPageChanged,
                                  controller: _pageController,
                                  itemCount: state.productDetailsReqModel!.productDetailsResModel!.filesFullUrl!.length,
                                  itemBuilder: (context, index) {
                                    var info = state.productDetailsReqModel!.productDetailsResModel!.filesFullUrl![index];
                                    return CachedNetworkImage(
                                      imageUrl: info,
                                      placeholder: (context, url) => Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: SizedBox(
                                          height: MediaQuery.of(context).size.height * 0.4,
                                          width: MediaQuery.of(context).size.width,
                                        ),
                                      ),
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    );
                                  },
                                ),
                                Positioned(
                                  bottom: 5,
                                  right: 10,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: gPrimaryColor.withOpacity(0.5),
                                    ),
                                    child: Text(
                                      '$_currentIndex / ${state.productDetailsReqModel!.productDetailsResModel!.filesFullUrl!.length}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]else ...[
                          CachedNetworkImage(
                            // imageUrl: state.productDetailsResModel!.image_full_url!,
                            imageUrl: state.productDetailsReqModel!.productDetailsResModel!.image_full_url! != "" ? state.productDetailsReqModel!.productDetailsResModel!.image_full_url!: state.productDetailsReqModel!.productDetailsResModel!.main_image_full_url!,
                            height: MediaQuery.of(context).size.height * 0.4,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            errorWidget: (context, url, error) => Image.asset("assets/icons/gargimage.png"),
                          ),
                        ],

                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.productDetailsReqModel!.productDetailsResModel!.product_name!,maxLines: 2,overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                              ),
                              SizedBox(height: 10,),

                              if(widget.variation==1)
                              Row(
                                children: [
                                  Text('Starting at ',maxLines: 1,style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16
                                  ),),
                                  Text('Rs. ${widget.sellingPrice}',maxLines: 1,style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17
                                  ),),
                                ],
                              ),

                              if(state.productDetailsReqModel!.productDetailsResModel!.has_variations == 0)
                              Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                           fontSize: 14),
                                      children: [
                                        TextSpan(
                                            text: 'Rs ',
                                            style: GoogleFonts.poppins(
                                              color: lightColorScheme.primary,
                                                fontSize: 10,
                                              )),
                                        TextSpan(
                                          text: state.sellPrice! == 0
                                              ? state.productDetailsReqModel!.productDetailsResModel!.sell_price!
                                              : state.sellPrice!.toStringAsFixed(2),
                                          style: GoogleFonts.poppins(
                                              fontSize: 17,
                                               color: lightColorScheme.primary,
                                              fontWeight: FontWeight.w600,
                                             ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                           fontSize: 14),
                                      children: [
                                        TextSpan(
                                            text: 'Rs ',
                                            style: GoogleFonts.poppins(
                                                fontSize: 10,
                                               )),
                                        TextSpan(
                                          text: state.actualPrice! == 0
                                              ? state.productDetailsReqModel!.productDetailsResModel!
                                                  .actual_price!
                                              : state.actualPrice!
                                                  .toStringAsFixed(2),
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            // Adds strikethrough line
                                           // decorationColor: Colors.grey,
                                            // Optional: Customize line color
                                            decorationThickness: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '(${state.discount!.toStringAsFixed(2)} %OFF)',
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.green),
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  RatingBar.builder(
                                    initialRating: double.parse(state.productDetailsReqModel!.productDetailsResModel!.average_rating.toString()),
                                    minRating: 1,
                                    itemSize: 18,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    ignoreGestures: true, // <-- makes it read-only
                                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.green.shade800,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                  Text("(${state.productDetailsReqModel!.productDetailsResModel!.review_count})",style: GoogleFonts.poppins(
                                      fontSize: 8
                                  ),),
                                  Spacer(),

                                  InkWell(
                                      splashColor: Colors.transparent, // Splash/ripple color when tapped
                                      highlightColor: Colors.red.withOpacity(0), // Highlight color when pressed
                                    onTap : (){
                                     // context.read<WishlistBloc>().add(WishlistReqEvent());
                                     // Fluttertoast.showToast(msg: state.productDetailsReqModel!.productDetailsResModel!.is_wishlisted!.toString());
                                    if(!state.productDetailsReqModel!.productDetailsResModel!.is_wishlisted!) {
                                      BlocProvider.of<WishlistBloc>(context).add(WishlistSaveEvent(
                                              productCode: state.productDetailsReqModel!
                                                  .productDetailsResModel!.product_code!,
                                              context: context));
                                      context.read<ProductDetailsBloc>().add(
                                          ProductWishListAddEvent(index: 0, flage: true,productCode:state.productDetailsReqModel!
                                              .productDetailsResModel!.product_code!,));
                                      LoadingOverlay.show(context);
                                    }else{
                                      BlocProvider.of<WishlistBloc>(context).add(
                                          WishlistRemovedEvent(
                                            product_code: state.productDetailsReqModel!
                                                .productDetailsResModel!.product_code!,
                                              item_code: state.productDetailsReqModel!
                                                  .productDetailsResModel!.product_code!,
                                              context: context));
                                      context.read<ProductDetailsBloc>().add(
                                          ProductWishListAddEvent(index: 0, flage: false,productCode:state.productDetailsReqModel!
                                              .productDetailsResModel!.product_code!, ));
                                      LoadingOverlay.show(context);
                                    }
                                    },
                                      child: Icon(state.productDetailsReqModel!.productDetailsResModel!.is_wishlisted! ?
                                      Bootstrap.heart_fill : Bootstrap.heart,
                                          color: state.productDetailsReqModel!.productDetailsResModel!.is_wishlisted! ?
                                          Colors.red :  Colors.grey.shade400)),
                                  SizedBox(width: 20,),

                                  // InkWell(
                                  //   onTap : (){
                                  //     _shareContent("https://gargdental.omsok.com/storage/app/public/backend/carousel_files/screenshot_2025_07_14_at_121129.png");
                                  //   },
                                  //     child: Icon(Bootstrap.share)),
                                ],
                              ),
                              SizedBox(height: 10,),
                              if(state.productDetailsReqModel!.productDetailsResModel!.catalogue_full_url != "")
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(width: 1,color: Colors.orange),
                                ),
                                child: InkWell(
                                  onTap:(){
                                   // Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewPDF()));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Catalogue",style: GoogleFonts.poppins(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.w600
                                      ),),
                                      SizedBox(width: 10,),
                                      Icon(Bootstrap.download,color: Colors.orange,size: 20,)
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 5,),
                              if(state.productDetailsReqModel!.productDetailsResModel!.has_variations == 0)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: Text("")),
                                  Expanded(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            if(count > 1){
                                              count--;
                                              context
                                                  .read<ProductDetailsBloc>()
                                                  .add(ProductQtyDecrementEvent(
                                                  count: state.qtyCount!,
                                                  price: double.parse(state.productDetailsReqModel!.productDetailsResModel!.sell_price!),
                                                  actualPrice: double.parse(state.productDetailsReqModel!.productDetailsResModel!.actual_price!)));
                                            }

                                          },
                                          child: const Icon(Bootstrap.dash_circle)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(state.qtyCount.toString()),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                          onTap: () {
                                            if(count < stockQuantity){
                                              count++;
                                              context.read<ProductDetailsBloc>().add(ProductQtyIncrementEvent(
                                                  count: state.qtyCount!,
                                                  price: double.parse(
                                                    state
                                                        .productDetailsReqModel!.productDetailsResModel!
                                                        .sell_price!,
                                                  ),
                                                  actualPrice: double.parse(state
                                                      .productDetailsReqModel!.productDetailsResModel!
                                                      .actual_price!)));
                                            }else{
                                              Fluttertoast.showToast(msg: "Out of stock");
                                            }

                                          },
                                          child: Icon(Bootstrap.plus_circle)),
                                    ],
                                  )),
                                ],
                              ),

                              //variations
                              if(state.productDetailsReqModel!.productDetailsResModel!.has_variations == 1)
                                SizedBox(height: 10,),
                                Column(
                                  children: List.generate(state.productDetailsReqModel!.productDetailsResModel!.variations.length, (index){
                                    var percentage = ((double.parse(state.productDetailsReqModel!.productDetailsResModel!.variations[index].actual_price!) - double.parse(state.productDetailsReqModel!.productDetailsResModel!.variations[index].sell_price!))/double.parse(state.productDetailsReqModel!.productDetailsResModel!.variations[index].actual_price!)) * 100;
                                     return Container(
                                       color: gPrimaryColor.withOpacity(0.1),
                                       padding: EdgeInsets.only(top: 5,left: 5,right: 5),
                                       child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text(state.productDetailsReqModel!.productDetailsResModel!.variations[index].product_name!,
                                             maxLines: 2,overflow: TextOverflow.ellipsis,style: GoogleFonts.poppins(
                                             fontWeight: FontWeight.w600,
                                             fontSize: 16,
                                           ),),
                                           SizedBox(height: 5,),
                                           Row(
                                             children: [
                                               Text('Rs. ${state.productDetailsReqModel!.productDetailsResModel!.variations[index].sell_price!}',maxLines: 1,style: GoogleFonts.poppins(
                                                   fontWeight: FontWeight.w600,
                                                   fontSize: 17
                                               ),),
                                               SizedBox(width: 10,),
                                               Text('Rs. ${state.productDetailsReqModel!.productDetailsResModel!.variations[index].actual_price!}',maxLines: 1,style: GoogleFonts.poppins(
                                                   fontWeight: FontWeight.w400,
                                                   fontSize: 16,
                                                 color: Colors.grey,
                                                 decoration: TextDecoration.lineThrough
                                               ),),
                                               SizedBox(width: 10,),
                                               Text('${percentage.toStringAsFixed(2)}% off',maxLines: 1,style: GoogleFonts.poppins(
                                                   fontWeight: FontWeight.w600,
                                                   fontSize: 16,
                                                   color: Colors.green
                                               ),),
                                             ],
                                           ),
                                           SizedBox(height: 10,),
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.end,
                                             children: [
                                                   Padding(
                                                     padding: const EdgeInsets.only(right: 5),
                                                     child: Material(
                                                     //  elevation: 2, // Shadow
                                                       borderRadius: BorderRadius.circular(4.0),
                                                       child: InkWell(
                                                         onTap: () {
                                                           LoadingOverlay.show(context);
                                                           BlocProvider.of<AddCartBloc>(context).add(
                                                             AddCartReqEvent(
                                                               productCode: state.productDetailsReqModel!.productDetailsResModel!.variations[index].product_code,
                                                               //  price: widget.sellingPrice?.toStringAsFixed(2),
                                                               price: state.productDetailsReqModel!.productDetailsResModel!.variations[index].sell_price!.toString(),
                                                               quantity: count.toString(),
                                                               context: context
                                                             ),
                                                           );

                                                           // Listen for state changes and then dispatch the cart event
                                                           BlocProvider.of<AddCartBloc>(context).stream.firstWhere((state) {
                                                             // Define your condition for when the operation is complete
                                                             return state is AddCartLoadedState; // or whatever your success state is
                                                           }).then((_) {
                                                             context.read<CartBloc>().add(CartReqEvent(count:0,checkedCart:false));
                                                           });
                                                         }, // Your onPressed function
                                                         borderRadius: BorderRadius.circular(4.0),
                                                         child: Container(
                                                           padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                                                           decoration: BoxDecoration(

                                                             borderRadius: BorderRadius.circular(4.0),
                                                             border: Border.all(color: Colors.orange, width: 1.0),
                                                           ),
                                                           child:  Text(
                                                             "Add to cart",
                                                             style: GoogleFonts.poppins(
                                                               fontWeight: FontWeight.w700,
                                                               color: Colors.orange
                                                             ),
                                                           ),
                                                         ),
                                                       ),
                                                     ),
                                                   ),
                                                  SizedBox(height: 10,),
                                             ],
                                           ),
                                           SizedBox(height: 10,),
                                         ],
                                       ),
                                     );
                                  }),
                                ),
                              // variation description
                              if(state.productDetailsReqModel!.productDetailsResModel!.has_variations == 0)
                                SizedBox(height: 10,),
                                Column(
                                  children: [
                                    htmlShow1("Description",context,state.productDetailsReqModel!.productDetailsResModel!.product_description,_isExpanded1),
                                    SizedBox(height: 10,),
                                    htmlShow2("Key Specifications",context,state.productDetailsReqModel!.productDetailsResModel!.key_specifications,_isExpanded2),
                                     SizedBox(height: 10,),
                                     htmlShow3("Packaging",context,state.productDetailsReqModel!.productDetailsResModel!.packaging,_isExpanded3),
                                    SizedBox(height: 10,),
                                    htmlShow4("Warranty",context,state.productDetailsReqModel!.productDetailsResModel!.warranty,_isExpanded4),
                                  ],
                                ),


                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),

                    //VARIATION
                    // GridView.builder(
                    //   padding: EdgeInsets.symmetric(horizontal: 10),
                    // shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(), // Disable scrolling inside
                    // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //
                    //   crossAxisCount: 5, // 4 chips per row
                    //   crossAxisSpacing: 8, // Horizontal spacing
                    //   mainAxisSpacing: 4, // Vertical spacing
                    //   childAspectRatio: 1, // Width/height ratio (adjust as needed)
                    // ),
                    //         itemCount:state.productDetailsResModel!.variation!.length ,
                    //         itemBuilder: (BuildContext context, index){
                    //           final info = state.productDetailsResModel!.variation![index];
                    //           return buildSizeChipGrid(info.attributes,info.price!);
                    //
                    //         })
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
                listener: (BuildContext context, Object? state) {},
              ),
              //product related
              BlocBuilder<ProductRelatedBloc, ProductRelatedState>(
                builder: (BuildContext context, state) {
                  if (state is ProductRelatedLoadingState) {
                    return GridView.builder(
                      padding:  EdgeInsets.symmetric(horizontal: 10),
                      // Padding around the grid
                      shrinkWrap: true,
                      // Useful inside ScrollViews
                      physics:  NeverScrollableScrollPhysics(),
                      // Disable scrolling if nested
                      gridDelegate:
                       SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: ScreenHieght.getCrossAxisCount(context),
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                        // Dynamically adjust based on screen size
                        childAspectRatio: screenWidth / (screenHeight / 1.5),
                      ),
                      itemCount: 4,
                      // Total number of items
                      itemBuilder: (BuildContext context, int index) {

                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                          ),
                        );
                      },
                    );
                  } else if (state is ProductRelatedLoadedState) {

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(state.productRelatedResModel!.data.isNotEmpty)
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: gPrimaryColor.withOpacity(0.1)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text(
                              "Related Product",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          ),
                        ),
                        if(state.productRelatedResModel!.data.isNotEmpty)
                        GridView.builder(
                          padding:  EdgeInsets.symmetric(horizontal: 10),
                          // Padding around the grid
                          shrinkWrap: true,
                          // Useful inside ScrollViews
                          physics:  NeverScrollableScrollPhysics(),
                          // Disable scrolling if nested
                          gridDelegate:
                               SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: ScreenHieght.getCrossAxisCount(context),
                                mainAxisSpacing: 1,
                                crossAxisSpacing: 1,
                                // Dynamically adjust based on screen size
                                childAspectRatio: screenWidth / (screenHeight / 1.4),
                              ),
                          itemCount: state.productRelatedResModel!.data.length,
                          // Total number of items
                          itemBuilder: (BuildContext context, int index) {
                            final info =
                                state.productRelatedResModel!.data[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetails(
                                      productCode: info.product_code!,
                                      productName: info.product_name!,
                                      stock_quantity: info.stock_quantity,
                                      sellingPrice: double.parse(info.sell_price!),
                                      productImage: info.image_full_url,
                                      variation: widget.variation,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                child: Container(
                                  decoration: const BoxDecoration(
                                     // color: Colors.white60,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10))),
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
                                              //imageUrl: info.image_full_url!,
                                              width: MediaQuery.of(context).size.width,
                                              height: 140,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  Container(),
                                              errorWidget: (context, url, error) =>
                                                  Icon(Icons.error),
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
                                                onTap: () async {
                                                  if(await GetAllPref.loginSuccess()){
                                
                                                  if(!info.is_wishlisted!){
                                                  LoadingOverlay.show(context);
                                                  BlocProvider.of<WishlistBloc>(context).add(WishlistSaveEvent(
                                                  productCode: info.product_code!,context: context));
                                                  context.read<ProductRelatedBloc>().add(ProductRelatedWishListFlagReqEvent(
                                                  flag: true, index: index));
                                
                                                  }else{
                                                  //  context.read<WishlistBloc>().add(WishlistReqEvent());
                                                  LoadingOverlay.show(context);
                                                  BlocProvider.of<WishlistBloc>(context).add(WishlistRemovedEvent(
                                                  item_code: info.product_code!,product_code: info.product_code!,context: context));
                                                  context.read<ProductRelatedBloc>().add(ProductRelatedWishListFlagReqEvent(
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
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5.0),
                                        child: Column(
                                          children: [
                                            ProductItem(
                                              name: info.product_name!,
                                              brand: "No brand",
                                              productCode: info.product_code,
                                              price: info.sell_price!,
                                              stockQuantity: info.stock_quantity!,
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
                    );
                  } else {
                    return Container();
                  }
                },
              ),

            ],
          ),
        ) : Center(child: Text("Product are not available....",style: GoogleFonts.poppins(
          fontSize: 15
        ),),),

        bottomNavigationBar: BlocBuilder<ThemeBloc,ThemeMode>(builder: (BuildContext context, state) {
         // Fluttertoast.showToast(msg: widget.stock_quantity.toString());
          final bool isDarkMode = state == ThemeMode.dark;
          final Color backgroundColor = isDarkMode ? Colors.black : Colors.white;
          final Color textColor = HiveStorage.hasPermission("Thememode") ? Colors.white : Colors.black;
          return widget.stock_quantity! > 0 ? Container(
           height: 47,
            padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
            decoration: BoxDecoration(

                border: Border(
                    top: BorderSide(width: .6,
                        color: Colors.grey))),
            child:  widget.productName!.isNotEmpty ?  BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
              builder: (BuildContext context, state) {
                if (state is ProductDetailsLoadingState) {
                  return Row(
                    children: [
                      Expanded(
                          child: InkWell(
                            onTap: () {
                              // BlocProvider.of<AddCartBloc>(context).add(
                              //     AddCartReqEvent(
                              //         productCode: widget.productCode,
                              //         price: "1200",
                              //         quantity: count.toString()));
                            },
                            child: Text('',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: textColor)),
                          )),
                      Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // context.read<CartBloc>().add(CartReqEvent(0));
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              backgroundColor: gPrimaryColor,
                              // Make button bg transparent
                              shadowColor: Colors.transparent, // Remove default shadow
                            ),
                            child: Text('Buy Now',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                          ))
                    ],
                  );
                } else if (state is ProductDetailsLoadedState) {
                  return Row(
                    children: [
                      if(state.productDetailsReqModel!.productDetailsResModel!.sell_price != "")...[
                        Expanded(
                            child: InkWell(
                              onTap : (){
                                LoadingOverlay.show(context);
                                BlocProvider.of<AddCartBloc>(context).add(
                                  AddCartReqEvent(
                                      productCode: widget.productCode,
                                      price: widget.sellingPrice?.toStringAsFixed(2),
                                      quantity: count.toString(),
                                      context: context
                                  ),
                                );
                                // Listen for state changes and then dispatch the cart event
                                BlocProvider.of<AddCartBloc>(context).stream.firstWhere((state) {
                                  // Define your condition for when the operation is complete
                                  return state is AddCartLoadedState; // or whatever your success state is
                                }).then((_) {
                                  context.read<CartBloc>().add(CartReqEvent(count:0,checkedCart:false));
                                });
                              },
                              child: Container(
                                color: Colors.orange,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style: GoogleFonts.poppins(
                                            fontSize: 14
                                        ),
                                        children: [
                                          TextSpan(
                                              text: 'Rs ',
                                              style: GoogleFonts.poppins(
                                                fontSize: 10,color: textColor )),
                                          TextSpan(
                                            text: state.sellPrice! == 0
                                                ? state.productDetailsReqModel!.productDetailsResModel!.sell_price!
                                                : state.sellPrice!.toStringAsFixed(2),
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: textColor,
                                              fontWeight: FontWeight.w600,

                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        LoadingOverlay.show(context);
                                        BlocProvider.of<AddCartBloc>(context).add(
                                          AddCartReqEvent(
                                              productCode: widget.productCode,
                                              price: widget.sellingPrice?.toStringAsFixed(2),
                                              quantity: count.toString(),
                                              context: context
                                          ),
                                        );
                                        // Listen for state changes and then dispatch the cart event
                                        BlocProvider.of<AddCartBloc>(context).stream.firstWhere((state) {
                                          // Define your condition for when the operation is complete
                                          return state is AddCartLoadedState; // or whatever your success state is
                                        }).then((_) {
                                          context.read<CartBloc>().add(CartReqEvent(count:0,checkedCart:false));
                                        });
                                        //   BlocProvider.of<CartBloc>(context).add(CartReqEvent(0));
                                      },
                                      child: Text('Add to cart',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,

                                            fontWeight: FontWeight.w600,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ]else ...[
                        Expanded(child: SizedBox())
                      ],

                      Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // First, get the context before any async operation
                              final currentContext = context;

                              // Then perform the async operations
                              Future(() async {
                                if (await GetAllPref.loginSuccess()) {
                                  if (addressResponseModel.addresses!.isNotEmpty) {
                                    if (!currentContext.mounted) return; // Check if widget is still in the tree
                                    Navigator.pushNamed(currentContext, orderDetailsPage, arguments: {
                                      'productCode': widget.productCode,
                                      'productName': widget.productName,
                                      'productImage': widget.productImage,
                                      'productQuantity': count.toString(),
                                      'productPrice': widget.sellingPrice?.toStringAsFixed(2),
                                      'shipping_cost': shipping_cost,
                                    });
                                  } else {
                                    if (!currentContext.mounted) return;
                                    CustomToast.showCustomRoast(
                                      context: currentContext,
                                      message: "Please first add address",
                                      icon: Bootstrap.check_circle,
                                      iconColor: Colors.red,
                                    );
                                    Navigator.pushNamed(currentContext, addressShow);
                                  }
                                } else {
                                  if (!currentContext.mounted) return;
                                  Navigator.pushNamed(currentContext, loginPath);
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              backgroundColor: gPrimaryColor,
                              // Make button bg transparent
                              shadowColor: Colors.transparent, // Remove default shadow
                            ),
                            child: Text('Buy Now',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                          ))
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ):SizedBox.shrink(),
          )
          :Container(
            height: 47,
            padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
            decoration: BoxDecoration(

                border: Border(
                    top: BorderSide(width: .6,
                        color: Colors.grey))),
            child:  widget.productName!.isNotEmpty ?  BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
              builder: (BuildContext context, state) {
                if (state is ProductDetailsLoadingState) {
                  return Row(
                    children: [
                      Expanded(
                          child: InkWell(
                            onTap: () {
                              // BlocProvider.of<AddCartBloc>(context).add(
                              //     AddCartReqEvent(
                              //         productCode: widget.productCode,
                              //         price: "1200",
                              //         quantity: count.toString()));
                            },
                            child: Text('',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: textColor)),
                          )),
                      Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // context.read<CartBloc>().add(CartReqEvent(0));
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              backgroundColor: gPrimaryColor,
                              // Make button bg transparent
                              shadowColor: Colors.transparent, // Remove default shadow
                            ),
                            child: Text('Buy Now',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                          ))
                    ],
                  );
                } else if (state is ProductDetailsLoadedState) {
                  return Row(
                    children: [
                      if(state.productDetailsReqModel!.productDetailsResModel!.sell_price != "")...[
                        Expanded(
                            child: Container(
                              color: Colors.orange,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: GoogleFonts.poppins(
                                          fontSize: 14
                                      ),
                                      children: [
                                        TextSpan(
                                            text: 'Rs ',
                                            style: GoogleFonts.poppins(
                                                fontSize: 10,color: textColor )),
                                        TextSpan(
                                          text: state.sellPrice! == 0
                                              ? state.productDetailsReqModel!.productDetailsResModel!.sell_price!
                                              : state.sellPrice!.toStringAsFixed(2),
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            color: textColor,
                                            fontWeight: FontWeight.w600,

                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      LoadingOverlay.show(context);
                                      BlocProvider.of<AddCartBloc>(context).add(
                                        AddCartReqEvent(
                                            productCode: widget.productCode,
                                            price: widget.sellingPrice?.toStringAsFixed(2),
                                            quantity: count.toString(),
                                            context: context
                                        ),
                                      );
                                      // Listen for state changes and then dispatch the cart event
                                      BlocProvider.of<AddCartBloc>(context).stream.firstWhere((state) {
                                        // Define your condition for when the operation is complete
                                        return state is AddCartLoadedState; // or whatever your success state is
                                      }).then((_) {
                                        context.read<CartBloc>().add(CartReqEvent(count:0,checkedCart:false));
                                      });
                                      //   BlocProvider.of<CartBloc>(context).add(CartReqEvent(0));
                                    },
                                    child: Text('Add to cart',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,

                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                ],
                              ),
                            )),
                      ]else ...[
                        Expanded(child: SizedBox())
                      ],

                      Expanded(
                          child: ElevatedButton(
                            onPressed: () {

                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              backgroundColor: gPrimaryColor,
                              // Make button bg transparent
                              shadowColor: Colors.transparent, // Remove default shadow
                            ),
                            child: Text('Out of stock',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                          ))
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ):SizedBox.shrink(),
          );
        },),
      ),
    );
  }

  Widget buildSizeChipGrid(Map<String, dynamic> attributes,String price) {
    final sizeEntries = attributes.entries
        .where((entry) => entry.key == 'size')
        .toList();
    final colorEntries = attributes.entries
        .where((entry) => entry.key == 'color')
        .toList();
    return
      GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // Disable scrolling inside
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1, // 4 chips per row
        crossAxisSpacing: 1, // Horizontal spacing
        mainAxisSpacing: 1, // Vertical spacing
        childAspectRatio: 1, // Width/height ratio (adjust as needed)
      ),
      itemCount: sizeEntries.length,
      itemBuilder: (context, index) {
        return Container(
          height: 100,
          width: 100,
         decoration: BoxDecoration(
            color: Colors.grey,
           borderRadius: BorderRadius.all(Radius.circular(100))
         ),
          child: InkWell(
            onTap: (){
              Fluttertoast.showToast(msg: price.toString());
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(sizeEntries[index].value.toString()),
                Text(colorEntries[index].value.toString()),
                const SizedBox(height: 3,),
                Text(price.toString()),
              ],
            ),
          ),
        );
      },
    );
  }


  Widget htmlShow1(String title,context,htmlText,bool flag){
    return Column(
      children: [
        InkWell(
        onTap: () {
          setState(() {
            _isExpanded1 = !flag;
          });
            },

          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(width: 1,color: Colors.grey.shade300),
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                 title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 17
                  ),
                ),
                Icon(
                  _isExpanded1
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.black,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded1) ...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Html(
              extensions: [
                TableHtmlExtension(
                ),
              ],
              data: htmlText,
              style: {
                "table": Style(
                  border: Border.all(color: Colors.grey),
                  margin: Margins.zero,
                  display: Display.inline,
                ),
                "th": Style(
                  fontWeight: FontWeight.bold,
                  border: Border.all(color: Colors.grey),
                  padding: HtmlPaddings.all(5),
                  backgroundColor: Colors.grey[200],
                  // width: Width(100), // Force header to fill cell width
                  display: Display.block, // Make header fill full width
                ),
                "td": Style(
                  padding: HtmlPaddings.all(8),
                  border: Border.all(color: Colors.grey),

                ),
                "tr": Style(
                  display: Display.inline, // Enable flex layout for equal distribution
                ),
              },
            ),
          ),

        ],
      ],
    );
  }
  Widget htmlShow2(String title,context,htmlText,bool flag){
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded2 = !flag;
            });
          },

          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(width: 1,color: Colors.grey.shade300),
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 17
                  ),
                ),
                Icon(
                  _isExpanded2
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.black,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded2) ...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: Html(
              extensions: [
                TableHtmlExtension(
                ),
              ],
              data: htmlText,

              style: {
                "table": Style(
                  border: Border.all(color: Colors.grey),
                  margin: Margins.zero,
                  display: Display.inline,
                ),
                "th": Style(
                  fontWeight: FontWeight.bold,
                  border: Border.all(color: Colors.grey),
                  padding: HtmlPaddings.all(5),
                  backgroundColor: Colors.grey[200],
                  // width: Width(100), // Force header to fill cell width
                  display: Display.block, // Make header fill full width
                ),
                "td": Style(
                  padding: HtmlPaddings.all(8),
                  border: Border.all(color: Colors.grey),

                ),
                "tr": Style(
                  display: Display.inline, // Enable flex layout for equal distribution
                ),
              },
            ),
          ),

        ],
      ],
    );
  }
  Widget htmlShow3(String title,context,htmlText,bool flag){

    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded3 = !flag;
            });
          },

          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(width: 1,color: Colors.grey.shade300),
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 17
                  ),
                ),
                Icon(
                  _isExpanded3
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.black,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded3) ...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Html(
              extensions: [
                TableHtmlExtension(
                ),
              ], data: htmlText,
              style: {
                "table": Style(
                  border: Border.all(color: Colors.grey),
                  margin: Margins.zero,
                  display: Display.inline,
                ),
                "th": Style(
                  fontWeight: FontWeight.bold,
                  border: Border.all(color: Colors.grey),
                  padding: HtmlPaddings.all(5),
                  backgroundColor: Colors.grey[200],
                 // width: Width(100), // Force header to fill cell width
                  display: Display.block, // Make header fill full width
                ),
                "td": Style(
                  padding: HtmlPaddings.all(8),
                  border: Border.all(color: Colors.grey), 
                  
                ),
                "tr": Style(
                  display: Display.inline, // Enable flex layout for equal distribution
                ),
              },
            ),
          ),

        ],
      ],
    );
  }
  Widget htmlShow4(String title,context,htmlText,bool flag){
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded4 = !flag;
            });
          },

          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(width: 1,color: Colors.grey.shade300),
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 17
                  ),
                ),
                Icon(
                  _isExpanded4
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.black,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded4) ...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Html(
              extensions: [
                TableHtmlExtension(
                ),
              ],
              data: htmlText,

              style: {
                "table": Style(
                  border: Border.all(color: Colors.grey),
                  margin: Margins.zero,
                  display: Display.inline,
                ),
                "th": Style(
                  fontWeight: FontWeight.bold,
                  border: Border.all(color: Colors.grey),
                  padding: HtmlPaddings.all(5),
                  backgroundColor: Colors.grey[200],
                  // width: Width(100), // Force header to fill cell width
                  display: Display.block, // Make header fill full width
                ),
                "td": Style(
                  padding: HtmlPaddings.all(8),
                  border: Border.all(color: Colors.grey),

                ),
                "tr": Style(
                  display: Display.inline, // Enable flex layout for equal distribution
                ),
              },
            ),
          ),

        ],
      ],
    );
  }

}

class ProductItem extends StatelessWidget {
  final String name;
  final String brand;
  final String price;
  final String? productCode;
  final int stockQuantity;

  const ProductItem({
    super.key,
    required this.name,
    required this.brand,
    required this.price,
    required this.productCode,
    required this.stockQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
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
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 14),
              children: [
                TextSpan(
                    text: 'Rs ',
                    style:
                        GoogleFonts.poppins(fontSize: 10,)),
                TextSpan(
                  text: price,
                  style: GoogleFonts.poppins(
                      fontSize: 17,
                      color: Colors.purple,
                      fontWeight: FontWeight.w600,
),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                itemSize: 12,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ignoreGestures: true, // <-- makes it read-only
                itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.green.shade800,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              Text("(0)",style: GoogleFonts.poppins(
                  fontSize: 8
              ),),
              Spacer(),
              InkWell(
                onTap: () {
                  if(stockQuantity > 0){
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


