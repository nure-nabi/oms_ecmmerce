import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/basic_model/basic_model.dart';
import 'package:oms_ecommerce/core/services/routeHelper/route_name.dart';
import 'package:oms_ecommerce/screen/order/api/order_repo.dart';
import 'package:oms_ecommerce/screen/order/bloc/review/review_event.dart';
import 'package:oms_ecommerce/screen/order/bloc/review/review_state.dart';
import 'package:oms_ecommerce/utils/custome_toast.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc() : super(ReviewInitialState()) {
    on<ReviewReqEvent>(_onReviewReqEvent);
    on<ReviewRatingEvent>(_onReviewRatingEvent);
  }

  Future<void> _onReviewReqEvent(
  ReviewReqEvent event,
  Emitter<ReviewState> emit
  )async{
  BasicModel basicModel = await OrderRepo.saveReviewRating(
  rating: event.rating,
  review_detail: event.review_detail,
  product_code: event.product_code,
  order_id: event.order_id);

  if(basicModel.success!){
    CustomToast.showCustomRoast(context: event.context!, message: basicModel.message!,
        icon: Bootstrap.check_circle,iconColor: Colors.green);
    Navigator.pushReplacementNamed(event.context, orderActivityPage);
  }
  }

  Future<void> _onReviewRatingEvent(
      ReviewRatingEvent event,
      Emitter<ReviewState> emit
      )async{
     emit(ReviewLoadedState(rating: event.rating,review: event.review));
  }

}