import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
class UpiTransaction extends StatefulWidget {
  final int amount;
  const UpiTransaction({Key? key, required this.amount} ) : super(key: key);

  @override
  State<UpiTransaction> createState() => _UpiTransactionState(this.amount);
}

class _UpiTransactionState extends State<UpiTransaction> {
  final amount;
  _UpiTransactionState( this.amount);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Confirm your Payment:',
            ),
            ElevatedButton(onPressed: (){

              Razorpay razorpay = Razorpay();
              var options = {
                'key': 'rzp_test_7XVKjn11MWHHV0',
                'amount': amount*100,
                'name': 'Aditya',
                'description': 'Article Purchase',
                'retry': {'enabled': true, 'max_count': 1},
                'send_sms_hash': true,
               // 'prefill': {'contact': '7485040890', 'email': 'aditya27872014@gmail.com'},
                'external': {
                  'wallets': ['paytm']
                }
              };
              razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
              razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
              razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
              razorpay.open(options);
            },
                child: const Text("Pay with Razorpay")),
          ],
        ),
      ),
     // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response){
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response){
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    showAlertDialog(context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response){
    showAlertDialog(context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message){
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed:  () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}