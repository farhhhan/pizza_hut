import 'package:flutter/material.dart';

class OrderButton extends StatelessWidget {
  const OrderButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 50),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )),
        onPressed: () {},
        child: const Text(
          'Add to cart',
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
