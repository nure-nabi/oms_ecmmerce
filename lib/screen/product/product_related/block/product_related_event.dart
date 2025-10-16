import 'package:equatable/equatable.dart';

abstract class ProductRelatedEvent extends Equatable{}

class ProductRelatedReqEvent extends ProductRelatedEvent{
  String? productCode;
  ProductRelatedReqEvent({required this.productCode});
  @override
  List<Object?> get props => throw UnimplementedError();
}