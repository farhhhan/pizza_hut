part of 'autho_complete_bloc.dart';

 class AuthoCompleteState extends Equatable {
 
   Marker? markerlist;
  AuthoCompleteState({ this.markerlist});
    @override
  List<Object?> get props => [markerlist];
  
}
class AuthoCompleteLoading extends AuthoCompleteState{}
class  AuthoCompleteLoaded extends AuthoCompleteState{
  final List<dynamic> authocomplete;
  AuthoCompleteLoaded({required this.authocomplete});
    @override
  List<Object> get props => [authocomplete];
}

class AuthoCompleteError extends AuthoCompleteState {}