import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/cartbloc/bloc/cart_bloc.dart';
import 'package:pizza_app/count/bloc/count_bloc.dart';
import 'package:pizza_app/location/location_csreen.dart';
import 'package:pizza_app/poster.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(GetCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    print("Build state");
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, cartState) {
        if (cartState is GetCartState) {
          return BlocBuilder<CountBloc, CountState>(
            builder: (context, countState) {
              double totalPrice = 0;
              int totalCount = 0;

              cartState.cart.forEach((item) {
                final count = countState.counts[item.pid] ?? 1;
                totalPrice +=
                    double.parse(item.price.replaceAll(',', '.')) * count;
                totalCount += count;
              });
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  title: Text('Back'),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartState.cart.length,
                        itemBuilder: (context, index) {
                          final item = cartState.cart[index];
                          final count = countState.counts[item.pid] ?? 1;
                          return Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    Container(
                                      height: 170,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(31, 221, 215, 215),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '50% OFF',
                                                      style: TextStyle(
                                                        color: Colors.orange,
                                                        fontSize: 22,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Super Value',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.black38,
                                                        fontSize: 22,
                                                      ),
                                                    ),
                                                    Text(
                                                      item.name,
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      width: 130,
                                      child: Center(
                                        child: Text(
                                          "\$${cartState.cart[index].price}",
                                          style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                height: 160,
                                                child: Image.network('${cartState.cart[index].imageUrl}'),
                                              ),
                                              SizedBox(width: 20),
                                            ],
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Center(
                                                child: Container(
                                                  width: 120.0,
                                                  height: 50.0,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(20),
                                                      bottomRight: Radius.circular(20),
                                                    ),
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
                                                      final count = state.counts[item.pid] ?? 1;
                                                      return Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            onTap: () {
                                                              if (count > 1) {
                                                                context.read<CountBloc>().add(DecreaseEvent(item.pid));
                                                              }
                                                            },
                                                            child: const Text(
                                                              "-",
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 25,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            count.toString(),
                                                            style: const TextStyle(
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              context.read<CountBloc>().add(IncreaseEvent(item.pid));
                                                            },
                                                            child: const Text(
                                                              "+",
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 22,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 5), // Add spacing after ListView
                  ],
                ),
                bottomNavigationBar: Container(
                  height: 120,
                  decoration: BoxDecoration(color: Color.fromARGB(221, 235, 232, 232)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Item count: ${totalCount}',
                            style: TextStyle(
                              letterSpacing: 2,
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                         
                          Text(
                            ' price: ₹ ${totalPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              letterSpacing: 2,
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => AddMapScreen(
                            lists: cartState.cart,
                            totol: totalPrice.toStringAsFixed(2),
                          )));
                        },
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Order',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
