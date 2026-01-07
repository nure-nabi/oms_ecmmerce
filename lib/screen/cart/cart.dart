import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/core/services/routeHelper/route_name.dart';
import 'package:oms_ecommerce/screen/address/model/address_model.dart';
import 'package:oms_ecommerce/screen/cart/bloc/cart_bloc.dart';
import 'package:oms_ecommerce/screen/cart/bloc/cart_event.dart';
import 'package:oms_ecommerce/screen/cart/bloc/cart_state.dart';
import 'package:oms_ecommerce/screen/cart/model/cart_model.dart';
import 'package:oms_ecommerce/screen/product/bloc/rec_product_bloc/rec_product_bloc.dart';
import 'package:oms_ecommerce/screen/product/bloc/rec_product_bloc/rec_product_state.dart';
import 'package:oms_ecommerce/screen/service/sharepref/get_all_pref.dart';
import 'package:oms_ecommerce/theme/theme_bloc.dart';

import '../../component/loading_overlay.dart';
import '../../core/constant/colors_constant.dart';
import '../../storage/hive_storage.dart';
import '../../utils/custome_toast.dart';
import '../address/bloc/address_bloc.dart';
import '../address/bloc/address_event.dart';
import '../address/bloc/address_state.dart';
import '../product/bloc/rec_product_bloc/rec_product_event.dart';
import '../product/component/latest_product.dart';
import '../product/product_details.dart';
import '../profile/block/profile_bloc/profile_bloc.dart';
import '../profile/block/profile_bloc/profile_event.dart';
import '../profile/block/profile_bloc/profile_state.dart';
import 'bloc/add_cart/add_cart_bloc.dart';
import 'bloc/add_cart/add_cart_event.dart';
import 'bloc/add_cart/add_cart_state.dart';

class CartPage extends StatefulWidget {
  final bool? leading;
  const CartPage({super.key,this.leading=false});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late AddressResponseModel addressResponseModel;
  int count=1;
  String userId = "";
  String shipping_cost = "0";

