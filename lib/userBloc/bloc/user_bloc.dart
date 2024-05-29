import 'dart:async';
import 'dart:core';
import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/model/userModel.dart';
import 'package:pizza_app/utils/user_profile.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<ProfileGetEvent>(_profileget);
    on<profileEditEvent>(_profileEdit);

  }

  FutureOr<void> _profileget(ProfileGetEvent event, Emitter<UserState> emit)async {
    emit(loadingState());
    try{
       var user=await UserProfile().getUser();
       emit(profileSuccesState(user: user));
    }catch(e){
       print('error occur$e');
    }
  }


  FutureOr<void> _profileEdit(profileEditEvent event, Emitter<UserState> emit) async{
      emit(loadingState());
    try{
      var usermodel=UserModel(gender: event.gender, phone: event.phone, name: event.name, email: event.email, uid: event.uid, profile: event.profile);
       await UserProfile().updateUser(usermodel,event.context);
       emit(profileSuccesState(user: usermodel));
    }catch(e){
       print('error occur$e');
    }
  }
}
