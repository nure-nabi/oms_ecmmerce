import 'package:equatable/equatable.dart';
import 'package:oms_ecommerce/screen/banner/model/banner_res_model.dart';

import '../../model/promotion_res_model.dart';

abstract class PromotionState extends Equatable{

}
class PromotionInitialState extends PromotionState{
  @override
  List<Object?> get props => [];
}
class PromotionLoadingState extends PromotionState{
  @override
  List<Object?> get props => [];
}

class PromotionLoadedState extends PromotionState{
  PromotionRes? promotionRes;
  PromotionLoadedState({required this.promotionRes});
  @override
  List<Object?> get props => [promotionRes];
}

class PromotionErrorState extends PromotionState{
  String? errorMsg;
  PromotionErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}