  bool checked = false;
  int selectedValue = 0;
  int billingId=0;
  int shoppingId=0;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      BlocProvider.of<CartBloc>(context).add(CartReqEvent(count:0,checkedCart:false));
      BlocProvider.of<RecProductBloc>(context).add(RecProductReqEvent());
      context.read<AddressBloc>().add(AddressReqEvent());
      context.read<ProfileBloc>().add(ProfileReqEvent());
      userIdShow();
    });

    super.initState();
  }

  userIdShow() async{
    userId =   await GetAllPref.userId();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: widget.leading!,
        //  backgroundColor: gPrimaryColor,
          elevation: 0,
          centerTitle: true,
          leading: InkWell(
            onTap: ()=>Navigator.pop(context),
              child: Icon(Bootstrap.chevron_left)),
          title:  Text("My Cart",style: GoogleFonts.poppins(
           fontSize: 20,
            letterSpacing: 1
          ),),
          actions: [
            TextButton(onPressed: ()async{

                if (await GetAllPref.loginSuccess()) {
                  LoadingOverlay.show(context);
                  BlocProvider.of<CartBloc>(context).add(CartItemsSelectAllEvent(checkedCart: checked));
                  setState(() {
                    checked = !checked; // Toggles between true/false
                  });
                }

            },
                child: Text(checked ? "UnSelect" : "Select All",style: GoogleFonts.poppins(
                  color: Colors.black,
                  letterSpacing: 1
                ),)
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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


              BlocConsumer<CartBloc,CartState>(builder: (BuildContext context, state) {

                if(state is CartLoadingState){

                  return Align(
                    alignment: Alignment.bottomCenter,
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
                }else if(state is CartLoadedState){
                  if(state.cartResModel!.cart!.items.length > 0){
                    return Stack(
                      children: [
                        ListView.builder(
                            itemCount: state.cartResModel!.cart!.items.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context ,index){
                              final info = state.cartResModel!.cart!.items[index];

                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5,right: 5,bottom: 10,top: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      //   const Checkbox(value: true, onChanged: null),
                                      Checkbox(
                                          value: state.checkedCart![index],
                                          checkColor: Colors.white,
                                          activeColor: Colors.orange,
                                          focusColor: Colors.grey,
                                          onChanged: (value){
                                            if(value!){

                                            LoadingOverlay.show(context);
                                           var cartValue =   CartProductModel(
                                                  product_code: state.cartResModel!.cart!.items[index].products!.product_code!,
                                                  product_name: state.cartResModel!.cart!.items[index].products!.product_name!,
                                                  actual_price: state.cartResModel!.cart!.items[index].products!.actual_price!,
                                                  sell_price: state.cartResModel!.cart!.items[index].products!.sell_price!,
                                                  mr_price: state.cartResModel!.cart!.items[index].products!.mr_price!,
                                                //  quantity: info.quantity.toString(),
                                                 stock_quantity: state.cartResModel!.cart!.items[index].products!.stock_quantity!,
                                                  quantity: state.qtyLits![index].toString(),
                                                  product_description: state.cartResModel!.cart!.items[index].products!.product_description!,
                                                  image_full_url: state.cartResModel!.cart!.items[index].products!.image_full_url!,
                                                  main_image_full_url: state.cartResModel!.cart!.items[index].products!.main_image_full_url!);

                                              //   state.tempCartList.add(cartValue);
                                              context.read<CartBloc>().add(CartItemCheckeEvent(index: index,checked: value,checkedValue: info.id.toString(),cartProductModel: cartValue));
                                            }else{
                                              LoadingOverlay.show(context);
                                              var cartValue =   CartProductModel(
                                                  product_code: state.cartResModel!.cart!.items[index].products!.product_code!,
                                                  product_name: state.cartResModel!.cart!.items[index].products!.product_name!,
                                                  actual_price: state.cartResModel!.cart!.items[index].products!.actual_price!,
                                                  sell_price: state.cartResModel!.cart!.items[index].products!.sell_price!,
                                                  mr_price: state.cartResModel!.cart!.items[index].products!.mr_price!,
                                                  quantity: state.qtyLits![index].toString(),
                                                  stock_quantity: state.cartResModel!.cart!.items[index].products!.stock_quantity!,
                                                  product_description: state.cartResModel!.cart!.items[index].products!.product_description!,
                                                  image_full_url: state.cartResModel!.cart!.items[index].products!.image_full_url!,
                                                  main_image_full_url: state.cartResModel!.cart!.items[index].products!.main_image_full_url!);
                                              context.read<CartBloc>().add(CartItemCheckeEvent(index: index,checked: value,checkedValue: info.id.toString(),cartProductModel: cartValue));
                                            }
                                          }),
                                      Expanded(
                                        flex:1,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(2),
                                          child: CachedNetworkImage(
                                            imageUrl: info.products!.main_image_full_url != "" ? info.products!.main_image_full_url! : info.products!.image_full_url!,
                                           // imageUrl: info.main_image!,
                                            height: 100,
                                            fit: BoxFit.cover,
                                            width: 70,
                                            errorWidget: (context, url, error) => Image.asset("assets/icons/noimage.jpg"),
                                          )
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      Expanded(
                                        flex:3,
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                             mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(info.products!.product_name!,maxLines: 2,overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(

                                                  ),),
                                                ),

                                                InkWell(
                                                    onTap: (){
                                                      LoadingOverlay.show(context);
                                                      BlocProvider.of<CartBloc>(context).add(CartItemRemoveByIdEvent(id: info.id!,checkedCart: false,context: context));
                                                    },
                                                    child:  const Icon(Bootstrap.trash,color: Colors.red,)),
                                              ],
                                            ),
                                            const SizedBox(height: 5,),
                                            Row(
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    style: TextStyle(color: Colors.black, fontSize: 14),
                                                    children: [
                                                      TextSpan(text: 'Rs ', style: GoogleFonts.poppins(
                                                          fontSize: 10,
                                                          color: Colors.black
                                                      )),
                                                      TextSpan(
                                                        text:  info.products?.sell_price!,
                                                        style: GoogleFonts.poppins(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w600,
                                                            color: Colors.orange,

                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 5,),
                                                RichText(
                                                  text: TextSpan(
                                                    style: TextStyle(color: Colors.black, fontSize: 14),
                                                    children: [
                                                      TextSpan(text: 'Rs ', style: GoogleFonts.poppins(
                                                          fontSize: 10,
                                                          color: Colors.black
                                                      )),
                                                      TextSpan(
                                                        text:  info.products!.actual_price,

                                                        style: GoogleFonts.poppins(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w600,
                                                            color: Colors.grey,
                                                            decoration: TextDecoration.lineThrough
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 5,),
                                            Row(
                                              children: [
                                                 Expanded(child:
                                                RichText(
                                                  text: TextSpan(
                                                    style: TextStyle(color: Colors.black, fontSize: 14),
                                                    children: [
                                                      TextSpan(text: 'Rs ', style: GoogleFonts.poppins(
                                                          fontSize: 10,
                                                          color: Colors.black
                                                      )),
                                                      TextSpan(
                                                        text: '(${double.parse(info.products!.actual_price.toString()) - double.parse(info.products!.sell_price.toString())})OFF',
                                                        style: GoogleFonts.poppins(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w600,
                                                            color: Colors.green.shade700,
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                                ),
                                                Expanded(
                                                    child: Row(
                                                  // crossAxisAlignment: CrossAxisAlignment.,
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    InkWell(
                                                        onTap: (){

                                                          LoadingOverlay.show(context);
                                                          context.read<CartBloc>().add(CartDecrementEvent(
                                                              count: state.qtyLits![index],
                                                              index: index,id: info.id!,
                                                              addOne: 1,updateFlag: true,
                                                          product_code: info.product_code));
                                                        },
                                                        child: SizedBox(
                                                          height: 30,
                                                          width: 30,
                                                          child: Container(

                                                              decoration: BoxDecoration(
                                                                  color: Colors.orange,
                                                                  borderRadius: BorderRadius.all(Radius.circular(50))
                                                              ),
                                                              child: const Icon(Bootstrap.dash,color: Colors.white,)),
                                                        )),
                                                    const SizedBox(width: 5,),
                                                    //Text(state.count.toString() =="0" ? info.quantity.toString() : state.count.toString()),
                                                    Text( state.qtyLits![index].toString()),
                                                    const SizedBox(width: 5,),
                                                    InkWell(
                                                        onTap: (){
                                                          LoadingOverlay.show(context);
                                                          context.read<CartBloc>().add(CartIncrementEvent(
                                                              count: state.qtyLits![index],
                                                              index: index,
                                                              id: info.id!,addOne: 1,
                                                              updateFlag: true,product_code: info.product_code));
                                                        },
                                                        child: Container(
                                                            height: 30,
                                                            width: 30,
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
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                        ),

                      ],
                    );
                  }else{
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 40),
                          Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey[400]),
                          const SizedBox(height: 20),
                          const Text(
                            'Oops!! Your cart is empty.',
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
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                             // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NavH()), (route)=>false);
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                homeNavbar,  // your named route
                                    (route) => false,  // predicate that removes all previous routes
                              );

                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: gPrimaryColor,
                              shadowColor: Colors.transparent,
                            ),
                            child: const Text(
                              'Continue Shopping',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }else if(state is CartErrorState){
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Text("You are not logedin!",style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600
                  ),),);
                }else{
                  return SizedBox.shrink();
                }
              }, listener: (BuildContext context, CartState state) {

                  if (state is CartLoadingState) {
                   // Fluttertoast.showToast(msg: "cart loading");
                  } else if (state is CartLoadedState) {
                  //  Fluttertoast.showToast(msg: "cart loaded");
                  } else if (state is CartErrorState) {
                    CustomToast.ScaffoldMessage(
                      context: context,
                      message: "You are not authorized!",
                      colors: Colors.red,
                    );
                  }

              },),
              SizedBox(height: 30,),
              //Recommended product
              // BlocConsumer<RecProductBloc,RecProductState>(builder: (
              //     BuildContext context, state) {
              //   if(state is RecProductLoadingState){
              //     return CircularProgressIndicator();
              //   }else
              //   if(state is RecProductLoadedState){
              //     return Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       mainAxisSize:  MainAxisSize.min,
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.symmetric(horizontal: 10),
              //           child: Text(
              //             "Recommended Products",
              //             style: GoogleFonts.poppins(
              //                 fontWeight: FontWeight.w600, fontSize: 18),
              //           ),
              //         ),
              //         Expanded(
              //           child: GridView.builder(
              //             padding: const EdgeInsets.symmetric(horizontal: 10),
              //             // Padding around the grid
              //             shrinkWrap: true,
              //             physics: const NeverScrollableScrollPhysics(),
              //             // Disable scrolling if nested
              //             gridDelegate:
              //             const SliverGridDelegateWithFixedCrossAxisCount(
              //               crossAxisCount: 2,
              //               mainAxisSpacing: 2,
              //               crossAxisSpacing: 2,
              //               childAspectRatio: 0.68,),
              //             itemCount: state.recommendedProductResModel!.products.length,
              //             // Total number of items
              //             itemBuilder: (BuildContext context, int index) {
              //               final info =
              //               state.recommendedProductResModel!.products[index];
              //               return InkWell(
              //                 onTap: () {
              //                   Navigator.push(
              //                     context,
              //                     MaterialPageRoute(
              //                       builder: (context) => ProductDetails(
              //                         productCode: info.product_code!,
              //                         productName: info.product_name!,
              //                         sellingPrice:
              //                         double.parse(info.sell_price!),
              //                         productImage: info.image_full_url,
              //                         variation: info.has_variations,
              //                       ),
              //                     ),
              //                   );
              //                 },
              //                 child: Container(
              //                   decoration: const BoxDecoration(
              //                       color: Colors.white60,
              //                       borderRadius:
              //                       BorderRadius.all(Radius.circular(10))),
              //                   child: Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       Stack(
              //                         children: [
              //                           ClipRRect(
              //                             borderRadius: const BorderRadius.only(
              //                               topRight: Radius.circular(5),
              //                               topLeft: Radius.circular(5),
              //                             ),
              //                             child: CachedNetworkImage(
              //                               imageUrl: info.image_full_url!,
              //                               width: 200,
              //                               height: 140,
              //                               fit: BoxFit.cover,
              //                               placeholder: (context, url) =>
              //                                   Container(),
              //                               errorWidget: (context, url, error) =>
              //                                   Icon(Icons.error),
              //                             ),
              //                             // child: Image.network(
              //                             //   info.image_full_url!,
              //                             //   width: 200,
              //                             //   height: 140,
              //                             //   fit: BoxFit.cover,
              //                             // ),
              //                           ),
              //                           Positioned(
              //                             top: 5,
              //                             right: 5,
              //                             child: Container(
              //                               height: 30,
              //                               width: 30,
              //                               padding: const EdgeInsets.all(7),
              //                               decoration: BoxDecoration(
              //                                 borderRadius: BorderRadius.circular(
              //                                     100),
              //                                 color: gPrimaryColor,
              //                               ),
              //                               child: Icon(Bootstrap.heart, size: 15,
              //                                   color: Colors.white),
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                       SizedBox(
              //                         height: 10,
              //                       ),
              //                       // Product list
              //                       Padding(
              //                         padding:
              //                         EdgeInsets.symmetric(horizontal: 5.0),
              //                         child: Column(
              //                           children: [
              //                             ProductCartItem(
              //                               name: info.product_name!,
              //                               brand: "Product's brand",
              //                               price: info.sell_price!,
              //                               variation: info.has_variations.toString(),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //
              //                     ],
              //                   ),
              //                 ),
              //               );
              //             },
              //           ),
              //         ),
              //       ],
              //     );
              //   }else{
              //     return SizedBox.shrink();
              //   }
              // },
              //   listener: (BuildContext context, Object? state) {  },)
            ],
          ),
        ),
      
        bottomNavigationBar: BlocBuilder<ThemeBloc,ThemeMode>(builder: (BuildContext context, state) {
          final bool isDarkMode = state == ThemeMode.dark;
          final Color backgroundColor = isDarkMode ? Colors.black : Colors.white;
          final Color textColor = HiveStorage.hasPermission("Thememode") ? Colors.white : Colors.black;
          return Container(
            height: 60,
            // color: Colors.white, // Important for visibility
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: BlocBuilder<CartBloc,CartState>(
                    builder: (BuildContext context, state) {
                      // if (state is CartLoadingState) {
                      //   return Text("00.00");
                      // } else
                      if (state is CartLoadedState) {
                        return   RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Total: ',
                                  style: GoogleFonts.poppins(
                                    color: textColor,
                                    fontSize: 16,
                                  )
                              ),
                              TextSpan(
                                  text:
                                  'Rs.${state.totalAmount}',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                      color: textColor
                                  )
                              )
                            ]));
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
                BlocBuilder<CartBloc,CartState>(builder: (BuildContext context, state) {
                  if(state is CartLoadedState){
                    return ElevatedButton(
                      onPressed: () {
                        var currentContext = context;

                        Future(()async{
                          if(await GetAllPref.loginSuccess()){
                            if(addressResponseModel.addresses!.isNotEmpty){
                              if(state.checkedValue != null && state.checkedValue!.length > 0){
                                if (!currentContext.mounted) return;
                                Navigator.pushNamed(currentContext, orderCartDetailsPage,
                                  arguments:{
                                    'checkedValue': state.checkedValue,
                                    'tempCartList': state.tempCartList,
                                    'addressResponseModel': addressResponseModel,
                                    'shipping_cost': shipping_cost,
                                  },
                                );
                                // context.read<CartBloc>().add(CartItemsBuyEvent(
                                //     payment_method:  "C" ,
                                //     billing_address: "4",
                                //     shipping_address: "7",
                                //     invoice_email: "nure09@gmail.com",
                                //     subtotal: "1400",
                                //     shipping: "2",
                                //     grandtotal: "200",
                                //   selected_items:state.checkedValue,
                                //     context: context));
                              }else{
                                if (!currentContext.mounted) return;
                                CustomToast.showCustomRoast(context:currentContext, message: "Add or checked items",
                                    icon: Bootstrap.check_circle,iconColor: Colors.red);
                              }
                            }else{
                              if (!currentContext.mounted) return;
                              Navigator.pushNamed(currentContext, addressShow);
                            }
                          }else{
                            if (!currentContext.mounted) return;
                            Navigator.pushNamed(currentContext, loginPath);
                          }
                        });

                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: gPrimaryColor,
                        shadowColor: Colors.transparent,
                      ),
                      child: Text('Buy Now',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    );
                  }else if(state is CartErrorState){
                    return ElevatedButton(
                      onPressed: () {
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: gPrimaryColor,
                        shadowColor: Colors.transparent,
                      ),
                      child: Text('Buy Now',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    );
                  }else{
                    return Container();
                  }
                },)
              ],
            ),
          );
        },),
      ),
    );
  }
}
class ProductCartItem extends StatelessWidget {
  final String name;
  final String brand;
  final String price;
  final String? productCode;
  final String? variation;

  const ProductCartItem({
    super.key,
    required this.name,
    required this.brand,
    required this.price,
    this.productCode,
    this.variation,
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
                initialRating: 3,
                minRating: 1,
                itemSize: 15,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              Spacer(),
              if(variation! == "0")
                Expanded(
                    child: InkWell(
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
                        width: 25,
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100), // Fully circular
                          color: gPrimaryColor,
                        ),
                        child: Icon(Bootstrap.cart,size: 15,color: Colors.white,),
                      ),
                    ))

            ],
          ),
        ],
      ),
    );
  }
}