import 'package:cached_network_image/cached_network_image.dart';
import 'package:connect_ips_flutter/connect_ips_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/core/constant/colors_constant.dart';
import 'package:oms_ecommerce/screen/brand/brand_widget.dart';
import 'package:oms_ecommerce/screen/flash_salse/flash_sale_home_widget.dart';
import 'package:oms_ecommerce/scroll/scroll_bloc.dart';
import 'package:oms_ecommerce/scroll/scroll_event.dart';
import 'package:oms_ecommerce/scroll/scroll_state.dart';
import 'package:oms_ecommerce/storage/hive_storage.dart';

import '../../component/drawer.dart';
import '../../component/loading_overlay.dart';
import '../../core/services/routeHelper/route_name.dart';
import '../../utils/alert_dialog_show_daily.dart';
import '../../utils/custome_toast.dart';
import '../banner/product_slider_image.dart';
import '../banner/promotion_slider_image.dart';
import '../brand/bloc/brand_bloc.dart';
import '../brand/bloc/brand_event.dart';
import '../cart/bloc/cart_bloc.dart';
import '../cart/bloc/cart_event.dart';
import '../cart/bloc/cart_state.dart';
import '../cart/cart.dart';
import '../category/category_home.dart';
import '../category/category_home_widget.dart';
import '../product/bloc/product_bloc/product_list_bloc.dart';
import '../product/bloc/product_bloc/product_list_event.dart';
import '../product/bloc/product_bloc/product_list_state.dart';
import '../product/component/latest_product.dart';
import '../product/component/random_wise_product_home.dart';
import '../product/feature_produdct_home_widget.dart';
import '../product/product_details.dart';
import '../product/product_list.dart';
import '../product/product_list_home.dart';
import '../profile/block/profile_bloc/profile_bloc.dart';
import '../profile/block/profile_bloc/profile_event.dart';
import '../service/sharepref/get_all_pref.dart';
import '../widget/scrolling.dart';
import '../wish_list/bloc/wishlist_bloc.dart';
import '../wish_list/bloc/wishlist_event.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin{
  final ScrollController _scrollController = ScrollController();
  double _lastScrollOffset = 0;
  bool _showToastOnScrollUp = false;
  Color whiteColor = Color(0xffFFFFFF);
  Color blueColor = Color(0xff003466);

  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(HiveStorage.get(UserKey.offerActive.name) == "1"){
        showFlashSaleAlert(context);
      }

    });
    context.read<CartBloc>().add(CartReqEvent(count:0,checkedCart:false));
    context.read<ProfileBloc>().add(ProfileReqEvent());
    _scrollController.addListener(_scrollListener);
  //  initPlatformState();
    super.initState();
  }
  void _scrollListener() {
    final currentOffset = _scrollController.offset;
    final isScrollingUp = currentOffset > _lastScrollOffset;

    // Show toast only when scrolling up and crossing a threshold
    if (isScrollingUp && currentOffset > 60 && !_showToastOnScrollUp) {
        _showToastOnScrollUp = true;
        context.read<ScrollBloc>().add(ScrollReqEvent(scrollFlag: _showToastOnScrollUp));
    }
    // Reset when scrolling down again
    else if (!isScrollingUp) {
      _showToastOnScrollUp = false;
      context.read<ScrollBloc>().add(ScrollReqEvent(scrollFlag: _showToastOnScrollUp));
    }

    _lastScrollOffset = currentOffset;
  }

  String _imeiNo="";
  // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initPlatformState() async {
  //   late String platformVersion,
  //       imeiNo = '',
  //       modelName = '',
  //       manufacturer = '',
  //       deviceName = '',
  //       productName = '',
  //       cpuType = '',
  //       hardware = '';
  //   var apiLevel;
  //   // Platform messages may fail,
  //   // so we use a try/catch PlatformException.
  //   try {
  //
  //     platformVersion = await DeviceInformation.platformVersion;
  //
  //     imeiNo = await DeviceInformation.deviceIMEINumber;
  //     modelName = await DeviceInformation.deviceModel;
  //     manufacturer = await DeviceInformation.deviceManufacturer;
  //     apiLevel = await DeviceInformation.apiLevel;
  //     deviceName = await DeviceInformation.deviceName;
  //     productName = await DeviceInformation.productName;
  //     cpuType = await DeviceInformation.cpuName;
  //     hardware = await DeviceInformation.hardware;
  //
  //   } on PlatformException catch (e) {
  //     platformVersion = '${e.message}';
  //   }
  //
  //
  //
  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;
  //
  //    setState(() {
  //   //   _platformVersion = "Running on :$platformVersion";
  //      _imeiNo = imeiNo;
  //   //   _modelName = modelName;
  //   //   _manufacturerName = manufacturer;
  //   //   _apiLevel = apiLevel;
  //   //   _deviceName = deviceName;
  //   //   _productName = productName;
  //   //   _cpuType = cpuType;
  //   //   _hardware = hardware;
  //    });
  //  // Fluttertoast.showToast(msg: _imeiNo.toString());
  // }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  backgroundColor: Color(0xffEBF0F1),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: BlocBuilder<ScrollBloc,ScrollState>(builder: (BuildContext context, state) {
         if(state is ScrollLoadingState){
           return AppBar(
             bottomOpacity: 55,
             centerTitle: true,
             title: Row(
               children: [
                 Align(
                   alignment: Alignment.center,
                   child: Text("Garg Dental",style: GoogleFonts.poppins(
                     letterSpacing: 2,
                     fontWeight: FontWeight.w600,
                     // color: Colors.blueAccent
                   ),),
                 ),
                 Spacer(),
                 InkWell(
                     onTap:() =>Navigator.pushNamed(context, searchScreenPath),
                     child: Icon(Bootstrap.search,size: 20,)),
                 SizedBox(width: 10,),
                 getCartData(false)
               ],
             ),
             elevation: 0,
            // backgroundColor: Colors.lightBlue,
           );
         }else if(state is ScrollLoadedState){
           return AppBar(
             bottomOpacity: 55,
             centerTitle: true,
             title:
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Align(
                   alignment: Alignment.center,
                   child: Text("Garg Dental",style: GoogleFonts.poppins(
                     letterSpacing: 2,
                     fontWeight: FontWeight.w600,
                    // color: Colors.blueAccent
                   ),),
                 ),
                 Spacer(),
                 InkWell(
                   onTap:() =>Navigator.pushNamed(context, searchScreenPath),
                     child: Icon(Bootstrap.search,size: 20,)),
                 SizedBox(width: 10,),
                 getCartData(state.scrollFlag)
               ],
             ),
             elevation: 0,
           //  backgroundColor: state.scrollFlag ? whiteColor : blueColor,
           );
         }else{
           return AppBar(
             bottomOpacity: 55,
             centerTitle: true,
             title:
             // Text("Garg Dental",style: GoogleFonts.poppins(
             //
             // ),),

             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 // Expanded(
                 //   child: Padding(
                 //     padding: const EdgeInsets.symmetric(horizontal: 0),
                 //     child: Container(
                 //       height: 40,
                 //       decoration: BoxDecoration(
                 //         border: Border.all(width: 1, color: Colors.grey.shade400),
                 //         borderRadius: const BorderRadius.all(Radius.circular(3)),
                 //         color: Colors.white.withOpacity(0.2),
                 //       ),
                 //       child: TextFormField(
                 //         readOnly: true,
                 //         decoration: InputDecoration(
                 //           hintText: 'Search products',
                 //           // suffixText: 'Search',
                 //           // Suffix text
                 //           border: InputBorder.none,
                 //           prefixIcon: const Icon(
                 //             EvaIcons.search,
                 //             size: 20,
                 //           ),
                 //           prefixIconColor: Colors.grey,
                 //           hintStyle: const TextStyle(color: Colors.grey),
                 //           suffixStyle: const TextStyle(color: Colors.white),
                 //           filled: true,
                 //           fillColor: gPrimaryColor.withOpacity(0.2), // Fill color of the TextField
                 //         ),
                 //         style: const TextStyle(color: Colors.black),
                 //         onTap: () {
                 //         Navigator.pushNamed(context, searchScreenPath);
                 //        // Navigator.pushNamed(context, paymentConnectipsPage);
                 //         },
                 //       ),
                 //     ),
                 //   ),
                 // ),
                 Align(
                   alignment: Alignment.center,
                   child: Text("Garg Dental",style: GoogleFonts.poppins(
                     letterSpacing: 2,
                     fontWeight: FontWeight.w600,
                     // color: Colors.blueAccent
                   ),),
                 ),
                 Spacer(),
                 InkWell(
                     onTap:() =>Navigator.pushNamed(context, searchScreenPath),
                     child: Icon(Bootstrap.search,size: 20,)),
                 SizedBox(width: 10,),
                 getCartData(true)
               ],
             ),
             elevation: 0,
             //  backgroundColor: state.scrollFlag ? whiteColor : blueColor,
           );
         }
        },),
      ),
      drawer: DrawerShow(),
      body:  SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.only(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Location Section
              // Container(
              //   height: 60,
              //   width: MediaQuery.of(context).size.width,
              //   color:  Color(0xff003466),
              // //  color:  Colors.grey,
              //   child: Padding(
              //     padding: const EdgeInsets.only(top: 4,left: 8,right: 15),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Expanded(child:
              //         Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //           Text("Your Location",style: GoogleFonts.poppins(
              //              color: Colors.white
              //           ),),
              //           Row(
              //             children: [
              //              // Icon(Icons.location_pin,color: Colors.white,),
              //               const Icon(Bootstrap.geo_alt,color: Colors.white,size: 20,),
              //               Text("Kathmandu",style: GoogleFonts.poppins(
              //                   color: Colors.white
              //               ),),
              //             ],
              //           ),
              //         ],)),
              //         // Container(
              //         //   height: 50,
              //         //   width: 50,
              //         //   padding: const EdgeInsets.all(10),
              //         //   decoration: BoxDecoration(
              //         //     borderRadius: BorderRadius.circular(5), // Fully circular
              //         //     color: Colors.white,
              //         //     boxShadow: [
              //         //       BoxShadow(
              //         //         color: Colors.grey.withOpacity(0.3), // Grey shadow
              //         //         spreadRadius: 2, // How far the shadow spreads
              //         //         blurRadius: 3, // How soft the shadow is
              //         //         offset: const Offset(0, 2), // Shadow position (x,y)
              //         //       ),
              //         //     ],
              //         //   ),
              //         //   child: const Icon(Bootstrap.bell_fill,color:  Color(0xff003466),size: 20,),
              //         // )
              //       ],
              //     ),
              //   ),
              // ),

              // Categories Section
              // Container(
              //   margin: EdgeInsets.only(top: 10),
              //   padding: EdgeInsets.only(left: 10,right: 10),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       const Text(
              //         'Categories',
              //         style: TextStyle(
              //           fontSize: 18,
              //           fontWeight: FontWeight.bold,
              //           color:  Color(0xff003466)
              //         ),
              //       ),
              //       const Text(
              //         'See All',
              //         style: TextStyle(
              //           fontSize: 16,
              //           fontWeight: FontWeight.bold,
              //           color:  Color(0xff003466)
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 16),
              // GridView.builder(
              //   padding: EdgeInsets.only(left: 10,right: 10),
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 5,
              //     mainAxisSpacing: 2,
              //     crossAxisSpacing: 2,
              //     childAspectRatio: 0.87,
              //   ),
              //   itemCount: 5,
              //   itemBuilder: (BuildContext context, int index) {
              //     return  _buildCategoryChip('Prescription');
              //   },
              //
              // ),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 10),
              //     child: Row(
              //       children: [
              //         _buildCategoryChip('Prescription'),
              //         SizedBox(width: 16,),
              //         _buildCategoryChip('Supplements'),
              //         SizedBox(width: 16,),
              //         _buildCategoryChip('Injections'),
              //         SizedBox(width: 15,),
              //         _buildCategoryChip('OTC'),
              //         SizedBox(width: 16,),
              //         _buildCategoryChip('Media'),
              //
              //
              //       ],
              //     ),
              //   ),
              // ),
              const ProductBannerImageSlider(),
              const SizedBox(height: 10,),
              const CategoryHomeWidget(),
              const SizedBox(height: 0,),
              const BrandWidget(),


               const LatestProduct(),
               const FlashSaleHomeWidget(),
             // const FeatureProdudctHomeWidget(title: "Today Deals", one: Colors.blue, two: Colors.black,),
              // FeatureProdudctHomeWidget(title: "Weekly Product",one: Colors.cyan, two: Colors.black,),
               //const ScrollingImages(),
              const PromotionSliderImage(),
              const SizedBox(height: 10,),
             // ALL PRODUCT
              RandomWiseProductHome()
             // ProductListHome(scrollController: _scrollController,)

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
   return Column(
     children: [
       Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), // Fully circular
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3), // Grey shadow
                //spreadRadius: 2, // How far the shadow spreads
                blurRadius: 3, // How soft the shadow is
               // offset: const Offset(0, 2), // Shadow position (x,y)
              ),
            ],
          ),
          child: Icon(Bootstrap.tablet,size: 20,color: Color(0xffFF9600),),
        ),
       SizedBox(height: 5,),
       Text(label,style: GoogleFonts.poppins(
         fontSize: 12
       ),)
     ],
   );
  }

  Widget _buildProductCard(BuildContext context,String name, String price, double rating) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Stack(
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:  Center(
                      child:
                      Image.network("https://garg.omsok.com/storage/app/public/backend/productimages/A100001/fleximeter_strips_blue.jpeg",width: MediaQuery.of(context).size.width,)
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Icon(Bootstrap.heart_fill,color: Color(0xff003466))),
              ],
            ),
            Divider(color: Colors.grey[400],thickness: 2,),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 4),
            Text(
              price,
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const Icon(Icons.star, color: Colors.amber, size: 16),
                Icon(Icons.star_half, color: Colors.amber[300], size: 16),
                const SizedBox(width: 4),
                Text(
                  '($rating)',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Spacer(),
                Expanded(child: Icon(Bootstrap.plus_circle_fill,color: Color(0xff003466),))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getCartData(bool flag){
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: (){
        Navigator.pushNamed(context, cartPage,
          arguments: true
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            icon: Icon(Bootstrap.cart,),
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
                 //   backgroundColor: Colors.red,
                    radius: 10,
                    child: Text(
                      state.cartResModel!.cart!.items.length.toString(),
                      style: const TextStyle(
                       // color: Colors.white,
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