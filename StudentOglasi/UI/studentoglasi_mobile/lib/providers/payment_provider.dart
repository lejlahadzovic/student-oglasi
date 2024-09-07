import 'dart:convert';
import 'dart:io';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/io_client.dart';

class PaymentProvider {
  late IOClient _ioClient;

  PaymentProvider() {
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;

    _ioClient = IOClient(httpClient);
  }

  Future<void> createPaymentIntent(double amount) async {
    final paymentIntentRes = await _ioClient.post(
      Uri.parse('https://10.0.2.2:7198/Payment/create-payment-intent'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'amount': amount,
        'currency': 'bam',
      }),
    );

    final paymentIntentData = json.decode(paymentIntentRes.body);

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentData['clientSecret'],
        merchantDisplayName: 'StudentOglasi',
      ),
    );
  }

  Future<void> presentPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }
}
