import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oms_ecommerce/screen/product/bloc/serch_bloc/search_event.dart';
import 'package:oms_ecommerce/screen/product/bloc/serch_bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent,SearchState>{
  SearchBloc() : super(SearchState(isSearchNameList: false)){
    on<SearchEvent>((event,emit){
      emit(SearchState(isSearchNameList: event.isSearchNameList));
    });
  }
}