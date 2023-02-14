import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripePaymentServices{
  static const String publishableKey = 'pk_test_51KGVjiC6r0UrWGk6j0CIrKz5rI7byN9Mtmc3nbvOgbSzyzcC3HBiEHdc9gDGFD915uscU6zGAV2lgeGPmiSVjOvJ00n1eqWHh5';
  static const String secretKey = 'sk_test_51KGVjiC6r0UrWGk6isiqs2va5HNiHDR8YpAzHP0oOEijwITnAsDsaOdv8qVg3WqVHVUwIQ36QybsrLGDM8oygndE00D1YmM9VN';

  late Map<String, dynamic> paymentIntent;

  Future<void> makePayment(BuildContext context, String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'USD');
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent['client_secret'],
              // applePay: const PaymentSheetApplePay(merchantCountryCode: '+998',),
              // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "UZ", merchantCountryCode: "+998"),
              style: ThemeMode.dark,
              merchantDisplayName: 'Rifat Hossain'))
          .then((value) {});

      displayPaymentSheet(context);
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      Text("Payment Successfull"),
                    ],
                  ),
                ],
              ),
            ));
        paymentIntent = {};
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            content: Text("Cancelled "),
          ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }

}