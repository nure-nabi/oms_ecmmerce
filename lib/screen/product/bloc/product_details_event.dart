import 'package:equatable/equatable.dart';

abstract class ProductDetailsEvent  extends Equatable{

}


class ProductDetailsReqEvent extends ProductDetailsEvent{
  String? productCode;
  ProductDetailsReqEvent({required this.productCode});
  @override
  List<Object?> get props => [productCode];
}

class ProductQtyIncrementEvent extends ProductDetailsEvent{
  int count=1;
  double price;
  double actualPrice;
  ProductQtyIncrementEvent({required this.count,required this.price,required this.actualPrice});
  @override
  List<Object?> get props => [count,price,actualPrice];
}
class ProductQtyDecrementEvent extends ProductDetailsEvent{
  int count;
  double price;
  double actualPrice;
  ProductQtyDecrementEvent({required this.count,required this.price,required this.actualPrice});
  @override
  List<Object?> get props => [count,price,actualPrice];
}

class ProductWishListAddEvent extends ProductDetailsEvent{
  String? productCode;
  int index;
  bool flage;
  ProductWishListAddEvent({this.productCode,required this.index,required this.flage});
  @override
  List<Object?> get props => [productCode,index,flage];
}