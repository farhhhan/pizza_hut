part of 'autho_complete_bloc.dart';

 class AuthoCompleteEvent extends Equatable {
  const AuthoCompleteEvent();

  @override
  List<Object> get props => [];
}
class AuthoCompleteLoadedEvent extends AuthoCompleteEvent{
 final String serachInput;

  AuthoCompleteLoadedEvent({ this.serachInput=''});
  
  @override
  List<Object> get props => [serachInput];
}
class afterGetEvent extends AuthoCompleteEvent{

}
class addMarkerEvent extends AuthoCompleteEvent{
   Marker marker;

  addMarkerEvent({required this.marker});
  
  @override
  List<Object> get props => [marker];
}