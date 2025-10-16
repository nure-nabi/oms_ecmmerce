import 'dart:convert';

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
            height: 140,
            width: double.infinity,
          ),
        );
      }else if(state is BannerLoadedState){
        if( state.bannerResModel!.banners.isNotEmpty){
          return ImageSlideshow(
            indicatorColor: Colors.deepPurple,
            indicatorBackgroundColor: Colors.white,
            height: 140,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetails(
                            productCode: bannerImage.productCode!,
                            productName: bannerImage.products!.product_name!,
                            sellingPrice: double.parse(bannerImage.products!.sell_price!),
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
                            height: 200,
                            width: double.infinity,
                          ),
                        ),
                        // Image with loading builder
                        Image.network(
                          bannerImage.imageFullUrl!,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child; // Image has finished loading
                            } else {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  color: Colors.white,
                                  height: 200,
                                  width: double.infinity,
                                ),
                              ); // Show shimmer while loading
                            }
                          },
                        ),

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
