import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/component/loading_overlay.dart';
import 'package:oms_ecommerce/core/services/routeHelper/route_name.dart';
import 'package:oms_ecommerce/screen/address/model/address_model.dart';
import 'package:oms_ecommerce/screen/order/api/order_repo.dart';
import 'package:oms_ecommerce/screen/order/bloc/order_event.dart';
import 'package:oms_ecommerce/screen/order/bloc/order_state.dart';
import 'package:oms_ecommerce/screen/order/model/order_model.dart';
import 'package:oms_ecommerce/screen/order/order_confirm_page.dart';
import 'package:oms_ecommerce/utils/custom_log.dart';

import '../../../utils/custome_toast.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  late OrderResponseModel responseModel;
  OrderBloc() : super(OrderInitialState()) {
    on<OrderReqEvent>((event, omit) async{

      try{
        AddressResponse response =await   OrderRepo.orderSave(
          payment_method: event.payment_method,
          billing_address: event.billing_address,
          shipping_address: event.shipping_address,
          invoice_email: event.invoice_email,
          product_code: event.product_code,
          quantity: event.quantity,
        );

        if(response.success == true){
          LoadingOverlay.hide();
          CustomToast.showCustomRoast(context: event.context!, message: response.message!,
              icon: Bootstrap.check_circle,iconColor: Colors.green);
          //Navigator.pushReplacementNamed(event.context!, orderActivityPage,);
          Navigator.pushNamed(event.context!, orderConfirmPage);
//9801671851
        //9851158451
          //9817034196
        }else{
          Fluttertoast.showToast(msg: "Something error");
        }
      }catch(e){
        omit(OrderErrorState(errorMsg: e.toString()));
      }

    });

    on<OrderCartEvent>((event, omit) async{
      responseModel =await OrderRepo.getOrder(status: "processing");
      if(responseModel.success == true){
        omit(OrderLoadedState(orderResponse: responseModel,count: event.count,subTotal: (event.productPrice)));

      }else{
        omit(OrderLoadingState());
      }

    });



    on<OrderShowEvent>((event,omit)async{
    //  Fluttertoast.showToast(msg: event.status);
      omit(OrderLoadingState());
      responseModel =await OrderRepo.getOrder(status: event.status);
      if(responseModel.success == true){
       // Fluttertoast.showToast(msg: responseModel.orders.orders.length.toString());
        omit(OrderLoadedState(orderResponse: responseModel));
      }else{
        omit(OrderLoadingState());
      }

    //  omit((state as OrderLoadedState).copyWith(orderResponse: responseModel));
    });
  }
  Future<double>  calculate({required sellingPrice,required quantity}){

    return (sellingPrice * quantity);
  }
}