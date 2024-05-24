part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}
class ProfileGetEvent extends UserEvent{}

class profileEditEvent extends UserEvent{
  String profile;
  String name;
  String phone;
  String gender;
  String uid;
  String email;
  BuildContext context;
  profileEditEvent({required this.email,required  this.name,required this.gender,required this.phone,required this.profile,required this.uid,required this.context});
  
  @override
  List<Object> get props => [name,gender,phone,profile,uid];

}