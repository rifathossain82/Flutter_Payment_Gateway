import 'package:flutter/material.dart';
import 'package:payment_gateway_demo/services/StripePaymentServices.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stripe Payment Gateway'),
      ),
      body: Center(
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white)
          ),
          onPressed: () async{
            await StripePaymentServices().makePayment(context, '100');
          },
          child: Image.asset('assets/stripe.png', height: 50, width: 200,),
        ),
      ),
    );
  }
}
