import 'package:equatable/equatable.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';

List<Page> onGeneratePaymentPages(Payment payment, List<Page> pages) {
  return [
    MaterialPage<void>(child: PaymentNameForm(), name: '/payment'),
    if (payment.name != null) MaterialPage<void>(child: PaymentAgeForm()),
    if (payment.age != null) MaterialPage<void>(child: PaymentWeightForm()),
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

class PaymentNameForm extends StatefulWidget {
  @override
  _PaymentNameFormState createState() => _PaymentNameFormState();
}

class _PaymentNameFormState extends State<PaymentNameForm> {
  var _name = '';

  void _continuePressed() {
    context.flow<Payment>().update((payment) => payment.copyWith(name: _name));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => context.flow<Payment>().complete(),
        ),
        title: const Text('Name'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                onChanged: (value) => setState(() => _name = value),
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'John Doe',
                ),
              ),
              ElevatedButton(
                child: const Text('Continue'),
                onPressed: _name.isNotEmpty ? _continuePressed : null,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentAgeForm extends StatefulWidget {
  @override
  _PaymentAgeFormState createState() => _PaymentAgeFormState();
}

class _PaymentAgeFormState extends State<PaymentAgeForm> {
  int? _age;

  void _continuePressed() {
    context.flow<Payment>().update((payment) => payment.copyWith(age: _age));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Age')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                onChanged: (value) => setState(() => _age = int.parse(value)),
                decoration: const InputDecoration(
                  labelText: 'Age',
                  hintText: '42',
                ),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                child: const Text('Continue'),
                onPressed: _age != null ? _continuePressed : null,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentWeightForm extends StatefulWidget {
  @override
  _PaymentWeightFormState createState() => _PaymentWeightFormState();
}

class _PaymentWeightFormState extends State<PaymentWeightForm> {
  int? _weight;

  void _continuePressed() {
    context
        .flow<Payment>()
        .complete((payment) => payment.copyWith(weight: _weight));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weight')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  setState(() => _weight = int.tryParse(value));
                },
                decoration: const InputDecoration(
                  labelText: 'Weight (lbs)',
                  hintText: '170',
                ),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                child: const Text('Continue'),
                onPressed: _weight != null ? _continuePressed : null,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Payment extends Equatable {
  const Payment({this.name, this.age, this.weight});

  final String? name;
  final int? age;
  final int? weight;

  Payment copyWith({String? name, int? age, int? weight}) {
    return Payment(
      name: name ?? this.name,
      age: age ?? this.age,
      weight: weight ?? this.weight,
    );
  }

  @override
  List<Object?> get props => [name, age, weight];
}
