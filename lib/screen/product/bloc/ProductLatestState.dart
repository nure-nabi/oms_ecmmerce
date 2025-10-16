import 'package:equatable/equatable.dart';
import 'package:oms_ecommerce/screen/product/model/latest_product_model.dart';

abstract class ProductLatestState extends Equatable{

}

class ProductLatestInitialState extends ProductLatestState{
  @override
  List<Object?> get props => throw UnimplementedError();
}
class ProductLatestLoadingState extends ProductLatestState{
  @override
  List<Object?> get props => [];
}
class ProductLatestLoadedState extends ProductLatestState{
  LatestProductResModel? latestProductResModel;
  List<bool>? wishListFlag;
  ProductLatestLoadedState({ this.latestProductResModel, this.wishListFlag});
  @override
  List<Object?> get props => [latestProductResModel];
}

class ProductLatestErrorState extends ProductLatestState{
  String? errorMsg;
  LatestProductResModel? latestProductResModel;
  List<bool>? wishListFlag;
  ProductLatestErrorState({required this.errorMsg,this.latestProductResModel,this.wishListFlag});
  @override
  List<Object?> get props => [errorMsg,latestProductResModel,wishListFlag];
}
