import 'package:equatable/equatable.dart';
import 'package:oms_ecommerce/screen/brand/model/brand_model.dart';

import '../model/brand_product_model.dart';

abstract class BrandState extends Equatable{}

class BrandInitialState extends BrandState{
  @override
  List<Object?> get props => [];
}

class BrandLoadingState extends BrandState{

  @override
  List<Object?> get props => [];
}

class BrandLoadedState extends BrandState{
  final BrandResponse? brandResponse;
  BrandLoadedState({
    this.brandResponse});

  BrandLoadedState copyWith({
    BrandResponse? brandResponse,

  }) {
    return BrandLoadedState(
      brandResponse: brandResponse ?? this.brandResponse,
    );
  }
  @override
  List<Object?> get props => [brandResponse];
}

class BrandErrorState extends BrandState{
  String errorMsg;
  BrandErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}

class BrandProductListEmptyState extends BrandState {
  @override
  List<Object?> get props => [];
}