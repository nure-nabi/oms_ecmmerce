import 'package:equatable/equatable.dart';

class SearchState extends Equatable{
  bool isSearchNameList = false;
  SearchState({required this.isSearchNameList});
  SearchState copyWith({required bool isSearchNameList}){
    return SearchState(
        isSearchNameList: isSearchNameList ?? this.isSearchNameList);
  }
  @override
  List<Object?> get props => [isSearchNameList];

}