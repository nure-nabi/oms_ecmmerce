import 'package:equatable/equatable.dart';
import 'package:oms_ecommerce/screen/order/model/reason_model.dart';

abstract class ReasonState extends Equatable{}

class ReasonInitialState extends ReasonState{
  @override
  List<Object?> get props => [];
}

class ReasonLoadingState extends ReasonState{
  @override
  List<Object?> get props => [];
}

class ReasonLoadedState extends ReasonState{
  ReasonResponse? reasonResponse;
  bool? policyChecked;
  int? reasonId;
  ReasonLoadedState({this.reasonResponse,this.policyChecked,this.reasonId=0});

  //ImagePickerState copyWith({XFile? file,getPickedImage})
  ReasonLoadedState copyWith({ReasonResponse? reasonResponse,bool? policyChecked,int? reasonId}){
    return ReasonLoadedState(
      reasonResponse: reasonResponse ?? this.reasonResponse,
      policyChecked: policyChecked ?? this.policyChecked,
        reasonId: reasonId ?? this.reasonId
    );
  }

  @override
  List<Object?> get props => [reasonResponse,policyChecked,reasonId];
}

class ReasonErrorState extends ReasonState{
  String errorMsg;
  ReasonErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}