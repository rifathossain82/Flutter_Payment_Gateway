import 'package:flutter/material.dart';
import 'package:paypal/services/paypal_payment_serivices.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paypal Payment Gateway'),
      ),
      body: Center(
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white)
          ),
          onPressed: () {
            PaypalPaymentServices.makePayment(context);
          },
          child: Image.asset('assets/paypal.png', height: 50, width: 200,),
        ),
      ),
    );
  }
}
