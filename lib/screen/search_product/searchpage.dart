
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_ecommerce/screen/search_product/bloc/search_product_event.dart';
import 'package:oms_ecommerce/screen/search_product/bloc/search_product_state.dart';
import 'package:provider/provider.dart';
import '../product/product_details.dart';
import 'bloc/search_product_bloc.dart';



class SearchScreen extends StatefulWidget {
  final String? categoryId, subCategoryId;

  const SearchScreen({super.key, this.categoryId, this.subCategoryId});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<ProductSearchBloc>().add(ProductSearchReqClearEvent());
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(

          title: //search
              Container(
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey.shade200),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search here.....',
                suffixText: 'Search',
                // Suffix text
                border: InputBorder.none,
                prefixIcon: const Icon(EvaIcons.search, size: 20),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    context.read<ProductSearchBloc>().add(ProductSearchReqClearEvent());
                  },
                ),
                prefixIconColor: Colors.grey,
                hintStyle: const TextStyle(color: Colors.grey),
                suffixStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.white
                    .withOpacity(0.7), // Fill color of the TextField
              ),
              style: const TextStyle(color: Colors.black),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  context.read<ProductSearchBloc>().add(ProductSearchReqEvent(
                      productName: value.toString().trim(),
                      limit: 10,
                      offset: 0));
                } else {
                  context.read<ProductSearchBloc>().add(ProductSearchReqClearEvent());
                 }
              },
              onFieldSubmitted: (value) {
                if (value.isNotEmpty ) {
                  context.read<ProductSearchBloc>().add(ProductSearchReqEvent(
                    productName: value.trim(),
                    limit: 10,
                    offset: 0,
                  ));
                }
              },
              textInputAction: TextInputAction.search, // Shows the search button on the keyboard
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              EvaIcons.arrowIosBack,
              color: Colors.grey,
              size: 30,
            ),
            onPressed: () {
            Navigator.pop(context);
            },
          ),
        ),
        body: BlocBuilder<ProductSearchBloc,ProductSearchState>(builder: (BuildContext context, state) {
          if(state is ProductSearchInitialState){

            return SizedBox.shrink();
          }else if(state is ProductSearchLoadedState){
                return state.searchProductResp.product!.data.isNotEmpty ? ListView.builder(
                  itemCount: state.searchProductResp.product!.data.length,
                  itemBuilder: (context, index) {
                   final info =   state.searchProductResp.product!.data[index];
                    return ListTile(
                      title: Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl: info.main_image_full_url != null ? info.main_image_full_url! : info.image_full_url!,
                            //imageUrl: info.main_image_full_url!,
                            height: 50,
                            fit: BoxFit.cover,
                            width: 50,
                            errorWidget: (context, url, error) => Image.asset("assets/icons/noimage.jpg"),
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            child: Text(
                                info.product_name!,overflow: TextOverflow.ellipsis,style: GoogleFonts.poppins(
                               fontSize: 15
                            ),),
                          ),
                        ],
                      ),
                      leading: const Icon(Icons.history),
                      onTap: () async {
                        _searchController.text = info.product_name!;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetails(
                              productCode: info.product_code!,
                              productName: info.product_name!,
                              stock_quantity: info.stock_quantity,
                              //sellingPrice: info.sell_price! != "" ? double.parse(info.sell_price!) : 0.00,
                              sellingPrice: info.sell_price! != "" ? double.parse(info.sell_price!) : double.parse(info.actual_price!),
                              productImage: info.image_full_url != "" ?  info.image_full_url: info.main_image_full_url,
                              variation: info.has_variations,
                            ),
                          ),
                        );

                        // List<PopularSearchModel> list = [];
                        // PopularSearchModel popularSearchModel =
                        // PopularSearchModel(
                        //     categoryId: searchHomeState
                        //         .productSearchList[0].categoryId,
                        //     subCategoryId: searchHomeState
                        //         .productSearchList[0].subCategoryId,
                        //     productId: searchHomeState
                        //         .productSearchList[0].productId,
                        //     productName: searchHomeState
                        //         .productSearchList[0].productName);
                        // list.add(popularSearchModel);
                        // String value = await PopularSearchDatabase.instance
                        //     .getPopularDataCount(
                        //     searchHomeState.productSearchList[0].productId);
                        // if (value.isEmpty) {
                        //   await PopularSearchDatabase.instance
                        //       .insertData(popularSearchModel);
                        // }
                      },
                    );
                  },
                )
                : Center(child: CircularProgressIndicator(),);
              }else{
                return SizedBox.shrink();
              }
          },)

    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
