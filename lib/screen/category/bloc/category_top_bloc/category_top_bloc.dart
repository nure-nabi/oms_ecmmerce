import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_ecommerce/screen/category/api/category_repo.dart';
import 'package:oms_ecommerce/screen/category/bloc/category_top_bloc/category_top_event.dart';
import 'package:oms_ecommerce/screen/category/bloc/category_top_bloc/category_top_state.dart';
import 'package:oms_ecommerce/screen/category/model/category_top_model.dart';

class CategoryTopBloc extends Bloc<CategoryTopEvent,CategoryTopState>{
  CategoryTopResponse? response;
   CategoryTopBloc() : super(CategoryTopInitialState()){
     on<CategoryTopReqEvent>((event, omit)async{
       if(response == null){
       try{
         emit(CategoryTopLoadingState());
        response  =await  CategoryRepo.getCategoryTopHome();
         if(response!.success == true){
           omit(CategoryTopLoadedState(categoryTopResponse: response));
         }
       }catch(e){
         omit(CategoryTopErrorState(erroMsg: e.toString()));
       }
       }else{

       }


     });
   }
}