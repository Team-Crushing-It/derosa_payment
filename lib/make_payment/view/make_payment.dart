import 'package:derosa_payment/payment_flow/payment_flow.dart';
import 'package:flutter/material.dart';

class MakePayment extends StatelessWidget {
  const MakePayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8),
              // ignore: sized_box_for_whitespace
              child:
                  Container(width: 200, child: Image.asset('logo_light.png')),
            )
          ],
          backgroundColor: Colors.white,
          title: const Text(
            'Invoice May 8 - May 14',
            style: TextStyle(
              color: Color(0xff2A3066),
            ),
          )),
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  primary: Colors.white,
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () async {
                  await Navigator.of(context).push(PaymentFlow.route());
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                        content: Text('Payment Complete!'),
                      ),
                    );
                },
                child: const Text(r'Make Payment of $750'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
