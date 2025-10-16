

import 'package:equatable/equatable.dart';

abstract class ReviewState extends Equatable{}

class ReviewInitialState extends ReviewState{
  @override
  List<Object?> get props => [];
}

class ReviewLoadingState extends ReviewState{
  @override
  List<Object?> get props => [];
}

class ReviewLoadedState extends ReviewState{
  String? review;
  double? rating;
  ReviewLoadedState({this.rating,this.review});
  @override
  List<Object?> get props => [rating,review];
}

class ReviewErrorState extends ReviewState{
  String errorMsg;
  ReviewErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}