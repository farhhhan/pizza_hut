part of 'select_bloc.dart';

sealed class SelectEvent extends Equatable {
  const SelectEvent();

  @override
  List<Object> get props => [];
}
class SelectChoiceEvent extends SelectEvent{
 int select;
 SelectChoiceEvent({required this.select});
  @override
  List<Object> get props => [select];  
}