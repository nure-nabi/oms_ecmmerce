import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/screen/category/bloc/category_bloc.dart';
import 'package:oms_ecommerce/screen/category/bloc/category_state.dart';
import 'package:oms_ecommerce/theme/theme_bloc.dart';

import '../../core/constant/colors_constant.dart';
import '../../core/services/routeHelper/route_name.dart';
import '../../storage/hive_storage.dart';
import '../cart/bloc/cart_bloc.dart';
import '../cart/bloc/cart_state.dart';
import 'bloc/category_event.dart';

class CategorySubcategoryList extends StatefulWidget {
  final bool? leading;
  const CategorySubcategoryList({super.key,this.leading=false});

  @override
  State<CategorySubcategoryList> createState() =>
      _CategorySubcategoryListState();
}

class _CategorySubcategoryListState extends State<CategorySubcategoryList> {
  bool _isExpanded = false;
  int ind = 0;
  int i = -0;
  bool exp = false;

  @override
  void initState() {
    context.read<CategoryBloc>().add(CategoryReqEvent(0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc,ThemeMode>(builder: (BuildContext context, state) {
      final bool isDarkMode = state == ThemeMode.dark;
      //final Color backgroundColor = isDarkMode ? Colors.black : Colors.white;
      final Color backgroundColor = HiveStorage.hasPermission("Thememode") ? Colors.black : Colors.white;
      final Color textColor = HiveStorage.hasPermission("Thememode") ? Colors.white : Colors.black;
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: widget.leading!,
         // backgroundColor: gPrimaryColor,
          elevation: 0,
          leading:widget.leading! == true ? InkWell(
            onTap: ()=> Navigator.pop(context),
            child: const
            Icon(Bootstrap.chevron_left),
          ) : null,
          title: const Text(
            "Categories",
            style: TextStyle(fontSize: 27),
          ),
          actions:  [
            getCartData(),
          ],
        ),
      //  backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(color: Colors.grey.shade50, width: 1),
                        ),
                       // color: Colors.grey.shade100
                    ),
                    child: BlocBuilder<CategoryBloc, CategoryState>(
                      builder: (BuildContext context, state) {
                        if (state is CategoryLoadedState) {
                          return ListView.builder(
                              itemCount: state.categoryResModel!.categoriesList.length,
                              itemBuilder: (context, index) {
                                final isSelected = state.index == index;
                                var item =
                                state.categoryResModel!.categoriesList[index];
                                return InkWell(
                                  onTap: () {
                                    ind = 0;
                                    context
                                        .read<CategoryBloc>()
                                        .add(CategoryReqEvent(index));
                                    exp = false;
                                  },
                                  child: Container(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.grey.withOpacity(0.1),
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            ind = 0;
                                            context
                                                .read<CategoryBloc>()
                                                .add(CategoryReqEvent(index));
                                            // BlocProvider.of<CategoryBloc>(context).add(CategoryReqEvent(
                                            //     index
                                            //     ));

                                            exp = false;
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 0,
                                                bottom: 3),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(100),
                                                child: CachedNetworkImage(
                                                  imageUrl: item.imageFullUrl!,
                                                  fit: BoxFit.cover,
                                                    colorBlendMode: isSelected
                                                        ? BlendMode.color
                                                        : BlendMode.dst,

                                                  errorWidget: (context, url, error) => Image.asset("assets/icons/noimage.jpg"),
                                                )
                                              // child: Image.network(
                                              //   item.imageFullUrl!,
                                              //   colorBlendMode: isSelected
                                              //       ? BlendMode.color
                                              //       : BlendMode.dst,
                                              // ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          item.categoryName!,maxLines: 1,overflow: TextOverflow.clip,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                              color: isSelected
                                                  ? Colors.orange
                                                  : textColor,
                                              fontSize: 12
                                          ),
                                          // style: TextStyle(
                                          //   color: isSelected
                                          //       ? Colors.orange
                                          //       : Colors.black.withOpacity(0.3),
                                          // ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return Container();
                        }
                      },
                    ),
                  )),
              // Expanded(
              //     flex: 4,
              //     child:  Container(
              //       color: Colors.white,
              //       child: BlocBuilder<CategoryBloc,CategoryState>(
              //          builder: (BuildContext context, state) {
              //            if(state is CategoryLoadedState){
              //              Fluttertoast.showToast(msg: state.index.toString());
              //              return GridView.builder(
              //                padding: EdgeInsets.symmetric(horizontal: 7), // Padding around the grid
              //                shrinkWrap: true, // Useful inside ScrollViews
              //                physics: NeverScrollableScrollPhysics(), // Disable scrolling if nested
              //                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //                  crossAxisCount: 3,
              //                  crossAxisSpacing: 10,
              //                  mainAxisSpacing: 10,
              //                  childAspectRatio: 1,
              //                ),
              //                itemCount: state.categoryResModel!.categoriesList[state.index].activeChildren!.length, // Total number of items
              //                itemBuilder: (BuildContext context, int index) {
              //                  final item = state.categoryResModel!.categoriesList[state.index].activeChildren![index];
              //                  return Column(
              //                    children: [
              //                      Container(
              //                        decoration:  BoxDecoration(
              //                          //borderRadius: BorderRadius.all(Radius.circular(10)),
              //
              //                        ),
              //                        child:  ClipRRect(
              //                          borderRadius: BorderRadius.circular(1),
              //                          child: Image.network(
              //                            item.imageFullUrl!,
              //                            height: 60,// Your image URL
              //                          ),
              //                        ),
              //
              //                      ),
              //
              //                      SizedBox(height: 5,),
              //                      Text( item.categoryName!, )
              //                    ],
              //                  );
              //                },
              //              );
              //            }else{
              //              return Container();
              //            }
              //          },
              //       ),
              //     ),
              // )

              Expanded(
                flex: 4,
                child: Container(
                  color: backgroundColor,
                  child: BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (BuildContext context, state) {
                      if(state is CategoryLoadingState){
                        return Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 40,
                            width: 40,

                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color:  backgroundColor,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                               //   color: Colors.grey.withOpacity(0.3),
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
                      }else if (state is CategoryLoadedState) {
                      //  Fluttertoast.showToast(msg: 'category lenght  ${state
                      //       .categoryResModel!
                      //       .categoriesList[state.index!]
                      //       .activeChildren!
                      //       .length.toString()}');
                        return ListView.separated(
                          separatorBuilder: (context, index) =>
                              Divider(height: 1),
                          //  padding: EdgeInsets.symmetric(horizontal: 7), // Padding around the grid
                          shrinkWrap: true,
                          // Useful inside ScrollViews
                          // physics: Scro(),
                          // Disable scrolling if nested
                          itemCount: state
                              .categoryResModel!
                              .categoriesList[state.index!]
                              .activeChildren!
                              .length,
                          // Total number of items
                          itemBuilder: (BuildContext context, int index) {
                            final item = state
                                .categoryResModel!
                                .categoriesList[state.index!]
                                .activeChildren![index];

                            return ExpansionTile(
                              onExpansionChanged: (isExpended) {
                                setState(() {
                                  _isExpanded = isExpended;
                                });

                                exp = false;
                              },
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        if (state
                                            .categoryResModel!
                                            .categoriesList[state.index!]
                                            .activeChildren![index]
                                            .activeChildren2!
                                            .isEmpty) {
                                          Fluttertoast.showToast(msg: "EMPITY");
                                        }
                                      },
                                      child: Text(
                                        item.categoryName!,
                                        maxLines: 1,
                                        style: GoogleFonts.poppins(

                                        ),
                                      )),
                                ],
                              ),
                              trailing: state
                                  .categoryResModel!
                                  .categoriesList[state.index!]
                                  .activeChildren![index]
                                  .activeChildren2!
                                  .isNotEmpty
                                  ? Icon(
                                _isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: Colors.grey[600],
                              )
                                  : const SizedBox.shrink(),
                              children: [
                                grid(state, index),
                                if (exp)
                                  if (index == i)
                                    BlocBuilder<CategoryBloc, CategoryState>(
                                      builder: (context, state) {
                                        if (state is CategoryLoadedState) {
                                          return SubGroup3(state, index, index);
                                          //return Text("sf");
                                        }
                                        return Container();
                                      },
                                    ),
                              ],
                            );
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },);
  }

  Widget grid(CategoryLoadedState state, int index2) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 7),
      // Padding around the grid
      shrinkWrap: true,
      // Useful inside ScrollViews
      physics: NeverScrollableScrollPhysics(),
      // Disable scrolling if nested
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemCount: state.categoryResModel!.categoriesList[state.index!]
          .activeChildren![index2].activeChildren2!.length,
      // Total number of items
      itemBuilder: (BuildContext context, int index) {
        final item = state.categoryResModel!.categoriesList[state.index!]
            .activeChildren![index2].activeChildren2![index];
        return InkWell(
          onTap: () {
            if (state
                .categoryResModel!
                .categoriesList[state.index!]
                .activeChildren![index2]
                .activeChildren2![index]
                .activeChildren3!
                .isEmpty) {
              Fluttertoast.showToast(msg: "no");
              i = index;
              //exp = true;
              //BlocProvider.of<CategoryBloc>(context).add(CategoryReqEvent3(index));
              setState(() {});
              SubGroup3(state, index2, index);
            } else {
              i = index;
              exp = true;
              BlocProvider.of<CategoryBloc>(context)
                  .add(CategoryReqEvent3(index));
              SubGroup3(state, index2, index);
            }
          },
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              //  color: Colors.orange
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      //borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      item.imageFullUrl!,
                      height: 50, // Your image URL
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  item.categoryName!,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget SubGroup3(CategoryLoadedState state, int index2, int index3) {
    if (state is CategoryLoadedState) {
      return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 30),
        // Padding around the grid
        shrinkWrap: true,
        // Useful inside ScrollViews
        physics: NeverScrollableScrollPhysics(),
        // Disable scrolling if nested
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemCount: state
            .categoryResModel!
            .categoriesList[state.index!]
            .activeChildren![index2]
            .activeChildren2![index3]
            .activeChildren3!
            .length,
        // Total number of items
        itemBuilder: (BuildContext context, int index) {
          final item = state
              .categoryResModel!
              .categoriesList[state.index!]
              .activeChildren![index2]
              .activeChildren2![index3]
              .activeChildren3![index];
          return InkWell(
            onTap: () {
              //  Fluttertoast.showToast(msg:  state.categoryResModel!.categoriesList[state.index!].activeChildren![indexF].activeChildren2![index].activeChildren3!.length.toString());
            },
            child: Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                // color: Colors.orange
              ),
              child: InkWell(
                onTap: () {
                  Fluttertoast.showToast(msg: "Fourth");
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          //borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          item.imageFullUrl!,
                          height: 50, // Your image URL
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      item.categoryName!,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
  Widget getCartData(){
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, cartPage,
            arguments: true
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            icon: Icon(Bootstrap.cart),
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
                    backgroundColor: Colors.red,
                    radius: 10,
                    child: Text(
                      state.cartResModel!.cart!.items.length.toString(),
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
