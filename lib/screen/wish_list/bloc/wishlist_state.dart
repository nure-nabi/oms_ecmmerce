import 'package:equatable/equatable.dart';
import 'package:oms_ecommerce/screen/wish_list/model/wishlsit_model.dart';

abstract class WishlistState extends Equatable{}

class WishlistInitialState extends WishlistState{
  @override
  List<Object?> get props => [];
}

class WishlistLoadingState extends WishlistState{
  @override
  List<Object?> get props => [];
}

class WishlistLoadedState extends WishlistState{
  WishlistResponse response;
  WishlistLoadedState({required this.response});

  WishlistLoadedState copyWith({
    WishlistResponse? response
  }){
    return WishlistLoadedState(
        response: response ?? this.response);
  }
  @override
  List<Object?> get props => [response];
}

class WishlistErrorState extends WishlistState{
  String erorMsg;
  WishlistErrorState({required this.erorMsg});
  @override
  List<Object?> get props => [erorMsg];
}