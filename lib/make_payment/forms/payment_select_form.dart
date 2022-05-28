import 'package:derosa_payment/make_payment/bloc/make_payment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum PaymentMethod { existing, non }

class PaymentSelectForm extends StatefulWidget {
  @override
  _PaymentSelectFormState createState() => _PaymentSelectFormState();
  
}

class _PaymentSelectFormState extends State<PaymentSelectForm> {
  var _type = '';

  void _continuePressed() {
    context.read<MakePaymentBloc>().add(DefaultSelected());
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
