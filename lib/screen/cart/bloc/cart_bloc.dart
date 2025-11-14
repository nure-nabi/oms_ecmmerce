import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/core/services/routeHelper/route_name.dart';
import 'package:oms_ecommerce/screen/cart/api/cart_repo.dart';
import 'package:oms_ecommerce/screen/cart/bloc/cart_event.dart';
import 'package:oms_ecommerce/screen/cart/bloc/cart_state.dart';
import 'package:oms_ecommerce/screen/cart/model/cart_model.dart';
import 'package:oms_ecommerce/screen/service/sharepref/get_all_pref.dart';
import 'package:oms_ecommerce/utils/custom_log.dart';

import '../../../component/loading_overlay.dart';
import '../../../utils/custome_toast.dart';
import '../../address/model/address_model.dart';
import '../../order/api/order_repo.dart';

class CartBloc extends Bloc<CartEvent,CartState>{
  int _currentCount = 1; // Track current count
  List<int> vlist = [];
  List<bool> checkedCart = [];
  List<String> checkedValue = [];
  List<CartProductModel> cartValueTempList = [];
  CartResModel? cartResModel;
  CartBloc() : super(CartInitialState()){
    on<CartReqEvent>((event,emit) async{
     // emit(CartLoadingState());

     // _currentCount = 1;
     try{
       cartResModel  = await  CartRepo.getCart(userId: await GetAllPref.userId());
       if(cartResModel!.cart!.items.isNotEmpty){
         double total =  await totalAmountCart(cartResModel!);
         int cartLength = cartResModel!.cart!.items.length;
         vlist.clear();
         checkedCart.clear();
         checkedValue.clear();
         cartValueTempList.clear();
         for(int i = 0; i < cartResModel!.cart!.items.length; i++) {
           vlist.add(cartResModel!.cart!.items[i].quantity!);
           checkedCart.add(event.checkedCart!);
           //  checkedValue.add(cartResModel.cart!.items![i].id!.toString());
         }

         emit(CartLoadedState(cartResModel: cartResModel,totalAmount: total,cartLenght: cartLength,qtyLits: vlist,
           updateFlag: false,checkedCart: checkedCart,));
       }else{
         emit(CartLoadedState(cartResModel: cartResModel, updateFlag: false,));
       }


     }catch(e){
       emit(CartErrorState(errorMsg: e.toString()));
     }
    });

    on<CartItemRemoveByIdEvent>((event,emit)async{
      CartItemRemovedResModel cartItemRemovedResModel = await  CartRepo.deleteCartByItemCode(item_id: event.id);
      if(cartItemRemovedResModel.success == true){
        try{
          CartResModel cartResModel = await  CartRepo.getCart(userId: await GetAllPref.userId());
          double total =  await totalAmountCart(cartResModel);
          int cartLength = cartResModel.cart!.items.length;
          vlist.clear();
          for(int i = 0; i < cartResModel.cart!.items.length; i++) {
            vlist.add(cartResModel.cart!.items[i].quantity!);
            checkedCart.add(event.checkedCart!);
          }
         // if(cartResModel.cart!.items.isEmpty){
            emit(CartLoadedState(cartResModel: cartResModel,totalAmount: total,cartLenght: cartLength,qtyLits: vlist,updateFlag: false,checkedCart: checkedCart));
          CustomToast.showCustomRoast(context: event.context, message: cartItemRemovedResModel.message!, icon: Bootstrap.check_circle);
          LoadingOverlay.hide();
      //    }
        }catch(e){
          emit(CartErrorState(errorMsg: e.toString()));
        }
      }
    });

    on<CartItemRemoveEvent>((event,emit)async{

      CartItemRemovedResModel cartItemRemovedResModel = await  CartRepo.clearCart();
      if(cartItemRemovedResModel.success == true){
        try{
          CartResModel cartResModel = await  CartRepo.getCart(userId: await GetAllPref.userId());
          double total =  await totalAmountCart(cartResModel);
          int cartLength = cartResModel.cart!.items.length;
          vlist.clear();
          for(int i = 0; i < cartResModel.cart!.items.length; i++) {
            vlist.add(cartResModel.cart!.items[i].quantity!);
          }
            emit(CartLoadedState(cartResModel: cartResModel,totalAmount: total,cartLenght: cartLength,qtyLits: vlist,updateFlag: false));


        }catch(e){
          emit(CartErrorState(errorMsg: e.toString()));
        }
      }
    });


    on<CartIncrementEvent>((event, emit) async{
// First emit a loading state
      // 1️ First emit loading state
      emit((state as CartLoadedState).copyWith(count:0,totalAmount: 0,updateFlag: true));

      try {
      _currentCount = vlist[event.index!];
      _currentCount++;

      CartItemRemovedResModel cartItemRemovedResModel = await  CartRepo.updateCart(
          item_id: event.id!.toString(),
          quantity: _currentCount.toString());

      int index = cartValueTempList.indexWhere((e)=> e.product_code == event.product_code);

      if(index != -1){
        cartValueTempList[index].quantity = (event.count + 1).toString();
      }
     // cartValueTempList.removeWhere((product) => product.product_code == product_code);

      vlist[event.index!] = _currentCount;
      if (cartItemRemovedResModel.success == true) {
        CartResModel cartResModel = await  CartRepo.getCart(userId: await GetAllPref.userId());
        double total= totalAmountCart(cartResModel);
        LoadingOverlay.hide();
        emit((state as CartLoadedState).copyWith(count:_currentCount,totalAmount: total,updateFlag: false));
      }
      } catch (e) {
        // 4️⃣ Handle errors & turn off loading
        LoadingOverlay.hide();
        emit((state as CartLoadedState).copyWith(updateFlag: false));
        Fluttertoast.showToast(msg: "Error: ${e.toString()}");
      }
    });

    on<CartDecrementEvent>((event, emit) async{
      emit((state as CartLoadedState).copyWith(count:0,totalAmount: 0,updateFlag: true));
      try {
      if (event.count > 1) {
        _currentCount = vlist[event.index!];
        _currentCount --;
        vlist.add(event.count);
        CartItemRemovedResModel cartItemRemovedResModel = await  CartRepo.updateCart(
            item_id: event.id!.toString(),
            quantity: _currentCount.toString());
        int index = cartValueTempList.indexWhere((e)=> e.product_code == event.product_code);
        if(index != -1){
          cartValueTempList[index].quantity = (event.count - 1).toString();
        }
        vlist[event.index!] = _currentCount;
        if (cartItemRemovedResModel.success == true) {
          CartResModel cartResModel = await  CartRepo.getCart(userId: await GetAllPref.userId());
          double total= totalAmountCart(cartResModel);
          LoadingOverlay.hide();
          emit((state as CartLoadedState).copyWith(count: _currentCount,totalAmount: total,updateFlag: false));
        }
      }
      } catch (e) {
        // 4️⃣ Handle errors & turn off loading
        emit((state as CartLoadedState).copyWith(updateFlag: false));
        Fluttertoast.showToast(msg: "Error: ${e.toString()}");
      }
    });

    on<CartItemCheckeEvent>((event,omit)async{
      checkedCart[event.index] = event.checked!;
      if(event.checked!){
        checkedValue.add(event.checkedValue.toString());
        // Add if not already in list
        if (!cartValueTempList.contains(event.cartProductModel!.product_code)) {
          cartValueTempList.add(event.cartProductModel!);


        }
      }else{
        checkedValue.remove(event.checkedValue.toString());
        cartValueTempList.removeWhere((product) => product.product_code == event.cartProductModel!.product_code);
      }

     // Fluttertoast.showToast(msg: event.checkedValue.toString());
      cartResModel  = await  CartRepo.getCart(userId: await GetAllPref.userId());
      emit((state as CartLoadedState).copyWith(cartResModel: cartResModel,checkedCart: checkedCart, updateFlag: false,checkedValue: checkedValue,tempCartList: cartValueTempList));
   //   emit(CartLoadedState(cartResModel: cartResModel,checkedCart: checkedCart, updateFlag: false));
      LoadingOverlay.hide();
    });

    on<CartItemsSelectAllEvent>((event,omit)async{

    //  cartResModel  = await  CartRepo.getCart(userId: await GetAllPref.userId());
      try{
        double total =  await totalAmountCart(cartResModel!);
        int cartLength = cartResModel!.cart!.items.length;
        vlist.clear();
        checkedCart.clear();
        checkedValue.clear();
        for(int i = 0; i < cartResModel!.cart!.items.length; i++) {
          vlist.add(cartResModel!.cart!.items[i].quantity!);

          checkedCart.add(event.checkedCart);
            checkedValue.add(cartResModel!.cart!.items[i].id!.toString());
          var cartValue =   CartProductModel(
              product_code: cartResModel!.cart!.items[i].products!.product_code!,
              product_name: cartResModel!.cart!.items[i].products!.product_name!,
              actual_price: cartResModel!.cart!.items[i].products!.actual_price!,
              sell_price:   cartResModel!.cart!.items[i].products!.sell_price!,
              mr_price:     cartResModel!.cart!.items[i].products!.mr_price!,
              quantity:  cartResModel!.cart!.items[i].quantity.toString(),
              stock_quantity: cartResModel!.cart!.items[i].products!.stock_quantity!,
              product_description: cartResModel!.cart!.items[i].products!.product_description!,
              image_full_url: cartResModel!.cart!.items[i].products!.image_full_url!,
              main_image_full_url: cartResModel!.cart!.items[i].products!.main_image_full_url!);
            cartValueTempList.add(cartValue);
        }
        if(event.checkedCart){
          checkedCart.add(event.checkedCart);
        }else{
          checkedValue.clear();
          cartValueTempList.clear();
        }
        emit(CartLoadedState(cartResModel: cartResModel,totalAmount: total,cartLenght: cartLength,qtyLits: vlist,
          updateFlag: false,checkedCart: checkedCart,checkedValue: checkedValue,tempCartList: cartValueTempList));
         LoadingOverlay.hide();
      }catch(e){
        emit(CartErrorState(errorMsg: e.toString()));
      }

    });

    on<CartItemsBuyEvent>((event,omit)async{
     try{
       AddressResponse response =await   OrderRepo.orderCartSave(
           payment_method: event.payment_method,
           billing_address: event.billing_address,
           shipping_address: event.shipping_address,
           invoice_email: event.invoice_email,
           selected_items: event.selected_items
       );

       emit((state as CartLoadedState).copyWith(checkedValue: event.selected_items));
       if(response.success == true){
         LoadingOverlay.hide();
         Navigator.pushNamed(event.context!, orderConfirmPage);
       //  Navigator.pushReplacementNamed(event.context!, orderActivityPage);
         CustomToast.showCustomRoast(context: event.context!, message: response.message!,
             icon: Bootstrap.check_circle,iconColor: Colors.green);
       }else{
         LoadingOverlay.hide();
         CustomLog.errorLog(value: "Something server error");
         Fluttertoast.showToast(msg: "Something server error");
       }
     }catch(e){
       LoadingOverlay.hide();
       CustomLog.errorLog(value: "Something server error");
       omit(CartErrorState(errorMsg: e.toString()));
     }
    });

    on<CartItemTempDataEvent>((event,omit){
      omit((state as CartLoadedState).copyWith(tempCartList: event.tempCartList));
    });

    on<CartClearEvent>((event,emit)async{
      cartResModel = null;
     // cartResModel  = await  CartRepo.getCart(userId: await GetAllPref.userId());
     // emit(CartLoadedState(cartResModel:  cartResModel));
    });

  }

  totalAmountCart(CartResModel cartResModel){
    double totalAmount = 0.0;
    for(int i=0; i<cartResModel.cart!.items.length; i++){
      int p = cartResModel.cart!.items[i].quantity!;
      totalAmount += p * double.parse(cartResModel.cart!.items[i].price!);
    }
    return totalAmount;
  }
}