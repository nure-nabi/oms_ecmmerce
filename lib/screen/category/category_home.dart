import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/screen/category/bloc/category_bloc.dart';
import 'package:oms_ecommerce/screen/category/bloc/category_event.dart';
import 'package:oms_ecommerce/screen/category/bloc/category_state.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/constant/colors_constant.dart';

class CategoryHome extends StatefulWidget {
  const CategoryHome({super.key});

  @override
  State<CategoryHome> createState() => _CategoryHomeState();
}

class _CategoryHomeState extends State<CategoryHome> {

  List<Map<String, dynamic>> categoryList = [
    {
      "name":"Women",
      "url":"https://assets.turbologo.com/blog/en/2021/09/10094210/product-photo-1.png"
    },
    {
      "name":"Men",
      "url":"https://assets.turbologo.com/blog/en/2021/09/10094210/product-photo-1.png"
    },
    {
      "name":"Sport",
      "url":"https://assets.turbologo.com/blog/en/2021/09/10094210/product-photo-1.png"
    }
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
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CategoryBloc>(context).add(CategoryReqEvent2(0));
    BlocProvider.of<CategoryBloc>(context).add(CategoryReqEvent(0));


    return  BlocBuilder<CategoryBloc,CategoryState>(
      builder: (BuildContext context, state) {
        if(state is CategoryInitialState){
          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 7), // Padding around the grid
            shrinkWrap: true, // Useful inside ScrollViews
            physics: const NeverScrollableScrollPhysics(), // Disable scrolling if nested
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemCount: listValue.length, // Total number of items
            itemBuilder: (BuildContext context, int index) {
              final item = listValue[index];
              return Column(
                children: [
                  Container(
                    decoration:  const BoxDecoration(
                      //borderRadius: BorderRadius.all(Radius.circular(10)),

                    ),
                    child:  ClipRRect(
                      borderRadius: BorderRadius.circular(1),
                      child: SizedBox(

                        child: Shimmer.fromColors(
                          baseColor: Colors.red,
                          highlightColor: Colors.yellow,
                          child: Text(
                            'Shimmer',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                  ),
                ],
              );
            },
          );
        }else if(state is CategoryLoadingState){
          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.1,
            ),
            itemCount:  8 ,// Show 8 shimmer items when list is empty
            itemBuilder: (BuildContext context, int index) {
              // Show shimmer if list is empty or null
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        width: double.infinity,
                        height: 50,
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: double.infinity,
                        height: 15,
                        color: Colors.white,
                      )
                    ],
                  ),
                );


            },
          );
        }else if(state is CategoryLoadedState){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(left: 10,right: 10,bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Categories',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color:  Color(0xff003466)
                      ),
                    ),
                    Text("See all",style: GoogleFonts.poppins(
                        color: gPrimaryColor,
                        fontSize: 15
                    ),)
                  ],
                ),
              ),
              GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 7), // Padding around the grid
                shrinkWrap: true, // Useful inside ScrollViews
                physics: const NeverScrollableScrollPhysics(), // Disable scrolling if nested
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  childAspectRatio: 0.87,
                ),
                itemCount: 5, // Total number of items
                itemBuilder: (BuildContext context, int index) {
                  final item = state.categoryResModel!.categoriesList[index];
                  // return Card(
                  //   child: Column(
                  //     children: [
                  //       Container(
                  //         decoration:  BoxDecoration(
                  //           //borderRadius: BorderRadius.all(Radius.circular(10)),
                  //
                  //         ),
                  //         child:  Container(
                  //           decoration: BoxDecoration(),
                  //           child: ClipRRect(
                  //             borderRadius: BorderRadius.circular(4),
                  //             child: SizedBox(
                  //               width: double.infinity, // Expand to full width
                  //               height: 50, // Expand to full width
                  //               child:  CachedNetworkImage(
                  //                 imageUrl: item.imageFullUrl!,
                  //                 fit: BoxFit.fill,
                  //                 placeholder: (context, url) => Container(),
                  //                 errorWidget: (context, url, error) => Icon(Icons.error),
                  //               ),
                  //               // child: Image.network(
                  //               //   item.imageFullUrl!,
                  //               //   fit: BoxFit.fill,
                  //               // ),
                  //             ),
                  //           ),
                  //         ),
                  //
                  //       ),
                  //
                  //       SizedBox(height: 5,),
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 2,right: 2),
                  //         child: Text( item.categoryName!,overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(
                  //           fontWeight: FontWeight.w400,
                  //           fontSize: 15
                  //         ),),
                  //       )
                  //     ],
                  //   ),
                  // );

                  return _buildCategoryChip(item.categoryName!,item.imageFullUrl!);
                },
              ),
            ],
          );
        }else {
          return Container();
        }
      },);
  }

  Widget _buildCategoryChip(String label,String imageUrl) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle, // This makes the container perfectly circular
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 3,
              ),
            ],
          ),
          child: ClipOval( // ClipOval is better for circular clipping than ClipRRect
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover, // This ensures the image covers the entire space
              height: 60,
              width: 60,
            ),
          ),
        ),
        SizedBox(height: 5,),
        Text(label,style: GoogleFonts.poppins(
            fontSize: 12
        ),)
      ],
    );
  }
}
