import 'package:equatable/equatable.dart';
import 'package:oms_ecommerce/screen/category/model/category_model.dart';

abstract class CategoryState extends Equatable {

}

class CategoryInitialState extends CategoryState{
  @override
  List<Object?> get props => [];
}
class CategoryLoadingState extends CategoryState{
  @override
  List<Object?> get props => [];
}
class CategoryLoadedState extends CategoryState{
  CategoryResModel? categoryResModel;
  int? index;
  int? index2;
  int? inde;
  CategoryLoadedState({this.categoryResModel, this.index=0,this.index2=0,this.inde});
  @override
  List<Object?> get props => [categoryResModel,index,index2,inde];
}
class CategoryErrorState extends CategoryState{
  String? errorMsg;
  CategoryErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}