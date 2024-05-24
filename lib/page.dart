import 'package:flutter/material.dart';
import 'package:pizza_app/food_info.dart';
import 'package:pizza_app/model/pizzamodel.dart';

class FoodDetailPage extends StatefulWidget {
  final Pizza foodData;

  const FoodDetailPage({super.key, required this.foodData});
  @override
  // ignore: library_private_types_in_public_api
  _FoodDetailPageState createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  var qty = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 22,
                      ),
                    ),
                    const Icon(
                      Icons.favorite,
                      size: 28,
                      color: Colors.red,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: SizedBox(
                    height: 220,
                    child: Image.network(widget.foodData.imageUrl),
                  ),
                ),
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
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              if (qty > 1) {
                                setState(() {
                                  qty = qty - 1;
                                });
                              }
                            },
                            child: const Text(
                              "-",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 25),
                            ),
                          ),
                          Text(
                            qty.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                qty = qty + 1;
                              });
                            },
                            child: const Text(
                              "+",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 22),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const FoodInfo(icon: "assets/images/star.png", value: "4.6"),
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
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "${widget.foodData.description}",
                  style: _grayText(),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: InkWell(
        // onTap: () => Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const MyProfilePage()),
        // ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  TextStyle _grayText() => TextStyle(color: Colors.grey[500], fontSize: 15);
}
