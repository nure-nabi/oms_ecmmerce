import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
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

    return BlocBuilder<BannerBloc,BannerState>(builder: (BuildContext context, state) {
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
          return ImageSlideshow(
            indicatorColor: Colors.deepPurple,
            indicatorBackgroundColor: Colors.white,
            height: MediaQuery.of(context).size.height * ScreenHieght.getHieght(context),
            autoPlayInterval: 3000,
            indicatorRadius: 4,
            indicatorBottomPadding: 1,
            isLoop: true,
            children: state.bannerResModel!.banners.map((bannerImage) {
              return InkWell(
                onTap: () {
                  CheckNetwork.check().then((network){
                    if(!network){
                      CustomToast.showCustomRoast(context:context, message: "No network found.", icon: Bootstrap.check_circle,iconColor: Colors.red);
                    }else{
                      if(bannerImage.products == null){
                     //   Fluttertoast.showToast(msg: "asdfsd");
                      }
                    //  final f = bannerImage.products!.product_name! ?? "f";
                    //  Fluttertoast.showToast(msg: bannerImage.products!.product_name! ?? "f");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetails(
                            productCode: bannerImage.productCode!,
                            stock_quantity: bannerImage.products!.stock_quantity,
                            productName:bannerImage.products != null ? bannerImage.products!.product_name! : "",
                            sellingPrice:bannerImage.products != null ? double.parse(bannerImage.products!.sell_price!) : 0,
                            productImage: bannerImage.imageFullUrl,
                            variation: 0,),
                        ),
                      );
                    }
                  });

                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10,top: 1),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1.0),
                    child: Stack(
                      children: [
                        // Shimmer effect as the placeholder
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height * 0.40,
                            width: double.infinity,
                          ),
                        ),
                        // Image with loading builder
                        CachedNetworkImage(
                          //imageUrl: info.products!.main_image_full_url != null ? info.products!.main_image_full_url! : info.products!.image_full_url!,
                          imageUrl:  bannerImage.imageFullUrl!,
                          height: MediaQuery.of(context).size.height * 0.40,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorWidget: (context, url, error) => Image.asset("assets/icons/noimage.jpg",fit: BoxFit.cover),
                        ),
                        // Image.network(
                        //   bannerImage.imageFullUrl!,
                        //   height: 200,
                        //   width: double.infinity,
                        //   fit: BoxFit.cover,
                        //   loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        //     if (loadingProgress == null) {
                        //       return child; // Image has finished loading
                        //     } else {
                        //       return Shimmer.fromColors(
                        //         baseColor: Colors.grey[300]!,
                        //         highlightColor: Colors.grey[100]!,
                        //         child: Container(
                        //           color: Colors.white,
                        //           height: 200,
                        //           width: double.infinity,
                        //         ),
                        //       ); // Show shimmer while loading
                        //     }
                        //   },
                        // ),

                      ],
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
    },);


  }
}
