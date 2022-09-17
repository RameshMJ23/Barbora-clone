

import 'package:equatable/equatable.dart';

class AuthState extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingState extends AuthState{

  @override
  // TODO: implement props
  List<Object?> get props => super.props;
}

class NoUserState extends AuthState{

  @override
  // TODO: implement props
  List<Object?> get props => super.props;
}

class UserState extends AuthState{

  String uid;

  UserState({required this.uid});
  @override
  // TODO: implement props
  List<Object?> get props => [uid];
}