import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_gateway_demo/view/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
  'pk_test_51KGVjiC6r0UrWGk6j0CIrKz5rI7byN9Mtmc3nbvOgbSzyzcC3HBiEHdc9gDGFD915uscU6zGAV2lgeGPmiSVjOvJ00n1eqWHh5';
  Stripe.merchantIdentifier = "App Identifier";
  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
