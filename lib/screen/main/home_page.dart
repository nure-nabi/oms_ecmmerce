import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_carousel_slider/image_carousel_slider.dart';
import 'package:flutter_image_carousel_slider/list_image_view.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/core/constant/asstes_list.dart';
import 'package:oms_ecommerce/core/services/routeHelper/route_name.dart';
import 'package:oms_ecommerce/screen/banner/banner_bloc/banner_bloc.dart';
import 'package:oms_ecommerce/screen/banner/banner_bloc/banner_event.dart';
import 'package:oms_ecommerce/screen/banner/banner_bloc/banner_state.dart';
import 'package:oms_ecommerce/screen/widget/gredient_container.dart';
import 'package:oms_ecommerce/utils/whatsapp.dart';

import '../../core/constant/colors_constant.dart';
import '../banner/product_slider_image.dart';
import '../cart/bloc/cart_bloc.dart';
import '../cart/bloc/cart_state.dart';
import '../cart/cart.dart';
import '../category/category_home.dart';
import '../product/component/latest_product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

    bool _showAppBar = true;

    List<String> imageList = [

      "https://help.rangeme.com/hc/article_attachments/360006928633/what_makes_a_good_product_image.jpg",
      "https://help.rangeme.com/hc/article_attachments/360006928633/what_makes_a_good_product_image.jpg",
    ];

    List<Map<String,dynamic>> listValue = [
      {
        "name":'Men',
        "url":"https://help.rangeme.com/hc/article_attachments/360006928633/what_makes_a_good_product_image.jpg"
      },
      {
        "name":'Women',
        "url":"https://assets.turbologo.com/blog/en/2021/09/10094210/product-photo-1.png"      },
      {
        "name":'Sport',
        "url":"https://images.unsplash.com/photo-1505740420928-5e560c06d30e?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZHVjdHxlbnwwfHwwfHx8MA%3D%3D"
      },
      {
        "name":'Groccery',
        "url":"https://assets.turbologo.com/blog/en/2021/09/10094210/product-photo-1.png"
      },
      {
        "name":'Men',
        "url":"https://help.rangeme.com/hc/article_attachments/360006928633/what_makes_a_good_product_image.jpg"
      },
      {
        "name":'Women',
        "url":"https://assets.turbologo.com/blog/en/2021/09/10094210/product-photo-1.png"      },
      {
        "name":'Sport',
        "url":"https://images.unsplash.com/photo-1505740420928-5e560c06d30e?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZHVjdHxlbnwwfHwwfHx8MA%3D%3D"
      },
      {
        "name":'Groccery',
        "url":"https://assets.turbologo.com/blog/en/2021/09/10094210/product-photo-1.png"
      },

    ];

    int _currentIndex = 0;
    final PageController _pageController = PageController();

    @override
    void dispose() {
      _pageController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      BlocProvider.of<BannerBloc>(context).add(BannerReqEvent());
      getCartData();
      return Scaffold(
        appBar:  AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: gPrimaryColor,
          elevation: 0,
          title: SizedBox(
            height: 40,
            child: TextFormField(
              readOnly: true,
              enableInteractiveSelection: true, // Prevents text selection
              onTap: (){
                Navigator.pushNamed(context, productSearch);
              },
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.red,width: 0.5),
                ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue,width: 0.5), // Optional: focus color
                  ),
                contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 5), // Adjust this value as needed
              ),
            ),
          ),
          actions: [
           // Icon(Bootstrap.bell_fill,size: 22,),
            getCartData(),
            SizedBox(width: 10,)

          ],
        ),
        backgroundColor: gPrimaryColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(0),
            child: Column(
              children: [
                ProductBannerImageSlider(),
                // InkWell(
                //   onTap: () {
                //     Navigator.of(context)
                //         .push(MaterialPageRoute(
                //         builder: (context) {
                //           return ImageListView(
                //             imageList: imageList,
                //           );
                //         }));
                //
                //   },
                //   child: BlocBuilder<BannerBloc,BannerState>(builder: (BuildContext context, state) {
                //     if(state is BannerLoadingState){
                //       return CircularProgressIndicator();
                //     }else if(state is BannerLoadedState){
                //       Fluttertoast.showToast(msg: state.bannerResModel?.banners.length.toString() ?? "");
                //       return ImageCarouselSlider(
                //         items: imageList,
                //         imageHeight: 200,
                //         dotColor: Colors.red,
                //       );
                //     }else{
                //       return Container();
                //     }
                //   },),
                // ),
                CategoryHome(),
                SizedBox(height: 0,),
                LatestProduct()
              ],
            ),
          ),
        ),

      );
    }

    Widget getCartData(){
      return InkWell(
        onTap: (){},
        child: Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: Icon(Bootstrap.cart),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CartPage(
                          leading: true,
                        )));
              },
            ),
            Positioned(
              right: 8,
              top: 8,
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if(state is CartLoadingState){
                    return const CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 10,
                      child: Text(
                        '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    );
                  }else if(state is CartLoadedState){
                    return CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 10,
                      child: Text(
                        '${state.cartLenght.toString()}',
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

class CategoryChip extends StatelessWidget {
  final String label;

  const CategoryChip({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Chip(
        label: Text(label),
        backgroundColor: Colors.grey[200],
      ),
    );
  }
}