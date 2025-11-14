 import 'package:equatable/equatable.dart';
import 'package:oms_ecommerce/screen/product/product_related/model/product_related_model.dart';

 abstract class ProductRelatedState extends Equatable{}

 class ProductRelatedInitialState extends ProductRelatedState{
  @override
  List<Object?> get props => [];
}

class ProductRelatedLoadingState extends ProductRelatedState{
  @override
  List<Object?> get props => [];
}

class ProductRelatedLoadedState extends ProductRelatedState{
   ProductRelatedResModel? productRelatedResModel;
   List<bool>? wishListFlag;
   ProductRelatedLoadedState({required this.productRelatedResModel,this.wishListFlag});

   ProductRelatedLoadedState copyWith(ProductRelatedResModel? productRelatedResModel, List<bool>? wishListFlag){
     return ProductRelatedLoadedState(
         productRelatedResModel: productRelatedResModel ?? this.productRelatedResModel,
         wishListFlag: wishListFlag ?? this.wishListFlag
     );
   }
  @override
  List<Object?> get props => [productRelatedResModel];
}

class ProductRelatedErrorState extends ProductRelatedState{
   String? errorMsg;
   ProductRelatedResModel? productRelatedResModel;
   List<bool>? wishListFlag;
   ProductRelatedErrorState({required this.errorMsg,this.productRelatedResModel,this.wishListFlag});
  @override
  List<Object?> get props => [errorMsg,productRelatedResModel,wishListFlag];
}