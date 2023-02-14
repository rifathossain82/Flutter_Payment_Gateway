import 'package:flutter/material.dart';
import 'package:sslcommerz/services/sslcommerz_payement_service.dart';

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
            await SSLcommerzPaymentService.makePayment(context);
          },
          child: Image.asset('assets/sslcommerz.png', height: 50, width: 200,),
        ),
      ),
    );
  }
}
