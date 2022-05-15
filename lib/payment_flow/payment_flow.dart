import 'dart:html';

import 'package:equatable/equatable.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';

enum PaymentMethod { existing, non }

List<Page> onGeneratePaymentPages(Payment payment, List<Page> pages) {
  return [
    MaterialPage<void>(child: PaymentSelectForm(), name: '/payment'),
    if (payment.type != null)
      const MaterialPage<void>(child: PaymentProcessing()),
    if (payment.processed != null)
      const MaterialPage<void>(child: PaymentComplete()),
  ];
}

class PaymentFlow extends StatelessWidget {
  static Route<Payment> route() {
    return MaterialPageRoute(builder: (_) => PaymentFlow());
  }

  @override
  Widget build(BuildContext context) {
    return const FlowBuilder<Payment>(
      state: Payment(),
      onGeneratePages: onGeneratePaymentPages,
    );
  }
}

class PaymentSelectForm extends StatefulWidget {
  @override
  _PaymentSelectFormState createState() => _PaymentSelectFormState();
}

class _PaymentSelectFormState extends State<PaymentSelectForm> {
  var _type = '';

  void _continuePressed() {
    context.flow<Payment>().update((payment) => payment.copyWith(type: _type));
  }

  PaymentMethod? _character;

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
          'Pay With',
          style: TextStyle(
            color: Color(0xff2A3066),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: <Widget>[
                ListTile(
                  title: const Text('Saved payment method'),
                  leading: Radio<PaymentMethod>(
                    value: PaymentMethod.existing,
                    groupValue: _character,
                    onChanged: (PaymentMethod? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.account_balance,
                        color: Colors.green,
                        size: 30.0,
                      ),
                      Text('PEOPLE\'s UNITED BANK, N.A. ****9182')
                    ],
                  ),
                ),
                ListTile(
                  title: const Text('Different payment method'),
                  leading: Radio<PaymentMethod>(
                    value: PaymentMethod.non,
                    groupValue: _character,
                    onChanged: (PaymentMethod? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.account_balance,
                            color: Colors.black,
                            size: 30.0,
                          ),
                          Text('ACH Debit'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.credit_card,
                            color: Colors.black,
                            size: 30.0,
                          ),
                          Text('Credit/Debit'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Stack(
                  children: <Widget>[
                    ElevatedButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        // backgroundColor: const Color(0xff2A3066),
                        // onSurface: Colors.white,
                        primary: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      onPressed: _character != null ? _continuePressed : null,
                      child: const Text('Continue'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
    context
        .flow<Payment>()
        .update((payment) => payment.copyWith(processed: true));
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

class Payment extends Equatable {
  const Payment({this.type, this.processed});

  final String? type;
  final bool? processed;

  Payment copyWith({String? type, bool? processed}) {
    return Payment(
        type: type ?? this.type, processed: processed ?? this.processed);
  }

  @override
  List<Object?> get props => [type, processed];
}
