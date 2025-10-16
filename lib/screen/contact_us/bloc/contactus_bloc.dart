import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oms_ecommerce/basic_model/basic_model.dart';
import 'package:oms_ecommerce/screen/contact_us/api/contact_us_repo.dart';
import 'package:oms_ecommerce/screen/contact_us/bloc/contactus_event.dart';
import 'package:oms_ecommerce/screen/contact_us/bloc/contactus_state.dart';

class ContactusBloc extends Bloc<ContactusEvent,ContactusState>{
  ContactusBloc() : super(ContactInitialState()){
    on<ContactReqEvent>(_onContactReqEvent);
  }

  Future<void> _onContactReqEvent(
      ContactReqEvent event,
      Emitter<ContactusState> emit
      ) async{
    BasicModel basicModel = await   ContactUsRepo.saveContactUs(
        name: event.name,
        email: event.email,
        message: event.email
    );

    if(basicModel.success!){
      Fluttertoast.showToast(msg: basicModel.message!);
    }else{
      Fluttertoast.showToast(msg: basicModel.message!);
    }
  }
}