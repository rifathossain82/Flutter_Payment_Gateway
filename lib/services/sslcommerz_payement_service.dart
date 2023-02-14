import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sslcommerz/model/SSLCAdditionalInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCCustomerInfoInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCEMITransactionInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCShipmentInfoInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/model/sslproductinitilizer/General.dart';
import 'package:flutter_sslcommerz/model/sslproductinitilizer/SSLCProductInitializer.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';

dynamic formData = {};
class SSLcommerzPaymentService{
  static Future<void> makePayment(BuildContext context) async {
    Sslcommerz sslCommerce = Sslcommerz(
      initializer: SSLCommerzInitialization(
        multi_card_name: formData['multicard'],
        currency: SSLCurrencyType.BDT,
        product_category: "Products",

        ipn_url: "your_ipn_url",
        sdkType: SSLCSdkType.LIVE,
        store_id: 'your_store_id',
        store_passwd: 'your_store_password',

        ///SSL LIVE End///
        total_amount: 500.0,
        tran_id: '245475',
      ),
    );
    sslCommerce
        .addEMITransactionInitializer(
      sslcemiTransactionInitializer: SSLCEMITransactionInitializer(
        emi_options: 1,
        emi_max_list_options: 3,
        emi_selected_inst: 2,
      ),
    )
        .addShipmentInfoInitializer(
      sslcShipmentInfoInitializer: SSLCShipmentInfoInitializer(
        shipmentMethod: "yes",
        numOfItems: 1,
        shipmentDetails: ShipmentDetails(
          shipAddress1: 'Dhaka',
          shipCity: 'Uttara',
          shipCountry: 'Bangladesh',
          shipName: 'Ship name 1',
          shipPostCode: '1100',
        ),
      ),
    )
        .addCustomerInfoInitializer(
      customerInfoInitializer: SSLCCustomerInfoInitializer(
        customerName: 'Rahim',
        customerEmail: '',
        customerAddress1: 'Motijil, Dhaka',
        customerState: '',
        customerCity: '',
        customerPostCode: '1100',
        customerCountry: 'Bangladesh',
        customerPhone: '018982536551',
      ),
    )
        .addProductInitializer(
      sslcProductInitializer: SSLCProductInitializer(
        productName: "Gadgets",
        productCategory: "Widgets",
        general: General(
          general: "General Purpose",
          productProfile: "Product Profile",
        ),
      ),
    )
        .addAdditionalInitializer(
      sslcAdditionalInitializer: SSLCAdditionalInitializer(
        valueA: "app",
        valueB: "value b",
        valueC: "value c",
        valueD: "value d",
      ),
    );
    var result = await sslCommerce.payNow();

    log('ssl Result ====>$result');
    if (result is PlatformException) {
      print("the response is: ${result.status}");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Transaction Failed!'),));
    } else {
      SSLCTransactionInfoModel model = result;
      print("ssL json" + model.toJson().toString());
      if (model.aPIConnect == 'DONE' && model.status == 'VALID') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment Success'),));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment Failed!!'),));
      }
    }
  }
}