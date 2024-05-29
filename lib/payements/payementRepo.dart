import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentRepository {
  final Razorpay _razorpay = Razorpay();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void openCheckout(Map<String, dynamic> options, Function(String) onSuccess, Function(String) onError, Function(String) onExternalWallet) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (response) => onSuccess(response.paymentId));
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (response) => onError(response.code.toString()));
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (response) => onExternalWallet(response.walletName));

    _razorpay.open(options);
  }

  Future<void> addPaymentToFirestore(String paymentId) async {
    await _firestore.collection('payments').add({
      'paymentId': paymentId,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  void dispose() {
    _razorpay.clear();
  }
}
