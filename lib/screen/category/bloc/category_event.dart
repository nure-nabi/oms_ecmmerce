import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable{

}

class CategoryReqEvent extends CategoryEvent{
  int index=0;
  CategoryReqEvent(this.index);
  @override
  List<Object?> get props => [index];
}

class CategoryReqEvent2 extends CategoryEvent{
  int? index2=0;
  CategoryReqEvent2(this.index2);
  @override
  List<Object?> get props => [index2];
}

class CategoryReqEvent3 extends CategoryEvent{
  int? inde=0;
  CategoryReqEvent3(this.inde);
  @override
  List<Object?> get props => [inde];
}

