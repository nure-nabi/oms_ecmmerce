import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/basic_model/basic_model.dart';
import 'package:oms_ecommerce/component/loading_overlay.dart';
import 'package:oms_ecommerce/screen/wish_list/api/wishlist_repo.dart';
import 'package:oms_ecommerce/screen/wish_list/bloc/wishlist_event.dart';
import 'package:oms_ecommerce/screen/wish_list/bloc/wishlist_state.dart';
import 'package:oms_ecommerce/screen/wish_list/model/wishlsit_model.dart';

import '../../../utils/custome_toast.dart';

class WishlistBloc extends Bloc<WishlistEvent,WishlistState>{
  WishlistResponse? response;
   WishlistBloc() : super(WishlistInitialState()){
     on<WishlistReqEvent>(_onWishlistReqEvent);
     on<WishlistSaveEvent>(_onWishlistSaveEvent);
     on<WishlistRemovedEvent>(_onWishlistRemovedEvent);
   }

   Future<void> _onWishlistReqEvent(
       WishlistReqEvent event,
       Emitter<WishlistState> omit
       ) async{
     omit(WishlistLoadingState());
       try{
         response = await  WishlistRepo.getWishList();
       if(response!.success == true){
         omit(WishlistLoadedState(response: response!));
         // final currentState = state as WishlistLoadedState;
       //  omit(currentState.copyWith(response: response));
       }else{
        // Fluttertoast.showToast(msg: response!.message!);
         omit(WishlistErrorState(erorMsg: "You are not authorized!"));
       }
       }catch(e){
         omit(WishlistErrorState(erorMsg: e.toString()));
       }

   }

   Future<void> _onWishlistSaveEvent(
       WishlistSaveEvent event,
       Emitter<WishlistState> omit
       ) async{
     try{
       BasicModel basicModel = await  WishlistRepo.saveWishList(productId: event.productCode);
       if(basicModel.success == true){
         LoadingOverlay.hide();
         CustomToast.showCustomRoast(context: event.context, message: basicModel.message!,
             icon: Bootstrap.check_circle,iconColor: Colors.green);

       }else{
         LoadingOverlay.hide();
         CustomToast.showCustomRoast(context: event.context, message: basicModel.message!,
             icon: Bootstrap.check_circle,iconColor: Colors.red);
       }
     }catch(e){
       omit(WishlistErrorState(erorMsg: e.toString()));
     }

   }

   Future<void> _onWishlistRemovedEvent(
       WishlistRemovedEvent event,
       Emitter<WishlistState> omit
       ) async{
     try{
       response = await  WishlistRepo.getWishList();
       BasicModel? basicModel;
       final matchedItems = response!.wishlist
           .where((u) => u.product_code!
           .contains(event.product_code!))
           .toList();
       if (matchedItems.isNotEmpty) {
         basicModel  = await  WishlistRepo.removeWishList(item_id: matchedItems.first.id);
       } else {
          basicModel = await  WishlistRepo.removeWishList(item_id: event.item_code);
       }

       response = await  WishlistRepo.getWishList();
       if(basicModel!.success == true){
         LoadingOverlay.hide();
         CustomToast.showCustomRoast(context: event.context, message: basicModel.message!,
             icon: Bootstrap.check_circle,iconColor: Colors.green);
         if(response!.success == true){
           omit(WishlistLoadedState(response: response!));

         }
       }else{
         LoadingOverlay.hide();
         CustomToast.showCustomRoast(context: event.context, message: basicModel.message!,
             icon: Bootstrap.check_circle,iconColor: Colors.red);
       }
     }catch(e){
       omit(WishlistErrorState(erorMsg: e.toString()));
     }

   }

}