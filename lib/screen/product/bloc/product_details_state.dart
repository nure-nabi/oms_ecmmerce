import 'package:equatable/equatable.dart';
import 'package:oms_ecommerce/screen/product/model/product_details_model.dart';

abstract class ProductDetailsState extends Equatable{

}
class ProductDetailsInitialState extends ProductDetailsState{
  @override
  List<Object?> get props =>[];
}
class ProductDetailsLoadingState extends ProductDetailsState{
  @override
  List<Object?> get props => [];
}
class ProductDetailsLoadedState extends ProductDetailsState{
  ProductDetailsReqModel? productDetailsReqModel;
  double? actualPrice=0;
  double? sellPrice=0;
  double? discount=0;
  int? qtyCount=0;
  ProductDetailsLoadedState({required this.productDetailsReqModel,this.actualPrice=0,
    this.sellPrice=0,this.discount=0,this.qtyCount=1});

  ProductDetailsLoadedState copyWith({ProductDetailsReqModel? productDetailsResModel,
  double? actualPrice,
  double? sellPrice,
  double? discount,
  int? qtyCount}){
    return ProductDetailsLoadedState(
      productDetailsReqModel:
      productDetailsResModel ?? productDetailsReqModel,
         actualPrice: actualPrice ?? this.actualPrice,
      sellPrice: sellPrice ?? this.sellPrice,
      discount: discount ?? this.discount,
      qtyCount: qtyCount ?? this.qtyCount,
    );
  }

  @override
  List<Object?> get props => [productDetailsReqModel,actualPrice,sellPrice,discount,qtyCount];
}
class ProductDetailsErrorState extends ProductDetailsState{
  String? errorMsg;
  ProductDetailsErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}