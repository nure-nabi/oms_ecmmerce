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
   ProductRelatedLoadedState({required this.productRelatedResModel});

   ProductRelatedLoadedState copyWith(ProductRelatedResModel? productRelatedResModel){
     return ProductRelatedLoadedState(
         productRelatedResModel: productRelatedResModel ?? this.productRelatedResModel
     );
   }
  @override
  List<Object?> get props => [productRelatedResModel];
}

class ProductRelatedErrorState extends ProductRelatedState{
   String? errorMsg;
   ProductRelatedErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}