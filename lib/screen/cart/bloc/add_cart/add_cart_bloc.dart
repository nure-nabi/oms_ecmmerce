import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/component/loading_overlay.dart';
import 'package:oms_ecommerce/screen/cart/api/cart_repo.dart';
import 'package:oms_ecommerce/screen/cart/bloc/add_cart/add_cart_event.dart';
import 'package:oms_ecommerce/screen/cart/bloc/add_cart/add_cart_state.dart';

import '../../../../utils/custome_toast.dart';
import '../../model/add_cart.dart';

class AddCartBloc extends Bloc<AddCartEvent, AddCartState>{
  AddCartBloc():super(AddCartInitialState()){
    on<AddCartReqEvent>((event,emit) async{
      emit(AddCartLoadingState());
      try{

        AddResCart addResCart= await CartRepo.addCart(
            product_code: event.productCode!,
            price: event.price!,
            quantity: event.quantity!);
        if(addResCart.success == true){
          LoadingOverlay.hide();
          CustomToast.showCustomRoast(context: event.context, message: addResCart.message!, icon: Bootstrap.check_circle);

          emit(AddCartLoadedState(addResCart: addResCart));
        }else{
          LoadingOverlay.hide();
          CustomToast.showCustomRoast(context: event.context, message: addResCart.message!, icon: Bootstrap.check_circle,iconColor: Colors.red);
        }

      }catch(e){
        emit(AddCartErrorState(errorMsg: e.toString()));
      }
    });

  }
}