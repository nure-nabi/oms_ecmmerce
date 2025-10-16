import 'package:equatable/equatable.dart';

import '../model/cart_model.dart';

abstract class CartState extends Equatable{

}

class CartInitialState extends CartState{
  @override
  List<Object?> get props => [];
}
class CartLoadingState extends CartState{
  @override
  List<Object?> get props => [];
}
class CartLoadedState extends CartState{
  CartResModel? cartResModel;
  final int? count;
  final double? totalAmount;
  final int? cartLenght;
  List<int>? qtyLits;
  bool? updateFlag;
  List<bool>? checkedCart;
  List<String>? checkedValue;
  List<CartProductModel>? tempCartList;
  CartLoadedState({ this.cartResModel, this.count=0,this.totalAmount,
    this.cartLenght,this.qtyLits,
     this.updateFlag,this.checkedCart,this.checkedValue,this.tempCartList});
  CartLoadedState copyWith({CartResModel? cartResModel, int? count,
    double?totalAmount,int? cartLenght, List<int>? qtyLits,updateFlag,
    List<bool>? checkedCart,List<String>? checkedValue,List<CartProductModel>? tempCartList}) {
    return CartLoadedState(
      cartResModel: cartResModel ?? this.cartResModel,
      count: count ?? this.count,
      totalAmount: totalAmount ?? this.totalAmount,
      cartLenght: cartLenght ?? this.cartLenght,
      qtyLits: qtyLits ?? this.qtyLits,
      updateFlag: updateFlag ?? this.updateFlag,
      checkedCart: checkedCart ?? this.checkedCart,
      checkedValue: checkedValue ?? this.checkedValue,
      tempCartList: tempCartList ?? this.tempCartList,
    );
  }

  @override
  List<Object?> get props => [cartResModel,count,totalAmount,cartLenght,checkedCart,checkedValue];
}
class CartErrorState extends CartState{
  String? errorMsg;
  CartErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}

