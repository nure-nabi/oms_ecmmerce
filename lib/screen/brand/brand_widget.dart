import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/core/constant/colors_constant.dart';
import 'package:oms_ecommerce/core/services/routeHelper/route_name.dart';
import 'package:oms_ecommerce/screen/brand/bloc/brand_bloc.dart';
import 'package:oms_ecommerce/screen/brand/bloc/brand_event.dart';
import 'package:oms_ecommerce/screen/brand/bloc/brand_state.dart';
import 'package:oms_ecommerce/screen/brand/brand_product.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/check_network.dart';
import '../../utils/custome_toast.dart';
import 'bloc/brand_wise_products_bloc/brand_wise_products_bloc.dart';
import 'bloc/brand_wise_products_bloc/brand_wise_products_event.dart';

class BrandWidget extends StatefulWidget {
  const BrandWidget({super.key});

  @override
  State<BrandWidget> createState() => _BrandWidgetState();
}

class _BrandWidgetState extends State<BrandWidget> {

  @override
  void initState() {
   WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<BrandBloc>().add(BrandReqEvent());
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<BrandBloc,BrandState>(
      builder: (BuildContext context, BrandState state) {
        if(state is BrandLoadingState){
          return Padding(
            padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 10,
                    width: 100,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 7,),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.18,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => SizedBox(width: 10,),
                    itemCount: 5,
                    itemBuilder: (context ,index){
                      return _buildBrandChipShimmerUser();
                    },
                  ),
                ),

              ],
            ),
          );
        }else if(state is BrandLoadedState){
       //   Fluttertoast.showToast(msg: 'bRAND ${state.brandLists!.length.toString()}');
          return state.brandResponse!.brands!.isNotEmpty ? Padding(
              padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Top Brands",style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
               //   color: gPrimaryColor,
                  fontSize: 18
                ),),
                SizedBox(height: 7,),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.18,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => SizedBox(width: 10,),
                    itemCount: state.brandResponse!.brands!.length,
                    itemBuilder: (context ,index){
                      var info = state.brandResponse!.brands![index];
                      return _buildBrandChip(info.id!.toInt(),info.brand_name!,info.image_full_url!);
                    },
                  ),
                ),

              ],
            ),
          ) : SizedBox.shrink();
        }else{
          return Container();
        }
      },
      listener: (BuildContext context, BrandState state) {  },
       );
  }

  Widget _buildBrandChip(int brandId,String label,String imageUrl) {
    return InkWell(
      onTap: (){
        CheckNetwork.check().then((network){
          if(!network){
            CustomToast.showCustomRoast(context:context, message: "No network found.", icon: Bootstrap.check_circle,iconColor: Colors.red);
          }else{
            Navigator.pushNamed(context, brandProductListPage,
                arguments: brandId
            );
          }
        });

        // Then call the event:
        // context.read<BrandWiseProductsBloc>().add(BrandWiseProductsReqEvent(
        //     limit: 20,
        //     offset: 0,
        //     brandId: brandId));

      },
      child: Column(
        children: [
          Container(
            //height: MediaQuery.of(context).size.height * 0.15,
            height: 130,
            width: 130,
            decoration: BoxDecoration(
              // shape: BoxShape.circle, // This makes the container perfectly circular
              color: Colors.white,
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.fill,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 3,
                ),
              ],
            ),
            // child: ClipOval( // ClipOval is better for circular clipping than ClipRRect
            //   child: Image.network(
            //     imageUrl,
            //     fit: BoxFit.cover, // This ensures the image covers the entire space
            //     height: 60,
            //     width: 60,
            //   ),
            // ),
          ),
          SizedBox(height: 5,),
          Text(label,style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
             // color: gPrimaryColor
          ),)
        ],
      ),
    );
  }

  Widget _buildBrandChipShimmerUser() {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: 100,
            decoration: BoxDecoration(
              // shape: BoxShape.circle, // This makes the container perfectly circular
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 3,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10,),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 10,
            width: 100,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
