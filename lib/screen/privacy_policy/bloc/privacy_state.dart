import 'package:equatable/equatable.dart';

import '../model/privacy_policy_model.dart';

abstract class PrivacyState extends Equatable{}

class PrivacyInitialState extends PrivacyState{
  @override
  List<Object?> get props => [];
}

class PrivacyLoadingState extends PrivacyState{
  @override
  List<Object?> get props => [];
}

class PrivacyLoadedState extends PrivacyState{
  PrivacyPolicyRes privacyPolicyRes;
  PrivacyLoadedState({required this.privacyPolicyRes});
  @override
  List<Object?> get props => [privacyPolicyRes];
}

class PrivacyErrorState extends PrivacyState{
  String errorMsg;
  PrivacyErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}