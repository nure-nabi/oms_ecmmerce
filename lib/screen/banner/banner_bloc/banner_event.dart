import 'package:equatable/equatable.dart';

abstract class BannerEvent extends Equatable{

}

class BannerReqEvent extends BannerEvent{
  @override
  List<Object?> get props => [];
}