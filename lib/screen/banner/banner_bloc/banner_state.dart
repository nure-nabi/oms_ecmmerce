import 'package:equatable/equatable.dart';
import 'package:oms_ecommerce/screen/banner/model/banner_res_model.dart';

abstract class BannerState extends Equatable{

}
class BannerInitialState extends BannerState{
  @override
  List<Object?> get props => [];
}
class BannerLoadingState extends BannerState{
  @override
  List<Object?> get props => [];
}

class BannerLoadedState extends BannerState{
  BannerResModel? bannerResModel;
  BannerLoadedState({required this.bannerResModel});
  @override
  List<Object?> get props => [bannerResModel];
}

class BannerErrorState extends BannerState{
  String? errorMsg;
  BannerErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}