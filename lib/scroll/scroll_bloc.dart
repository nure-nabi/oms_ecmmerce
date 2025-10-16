import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oms_ecommerce/scroll/scroll_event.dart';
import 'package:oms_ecommerce/scroll/scroll_state.dart';

class ScrollBloc extends Bloc<ScrollEvent,ScrollState>{
  ScrollBloc() : super(ScrollInitialState()){
    on<ScrollReqEvent>(_onScrollReqEvent);
  }

  Future<void> _onScrollReqEvent(
      ScrollReqEvent event,
      Emitter<ScrollState> emit
      ) async{
     emit(ScrollLoadedState(scrollFlag: event.scrollFlag));
  }
}