import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/screen/product/product_details.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/check_network.dart';
import '../../utils/custome_toast.dart';
import '../../utils/hieght_width_map.dart';
import 'banner_bloc/banner_bloc.dart';
import 'banner_bloc/banner_event.dart';
import 'banner_bloc/banner_state.dart';



class ProductBannerImageSlider extends StatefulWidget {
  const ProductBannerImageSlider({super.key});

  @override
  State<ProductBannerImageSlider> createState() => _ProductBannerImageSliderState();
}

class _ProductBannerImageSliderState extends State<ProductBannerImageSlider> {

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BannerBloc>(context).add(BannerReqEvent());

    return Container(
      margin: EdgeInsets.only(top: 8),
      child: BlocBuilder<BannerBloc,BannerState>(builder: (BuildContext context, state) {
        if(state is BannerLoadingState){
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              color: Colors.white,
              height: 200,
              width: double.infinity,
            ),
          );
        }else if(state is BannerLoadedState){
          if( state.bannerResModel!.banners.isNotEmpty){
            final double bannerHeight =
                MediaQuery.of(context).size.width * ScreenHieght.getHieght(context); // 2:1 ratio
            return  CarouselSlider(
              options: CarouselOptions(
                height:bannerHeight ,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5
                ),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
               // autoPlayCurve: Curves.fastOutSlowIn,
                viewportFraction: 0.8,
               // viewportFraction: 2, // full width
                enlargeCenterPage: true,
              ),
              items: state.bannerResModel!.banners.map((bannerImage) {
                return InkWell(
                  onTap: (){
                    // CheckNetwork.check().then((network){
                    //   if(!network){
                    //     CustomToast.showCustomRoast(context:context, message: "No network found.", icon: Bootstrap.check_circle,iconColor: Colors.red);
                    //   }else{
                    //     if(bannerImage.products == null){
                    //       //   Fluttertoast.showToast(msg: "asdfsd");
                    //     }
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => ProductDetails(
                    //           productCode: bannerImage.productCode!,
                    //           stock_quantity: bannerImage.products!.stock_quantity,
                    //           productName:bannerImage.products != null ? bannerImage.products!.product_name! : "",
                    //           sellingPrice:bannerImage.products != null ? double.parse(bannerImage.products!.sell_price!) : 0,
                    //           productImage: bannerImage.imageFullUrl,
                    //           variation: 0,),
                    //       ),
                    //     );
                    //   }
                    // });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedNetworkImage(
                        imageUrl: bannerImage.mobile_image_full_url!,
                        width: double.infinity,
                        height: (bannerHeight),
                        fit: BoxFit.fill, // no stretch
                        placeholder: (context, _) =>
                            Container(color: Colors.grey.shade200),
                        errorWidget: (context, _, __) =>
                            Image.asset(
                              "assets/icons/gargimage.png",
                              fit: BoxFit.fill,
                            ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }else{
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                color: Colors.white,
                height: 200,
                width: double.infinity,
              ),
            );
          }

        }else{
          return Container();
        }
      },),
    );


  }
}
