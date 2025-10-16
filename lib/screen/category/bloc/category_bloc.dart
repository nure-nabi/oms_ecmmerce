import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oms_ecommerce/screen/category/api/category_repo.dart';
import 'package:oms_ecommerce/screen/category/bloc/category_event.dart';
import 'package:oms_ecommerce/screen/category/bloc/category_state.dart';
import 'package:oms_ecommerce/screen/category/model/category_model.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitialState()) {
    // Cache the response to avoid repeated API calls
    CategoryResModel? cachedResModel;
    on<CategoryReqEvent>((event, emit) async {
      // Show loading state

      if(cachedResModel == null) {
        emit(CategoryLoadingState());
        try {
          // Only fetch data if we don't have it cached
            cachedResModel = await CategoryRepo.getCategoryHome();
          // Emit loaded state with the new index
          emit(CategoryLoadedState(
              categoryResModel: cachedResModel!,
              index: event.index
          ));
        } catch (e) {
          emit(CategoryErrorState(errorMsg: e.toString()));
        }
      }else{
        emit(CategoryLoadedState(
            categoryResModel: cachedResModel!,
            index: event.index
        ));
      }
    });
    on<CategoryReqEvent2>((event, emit) async {
      // Show loading state
      emit(CategoryLoadingState());
      try {
        // Only fetch data if we don't have it cached
        if (cachedResModel == null) {
          cachedResModel = await CategoryRepo.getCategoryHome();
        }
        // Emit loaded state with the new index
        emit(CategoryLoadedState(
          categoryResModel: cachedResModel!,
          index2: event.index2,
        ));
      } catch (e) {
        emit(CategoryErrorState(errorMsg: e.toString()));
      }
    });


    on<CategoryReqEvent3>((event, emit) async {
      // Show loading state
      emit(CategoryLoadingState());
      try {

        // Emit loaded state with the new index
        emit(CategoryLoadedState(
          categoryResModel: cachedResModel!,
         // inde: event.inde,
        ));
      } catch (e) {
        emit(CategoryErrorState(errorMsg: e.toString()));
      }
    });
  }
}