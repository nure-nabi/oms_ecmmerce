import 'package:equatable/equatable.dart';

abstract class ImagePickerEvent extends Equatable{
  const ImagePickerEvent();
  @override
  List<Object?> get props => [];
}

class CameraCaptureEvent extends ImagePickerEvent{
  @override
  List<Object?> get props => [];
}

class GalleryImageEvent extends ImagePickerEvent{
  @override
  List<Object?> get props => [];
}

class GalleryImageClearEvent extends ImagePickerEvent{
  @override
  List<Object?> get props => [];
}