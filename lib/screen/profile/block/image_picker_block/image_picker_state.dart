import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class ImagePickerState extends Equatable{}

class ImagePickerInitialState extends ImagePickerState{
  @override
  List<Object?> get props => [];
}
class ImagePickerLoadedState extends ImagePickerState{

   final XFile? file;
   final String? path;
   final String?  getPickedImage;
   ImagePickerLoadedState({this.file,this.getPickedImage,this.path});
   ImagePickerLoadedState copyWith({XFile? file,getPickedImage,path}){
    return ImagePickerLoadedState(
      file: file ?? this.file,
        getPickedImage: getPickedImage ?? this.getPickedImage,
      path: path ?? this.path,
    );
  }
  @override
  List<Object?> get props => [file,getPickedImage,path];
}

