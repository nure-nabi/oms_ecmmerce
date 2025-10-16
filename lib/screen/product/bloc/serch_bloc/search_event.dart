import 'package:equatable/equatable.dart';

  class SearchEvent extends Equatable{
    bool isSearchNameList = false;
    SearchEvent({required this.isSearchNameList});
  @override
  List<Object?> get props => [isSearchNameList];
}

