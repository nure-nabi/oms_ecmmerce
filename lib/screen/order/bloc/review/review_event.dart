
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ReviewEvent extends Equatable{}

class ReviewReqEvent extends ReviewEvent{
  String rating;
  String review_detail;
  String product_code;
  String order_id;
  BuildContext context;
  ReviewReqEvent({required this.rating,
    required this.review_detail,required this.product_code,
    required this.order_id,
    required this.context});
  @override
  List<Object?> get props => [];
}

class ReviewRatingEvent extends ReviewEvent{
  String review;
  double rating;
  ReviewRatingEvent({required this.review,required this.rating});
  @override
  List<Object?> get props => [rating];
}