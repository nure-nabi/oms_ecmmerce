import 'package:equatable/equatable.dart';
import 'package:oms_ecommerce/screen/product/model/recommended_product_model.dart';

abstract class RecProductState extends Equatable{}

class RecProductInitialState extends RecProductState{
  @override
  List<Object?> get props => [];
}
class RecProductLoadingState extends RecProductState{
  @override
  List<Object?> get props => [];
}
class RecProductLoadedState extends RecProductState{
  RecommendedProductResModel? recommendedProductResModel;
  RecProductLoadedState({required this.recommendedProductResModel});

  RecProductLoadedState copyWith(RecommendedProductResModel? recommendedProductResModel){
    return RecProductLoadedState(
        recommendedProductResModel: recommendedProductResModel ?? recommendedProductResModel);
  }

  @override
  List<Object?> get props => [recommendedProductResModel];
}
class RecProductErrorState extends RecProductState{
  String? errorMsg;
  RecProductErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}