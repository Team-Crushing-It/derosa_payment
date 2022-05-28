import 'package:flutter/material.dart';

class PaymentProcessing extends StatefulWidget {
  const PaymentProcessing({Key? key}) : super(key: key);

  @override
  _PaymentProcessingState createState() => _PaymentProcessingState();
}

class _PaymentProcessingState extends State<PaymentProcessing>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            Future.delayed(const Duration(seconds: 1), _continue);
          }
        },
      )
      ..drive(CurveTween(curve: Curves.easeOutQuart))
      ..forward();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _continue() {

  }

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
          'Processing',
          style: TextStyle(
            color: Color(0xff2A3066),
          ),
        ),
        leading: Container(),
      ),
      body: Center(
        child: CircularProgressIndicator(
          value: controller.value,
          semanticsLabel: 'circular progress indicator',
        ),
      ),
    );
  }
}