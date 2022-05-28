import 'package:flutter/material.dart';

class PaymentComplete extends StatelessWidget {
  const PaymentComplete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            // ignore: sized_box_for_whitespace
            child: Container(width: 200, child: Image.asset('logo_light.png')),
          )
        ],
        backgroundColor: Colors.white,
        title: const Text(
          'Payment Complete',
          style: TextStyle(
            color: Color(0xff2A3066),
          ),
        ),
        leading: Container(),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: const [
                Icon(
                  Icons.check_sharp,
                  color: Colors.green,
                  size: 70.0,
                ),
                Text('Payment can take up to 2 days to process'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}