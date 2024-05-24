part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState();
  
  @override
  List<Object> get props => [];
}

class loadingState extends UserState{}

class profileSuccesState extends UserState{
  UserModel? user;
  profileSuccesState({required this.user});
  
  @override
  List<Object> get props => [user!];
}