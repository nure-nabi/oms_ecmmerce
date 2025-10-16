import 'package:equatable/equatable.dart';
import 'package:oms_ecommerce/screen/cart/model/add_cart.dart';

abstract class AddCartState extends Equatable{

}

class AddCartInitialState extends AddCartState{
  @override
  List<Object?> get props => [];
}
class AddCartLoadingState extends AddCartState{
  @override
  List<Object?> get props => [];
}
class AddCartLoadedState extends AddCartState{
  AddResCart? addResCart;
  AddCartLoadedState({required this.addResCart});
  @override
  List<Object?> get props => [addResCart];
}
class AddCartErrorState extends AddCartState{
  String? errorMsg;
  AddCartErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}
