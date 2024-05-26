import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/auth/bloc/auth_bloc.dart';
import 'package:pizza_app/cartbloc/bloc/cart_bloc.dart';
import 'package:pizza_app/choice/bloc/select_bloc.dart';
import 'package:pizza_app/count/bloc/count_bloc.dart';
import 'package:pizza_app/food_info.dart';
import 'package:pizza_app/model/pizzamodel.dart';
import 'package:pizza_app/utils/data.dart';
import 'package:pizza_app/widgets/pizza_size.dart';

class FoodDetailPage extends StatefulWidget {
  Pizza foodData;

  FoodDetailPage({super.key, required this.foodData});

  @override
  _FoodDetailPageState createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CountBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text("Back"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 3),
                  const SizedBox(height: 15),
                  Center(
                    child: SizedBox(
                      height: 220,
                      child: Image.network(widget.foodData.imageUrl),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Center(
                          child: Container(
                            width: 120.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(29.0),
                              color: Colors.amber[300],
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.amber[300]!,
                                  blurRadius: 5.0,
                                ),
                              ],
                            ),
                            child: BlocBuilder<CountBloc, CountState>(
                              builder: (context, state) {
                                final count =
                                    state.counts[widget.foodData.id] ?? 1;
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        if (count > 1) {
                                          context.read<CountBloc>().add(
                                              DecreaseEvent(
                                                  widget.foodData.id));
                                        }
                                      },
                                      child: const Text(
                                        "-",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25),
                                      ),
                                    ),
                                    Text(
                                      count.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        context.read<CountBloc>().add(
                                            IncreaseEvent(widget.foodData.id));
                                      },
                                      child: const Text(
                                        "+",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      BlocBuilder<SelectBloc, SelectState>(
                        builder: (context, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text("Size of pizza"),
                              ),
                              SizedBox(
                                height: 1,
                              ),
                              Row(
                                children: [
                                  for (var i = 0; i < pizzaSizes.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          minimumSize: const Size(35, 40),
                                          padding: const EdgeInsets.all(1),
                                          backgroundColor: state.i == i
                                              ? const Color(0xFFB4E0FB)
                                              : Colors.transparent,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(25))),
                                          side: BorderSide(
                                              color: state.i == i
                                                  ? Colors.transparent
                                                  : Colors.grey[300]!,
                                              width: 1),
                                        ),
                                        onPressed: () {
                                          context.read<SelectBloc>().add(
                                              SelectChoiceEvent(select: i));
                                        },
                                        child: Text(
                                          pizzaSizes[i],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: state.i == i
                                                  ? Colors.grey[800]!
                                                  : Colors.grey[300]!),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          widget.foodData.name,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          const Text(
                            "\$",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.amber),
                          ),
                          Text(
                            widget.foodData.price,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const FoodInfo(
                            icon: "assets/images/star.png", value: "4.6"),
                        FoodInfo(
                            icon: "assets/images/cal.png",
                            value: "60 Calories"),
                      ],
                    ),
                  ),
                  const Text(
                    "Details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${widget.foodData.description}",
                    style: _grayText(),
                  ),
                  const SizedBox(height: 15),
                  BlocBuilder<SelectBloc, SelectState>(
                    builder: (context, states) {
                      return BlocBuilder<CountBloc, CountState>(
                        
                        builder: (context, state) {
                           final count =
                                    state.counts[widget.foodData.id] ?? 1;
                          return InkWell(
                            onTap: () {
                              print(count.toString());
                              context.read<CartBloc>().add(CartAddEvent(
                                  context: context,
                                  pid: widget.foodData.id,
                                  count: count.toString(),
                                  size: pizzaSizes[states.i],
                                  uid: FirebaseAuth.instance.currentUser!.uid,
                                  name: widget.foodData.name,
                                  description: widget.foodData.description,
                                  imageUrl: widget.foodData.imageUrl,
                                  price: widget.foodData.price,
                                  cate: widget.foodData.cate));
                            },
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.amber[300],
                                  borderRadius: BorderRadius.circular(10)),
                              child: BlocBuilder<CartBloc, CartState>(
                                builder: (context, state) {
                                  if (state is CartAddLoadingEvent) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    );
                                  } else {
                                    return Center(
                                      child: Text(
                                        "Add to Cart",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle _grayText() => TextStyle(color: Colors.grey[500], fontSize: 15);
}
