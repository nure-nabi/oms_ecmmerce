import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/core/services/routeHelper/route_name.dart';
import 'package:oms_ecommerce/screen/category/bloc/category_top_bloc/category_top_bloc.dart';
import 'package:oms_ecommerce/screen/category/bloc/category_top_bloc/category_top_event.dart';
import 'package:oms_ecommerce/screen/category/bloc/category_top_bloc/category_top_state.dart';
import 'package:oms_ecommerce/utils/check_network.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/constant/colors_constant.dart';
import '../../utils/custome_toast.dart';

class CategoryHomeWidget extends StatefulWidget {
  const CategoryHomeWidget({super.key});

  @override
  State<CategoryHomeWidget> createState() => _CategoryHomeWidgetState();
}

class _CategoryHomeWidgetState extends State<CategoryHomeWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<CategoryTopBloc>().add(CategoryTopReqEvent());
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryTopBloc,CategoryTopState>(
      builder: (BuildContext context, state) {
        if(state is CategoryTopLoadingState){
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
                  height: 90,
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
        }else if (state is CategoryTopLoadedState){
          return state.categoryTopResponse!.categories!.isNotEmpty ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 0),
                padding: EdgeInsets.only(left: 10,right: 10,bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Top Categories',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                         // color:  Color(0xff003466)
                      ),
                    ),
                    InkWell(
                      onTap: ()=> {
                        CheckNetwork.check().then((network){
                          if(!network){
                            CustomToast.showCustomRoast(context:context, message: "No network found.", icon: Bootstrap.check_circle,iconColor: Colors.red);
                          }else{
                            Navigator.pushNamed(context, categorySubcategoryListPage,
                                arguments: true
                            );
                          }
                        })

                      },
                      child: Text("See all",style: GoogleFonts.poppins(
                          //color: gPrimaryColor,
                          fontSize: 15
                      ),),
                    )
                  ],
                ),
              ),
              SizedBox(height: 7,),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.18,
                child: ListView.separated(
                   scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => SizedBox(width: 10,),
                    itemCount: state.categoryTopResponse!.categories!.length,
                   itemBuilder: (context ,index){
                     final item = state.categoryTopResponse!.categories![index];
                     return _buildCategoryChip(item.id!,item.category_name!,item.image_full_url!);
                   },
                ),
              ),
            ],
          ) : SizedBox.shrink();
        }else {
          return  SizedBox.shrink();
        }
      },);
  }

  Widget _buildCategoryChip(int categoryId,String label,String imageUrl) {
    return InkWell(
      onTap: (){
        CheckNetwork.check().then((network){
          if(!network){
            CustomToast.showCustomRoast(context:context, message: "No network found.", icon: Bootstrap.check_circle,iconColor: Colors.red);
          }else{
            Navigator.pushNamed(context, topCategoryProductListPage,
                arguments: categoryId
            );
          }
        });
      },
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: 100,
            decoration: BoxDecoration(
             // shape: BoxShape.circle, // This makes the container perfectly circular
              color: Colors.white,
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
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
            height: 50,
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
