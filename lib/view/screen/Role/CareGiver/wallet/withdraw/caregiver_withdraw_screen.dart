import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:home_health_app/view/base/custom_button.dart';
import 'package:home_health_app/view/screen/Role/CareGiver/wallet/withdraw/withdraw_controller.dart';

class CaregiverWithDrawScreen extends StatefulWidget {
  const CaregiverWithDrawScreen({Key? key}) : super(key: key);

  @override
  State<CaregiverWithDrawScreen> createState() =>
      _CaregiverWithDrawScreenState();
}

class _CaregiverWithDrawScreenState extends State<CaregiverWithDrawScreen> {
  final WithdrawController _withdrawController = Get.put(WithdrawController());

  @override
  void dispose() {
    _withdrawController.cardHolderNameController.dispose();
    _withdrawController.cardNumberController.dispose();
    _withdrawController.securityCodeController.dispose();
    _withdrawController.cvvController.dispose();
    _withdrawController.amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Card Details'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Card Holder Name
                      const Text(
                        'Card Holder Name',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller:
                            _withdrawController.cardHolderNameController,
                        decoration: InputDecoration(
                          hintText: 'Enter card holder name',
                          filled: true,
                          fillColor: const Color(0xFFF8F0FF),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Card Number
                      const Text(
                        'Card Number',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _withdrawController.cardNumberController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(16),
                        ],
                        decoration: InputDecoration(
                          hintText: 'Enter card number',
                          filled: true,
                          fillColor: const Color(0xFFF8F0FF),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Security Code
                      const Text(
                        'Security Code',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _withdrawController.securityCodeController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                        decoration: InputDecoration(
                          hintText: 'Code',
                          filled: true,
                          fillColor: const Color(0xFFF8F0FF),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // CVV
                      const Text(
                        'CVV',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _withdrawController.cvvController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                        decoration: InputDecoration(
                          hintText: 'CVV',
                          filled: true,
                          fillColor: const Color(0xFFF8F0FF),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Amount
                      const Text(
                        'Amount',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _withdrawController.amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter amount',
                          prefixText: '\$ ',
                          filled: true,
                          fillColor: const Color(0xFFF8F0FF),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              // Confirm Button at bottom
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  loading: _withdrawController.isWithdrawLoading.value,
                  onTap: () {
                    _withdrawController.sendWithDrawRequest();
                  },
                  // style: ElevatedButton.styleFrom(
                  //   backgroundColor: const Color(0xFF2D1441),
                  //   padding: const EdgeInsets.symmetric(vertical: 16),
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(8),
                  //   ),
                  // ),
                  text: 'Confirm',
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
