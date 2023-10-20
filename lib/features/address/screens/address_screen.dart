import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../constants/global_variable.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;

  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController _flatController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _townController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  List<PaymentItem> paymentItem = [];

  void onApplePayResult(res) {}

  @override
  void initState() {
    super.initState();
    paymentItem.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: "Total Amount",
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _flatController.dispose();
    _areaController.dispose();
    _pinCodeController.dispose();
    _townController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var address = '101 fake street';
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariable.appBarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (address.isNotEmpty)
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Text(
                      address,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'OR',
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _addressFormKey,
              child: Column(
                children: [
                  CustomTextField(
                    hintText: 'Flat, House no.Buildung',
                    textEditingController: _flatController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    hintText: 'Area, Street',
                    textEditingController: _areaController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    hintText: 'PinCode',
                    textEditingController: _pinCodeController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    hintText: 'Town/City',
                    textEditingController: _townController,
                  ),
                ],
              ),
            ),
            GooglePayButton(
              paymentConfigurationAsset: 'gpay.json',
              width: MediaQuery.of(context).size.width,
              //paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
              paymentItems: paymentItem,
              type: GooglePayButtonType.buy,
              margin: const EdgeInsets.only(top: 15.0),
              onPaymentResult: (result) => debugPrint('Payment Result $result'),
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
