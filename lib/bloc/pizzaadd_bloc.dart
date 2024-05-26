import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/model/pizzamodel.dart';
import 'package:pizza_app/utils/pizzaRepo.dart';

part 'pizzaadd_event.dart';
part 'pizzaadd_state.dart';

class PizzaaddBloc extends Bloc<PizzaaddEvent, PizzaaddState> {
  PizzaaddBloc() : super(PizzaaddInitial()) {
    on<GetPizzaEvent>(_onPizzaGetSucces);
    on<SelectedEvent>(_onSelected);
  }

  FutureOr<void> _onPizzaGetSucces(
      GetPizzaEvent event, Emitter<PizzaaddState> emit) async {
    emit(PizzaaddInitial());
    List<Pizza> listPizza = await PizzaServiese().getPizza();
    print(listPizza.length);
    emit(PizzaGetSucces(pizzaList: listPizza));
  }

  FutureOr<void> _onSelected(SelectedEvent event, Emitter<PizzaaddState> emit) {
    
  }
}
