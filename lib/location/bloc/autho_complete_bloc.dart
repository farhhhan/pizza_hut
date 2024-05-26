import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pizza_app/location/searcgRepo.dart';

part 'autho_complete_event.dart';
part 'autho_complete_state.dart';

class AuthoCompleteBloc extends Bloc<AuthoCompleteEvent, AuthoCompleteState> {
  SearchRepo serachRepo;
  AuthoCompleteBloc(this.serachRepo) : super(AuthoCompleteLoading()) {
    on<AuthoCompleteEvent>((event, emit)async {
        if(event is AuthoCompleteLoadedEvent){
          List<dynamic>? lists=await serachRepo.getSuggetion(event.serachInput);
          print('hellow');
          emit(AuthoCompleteLoaded(authocomplete: lists!));
        } 
        if(event is afterGetEvent){
            emit(AuthoCompleteLoaded(authocomplete: []));
        }
        if(event is addMarkerEvent){
          print(event.marker);
           emit(AuthoCompleteState(markerlist: event.marker));
        }
    });
  }
}
