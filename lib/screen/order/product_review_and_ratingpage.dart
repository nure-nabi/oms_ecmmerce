import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/core/constant/colors_constant.dart';
import 'package:oms_ecommerce/screen/order/bloc/review/review_bloc.dart';
import 'package:oms_ecommerce/screen/order/bloc/review/review_event.dart';
import 'package:oms_ecommerce/screen/order/bloc/review/review_state.dart';
import 'package:provider/provider.dart';

import '../../core/services/routeHelper/route_name.dart';
import 'model/order_model.dart';


class ProductReviewAndRatingPage extends StatefulWidget {
  ProductsModel productsModel;
  String orderId;
   ProductReviewAndRatingPage({super.key,required this.productsModel,required this.orderId});


  @override
  State<ProductReviewAndRatingPage> createState() => _ProductReviewAndRatingPageState();
}

class _ProductReviewAndRatingPageState extends State<ProductReviewAndRatingPage> {

  final  commentEditText = TextEditingController();

  var globalKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: gPrimaryColor,
        title: const Text("Product Review and Rating"),
        leading: IconButton(
          icon: const Icon(Bootstrap.chevron_left,),
          onPressed: () {
            Navigator.pop(context);
          }  ,
        ),
      ),
      floatingActionButton: BlocBuilder<ReviewBloc,ReviewState>(builder: (BuildContext context, state) {
        if(state is ReviewInitialState){
          return FloatingActionButton(
            backgroundColor: gPrimaryColor,
            foregroundColor: Colors.white,
            onPressed: () async {
              // if(globalKey.currentState!.validate()){
              //
              // }
              Fluttertoast.showToast(msg: "Please select rating and write review");
            },
            child: const Icon(Icons.check),
          );
        }else if(state is ReviewLoadedState){
          return FloatingActionButton(
            backgroundColor: gPrimaryColor,
            foregroundColor: Colors.white,
            onPressed: () async {
              if(state.rating! > 0 && commentEditText.text.isNotEmpty){
                context.read<ReviewBloc>().add(
                    ReviewReqEvent(
                        rating: state.rating!.toStringAsFixed(0),
                        review_detail: commentEditText.text.trim(),
                        product_code: widget.productsModel.product_code!,
                        order_id: widget.orderId,
                        context: context
                    ));
              }else{
                Fluttertoast.showToast(msg: "Please select rating and write review");
              }

            },
            child: const Icon(Icons.check),
          );
        }else{
          return SizedBox.shrink();
        }
      },),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<ReviewBloc,ReviewState>(builder: (BuildContext context, state) {
            if(state is ReviewInitialState){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.network(
                      widget.productsModel.image_full_url!,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(color: Colors.grey);
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(color: Colors.grey); // Error placeholder
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.productsModel.product_name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    "How was your experience with this product",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  RatingBar.builder(
                    initialRating: 1,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemSize: 50,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      context.read<ReviewBloc>().add(ReviewRatingEvent(
                          review: commentEditText.text.trim(), rating: rating));
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: commentEditText,
                    minLines: 6,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "Type Review......",
                      //   floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.black26),
                        gapPadding: 10,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.black26),
                        gapPadding: 10,
                      ),
                    ),
                  ),

                ],
              );
            }if(state is ReviewLoadedState){
              return Form(
                key: globalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: Image.network(
                        widget.productsModel.image_full_url!,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(color: Colors.grey);
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(color: Colors.grey); // Error placeholder
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.productsModel.product_name!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    SizedBox(height: 10),
                    const Text(
                      "How was your experience with this product",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    RatingBar.builder(
                      initialRating: 0.0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemSize: 50,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        context.read<ReviewBloc>().add(ReviewRatingEvent(
                            review: commentEditText.text.trim(), rating: rating));
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: commentEditText,
                      minLines: 6,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "Type Review......",
                        //   floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.black26),
                          gapPadding: 10,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.black26),
                          gapPadding: 10,
                        ),
                      ),
                      validator: (value){
                        if(value!.isEmpty && value == null){
                          return "Please write review";
                        }
                        return null;
                      },
                    ),

                  ],
                ),
              );
            }else{
              return Container();
            }
          },),
        ),
      )
    );
  }
}
