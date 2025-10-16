import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable{}

class ThemeReqEvent extends ThemeEvent{
  bool isDark;
  ThemeReqEvent({required this.isDark});
  @override
  List<Object?> get props => [isDark];
}