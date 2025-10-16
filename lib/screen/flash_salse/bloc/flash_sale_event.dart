import 'package:equatable/equatable.dart';

abstract class FlashSaleEvent extends Equatable{}

class FlashSalesReqEvent extends FlashSaleEvent{
  int limit;
  int offset;
  FlashSalesReqEvent({required this.limit, required this.offset});
  @override
  List<Object?> get props => [limit,offset];
}
class FlashSalesLazyLoadEvent extends FlashSaleEvent{
  int limit;
  int offset;
  FlashSalesLazyLoadEvent({required this.limit, required this.offset});
  @override
  List<Object?> get props => [limit,offset];
}

class FlashSalesWishListUpdateEvent extends FlashSaleEvent{
  int index;
  bool flag;
  FlashSalesWishListUpdateEvent({required this.index,required this.flag});
  @override
  List<Object?> get props => [index,flag];
}