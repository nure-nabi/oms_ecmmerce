import 'package:equatable/equatable.dart';
import 'package:oms_ecommerce/screen/order/model/order_model.dart';

abstract class OrderState extends Equatable{

}
class OrderInitialState extends OrderState{
  @override
  List<Object?> get props => [];
}
class OrderLoadingState extends OrderState{
  @override
  List<Object?> get props => [];
}
class OrderLoadedState extends OrderState{
final  OrderResponseModel? orderResponse;
  final String? payment_method;
  final String? billing_address;
  final String? shipping_address;
  final String? invoice_email;
  final String? product_code;
  final String? quantity;
  int? count;
  double? subTotal;
  OrderLoadedState({
     this.orderResponse,
     this.payment_method,
     this.billing_address,
     this.shipping_address,
     this.invoice_email,
     this.product_code,
     this.quantity,
     this.count, this.subTotal
  });

  OrderLoadedState copyWith({
OrderResponseModel? orderResponse,
       String? payment_method,
   String? billing_address,
   String? shipping_address,
   String? invoice_email,
   String? product_code,
   String? quantity,
  int? count,
  double? subTotal,}){
    return OrderLoadedState(
      orderResponse: orderResponse ?? this.orderResponse,
      payment_method: payment_method ?? this.payment_method,
      billing_address: billing_address ?? this.billing_address,
      shipping_address: shipping_address ?? this.shipping_address,
      invoice_email: invoice_email ?? this.invoice_email,
      product_code: product_code ?? this.product_code,
      quantity: quantity ?? this.quantity,
      count: count ?? this.count,
      subTotal: subTotal ?? this.subTotal,
    );
  }

  @override
  List<Object?> get props => [count,subTotal];


}
class OrderErrorState extends OrderState{
  String errorMsg;
  OrderErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [];
}