import 'package:equatable/equatable.dart';
import 'package:oms_ecommerce/screen/category/model/category_top_model.dart';

abstract class CategoryTopState extends Equatable{}

class CategoryTopInitialState extends CategoryTopState{
  @override
  List<Object?> get props => [];
}

class CategoryTopLoadingState extends CategoryTopState{
  @override
  List<Object?> get props => [];
}

class CategoryTopLoadedState extends CategoryTopState{
  CategoryTopResponse? categoryTopResponse;
  CategoryTopLoadedState({required this.categoryTopResponse});
  @override
  List<Object?> get props => [categoryTopResponse];
}

class CategoryTopErrorState extends CategoryTopState{
  String erroMsg;
  CategoryTopErrorState({required this.erroMsg});
  @override
  List<Object?> get props => [erroMsg];
}