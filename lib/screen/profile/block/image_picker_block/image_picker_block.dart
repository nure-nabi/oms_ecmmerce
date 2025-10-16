import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oms_ecommerce/screen/profile/block/image_picker_block/image_picker_event.dart';
import 'package:oms_ecommerce/screen/profile/block/image_picker_block/image_picker_state.dart';
import 'package:oms_ecommerce/screen/profile/block/profile_bloc/profile_state.dart';
import 'package:oms_ecommerce/utils/image_picker_utils.dart';

class ImagePickerBlock extends Bloc<ImagePickerEvent,ImagePickerState>{

  ImagePickerUtils? imagePickerUtils;

  ImagePickerBlock(this.imagePickerUtils) : super(ImagePickerInitialState()){

    on<CameraCaptureEvent>(cameraCapture);
    on<GalleryImageEvent>(galleryImage);
  }

  void cameraCapture(
      CameraCaptureEvent event,
      Emitter<ImagePickerState> emit
      )async{
    //emit(ImagePickerInitialState());
  XFile? file =  await imagePickerUtils!.cameraCapture();

  String imagePath = await ImagePickerUtils().imageFromPath(imagePath: file!.path);
 // emit(state.copyWith(file: file,getPickedImage: imagePath,path: file.path));
  emit(ImagePickerLoadedState(file: file,getPickedImage: imagePath,path: file.path));
 // emit((state as ImagePickerLoadedState).copyWith(file: file,getPickedImage: imagePath,path: file.path));
  }

  void galleryImage(GalleryImageEvent event, Emitter<ImagePickerState> emit)async{
    XFile? file =await imagePickerUtils!.pickImageFromGallery();
    String imagePath = await ImagePickerUtils().imageFromPath(imagePath: file!.path);
    //emit(state.copyWith(file: file,path: file!.path));
   // emit((state as ImagePickerLoadedState).copyWith(file: file,));
    emit(ImagePickerLoadedState(file: file,getPickedImage: imagePath,path: file.path));
  }

}