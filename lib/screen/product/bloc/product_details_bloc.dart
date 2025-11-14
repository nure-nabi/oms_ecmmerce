import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_ecommerce/screen/product/api/product_repo.dart';
import 'package:oms_ecommerce/screen/product/bloc/ProductLatestState.dart';
import 'package:oms_ecommerce/screen/product/bloc/product_details_event.dart';
import 'package:oms_ecommerce/screen/product/bloc/product_details_state.dart';
import 'package:oms_ecommerce/screen/product/model/product_details_model.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent,ProductDetailsState>{
  int itemCount = 0;
  double sellingPrice= 0;
  double actualPrice= 0;
  double discount= 0;
  ProductDetailsReqModel? resModel;
  ProductDetailsBloc() : super(ProductDetailsInitialState()){
    on<ProductDetailsReqEvent>((event,emit) async{
      emit(ProductDetailsLoadingState());
      try{
        resModel  =  await ProductRepo.getProductDetails(productCode: event.productCode);
       await ProductRepo.getProductAddRecommended(productCode: event.productCode);
       double discount = await calculatePriceDiscount(resModel!.productDetailsResModel!);
      // await calculatePriceAmount(double.parse(resModel.sell_price!),double.parse(resModel.actual_price!),qty: 1);
        emit(ProductDetailsLoadedState(productDetailsReqModel: resModel,discount: discount));
      }catch(e){
        Fluttertoast.showToast(msg: e.toString());
        emit(ProductDetailsErrorState(errorMsg: e.toString()));
      }
    });

    on<ProductQtyIncrementEvent>((event,emit)async{
      itemCount++;
      event.count++;
      await  calculatePriceAmount(event.price,event.actualPrice, event.count);
      emit((state as ProductDetailsLoadedState).copyWith(qtyCount: event.count,sellPrice: sellingPrice,actualPrice: actualPrice,discount: discount));
    });

    on<ProductQtyDecrementEvent>((event,emit) async{
      if(event.count > 1){
        itemCount--;
        event.count--;
      }
      await  calculatePriceAmount(event.price,event.actualPrice, event.count);
      emit((state as ProductDetailsLoadedState).copyWith(qtyCount: event.count,sellPrice: sellingPrice,actualPrice: actualPrice,discount: discount));
    });

    on<ProductWishListAddEvent>((event,emit)async{

      resModel  =  await ProductRepo.getProductDetails(productCode: event.productCode);
      resModel!.productDetailsResModel!.is_wishlisted = event.flage;
    //  Fluttertoast.showToast(msg: event.productCode.toString());
          emit((state as ProductDetailsLoadedState).copyWith(productDetailsResModel: resModel));
     // emit(ProductDetailsLoadedState(productDetailsReqModel: resModel));
    });
    
  }

  calculatePriceAmount(double price,double actualprice, int qty){
     actualPrice = 0;
     sellingPrice =0;
     discount = 0;
     sellingPrice = price * qty;
     actualPrice = actualprice * qty;
     discount = ((actualprice * qty - price * qty)/actualprice * qty)*100;

   // return discount;
  }
  calculatePriceDiscount(ProductDetailsResModel resModel, {int qty=1}) async{
    double? discount=0;

   // grossTotal = double.parse(resModel.actual_price! * qty) - double.parse(resModel.sell_price! * qty);
    if(resModel.has_variations == 0){
      discount =
          (double.parse(resModel.actual_price!) * qty - double.parse(resModel.sell_price!) * qty) / double.parse(resModel.actual_price!) * qty *100;
     // double discountPercentage =
         // (double.parse(resModel.actual_price!) * qty - double.parse(resModel.sell_price!) * qty) /
            //  (double.parse(resModel.actual_price!) * qty) * 100;
    }else{

    }
    return discount;
  }


}