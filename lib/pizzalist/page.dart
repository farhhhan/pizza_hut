import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pizza_app/bloc/pizzaadd_bloc.dart';
import 'package:pizza_app/page.dart';
import 'package:pizza_app/pizzalist/filter.dart';
import 'package:pizza_app/pizzalist/food_card.dart';

class FoodListPage extends StatefulWidget {
  const FoodListPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PizzaaddBloc>().add(GetPizzaEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Back'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<PizzaaddBloc, PizzaaddState>(
            builder: (context, state) {
               if(state is PizzaGetSucces){
                return Column(
                children: <Widget>[
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Pizza Hut",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Filters(),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: StaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      children: [
                         Center(
                          child: Text(
                            "Found ${state.pizzaList!.length}'results",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        for (var i = 0; i < state.pizzaList!.length; i++)
                          InkWell(
                              onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FoodDetailPage(
                                              foodData: state.pizzaList![i],
                                            )),
                                  ),
                              child: FoodCard(foodData:  state.pizzaList![i]))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              );
            
               }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
               }
            }
          ),
        ),
      ),
    );
  }
}
