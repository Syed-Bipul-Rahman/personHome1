import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_health_app/helpers/route.dart';
import 'package:home_health_app/helpers/time_formate.dart';
import 'package:home_health_app/view/screen/Role/CareGiver/wallet/caregiver_wallet_controller.dart';

class CaregiverWithdrawHIstoryScreen extends StatefulWidget {
  const CaregiverWithdrawHIstoryScreen({super.key});

  @override
  State<CaregiverWithdrawHIstoryScreen> createState() =>
      _CaregiverWithdrawHIstoryScreenState();
}

class _CaregiverWithdrawHIstoryScreenState
    extends State<CaregiverWithdrawHIstoryScreen> {
  final CaregiverWalletController _caregiverWalletController =
      Get.put(CaregiverWalletController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _caregiverWalletController.getWalletHistory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF6A1B9A), Color(0xFF4A148C)],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      'Withdraw History',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // History Section
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'History',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // Transaction List or Message for Empty List
              Expanded(
                child: Obx(
                  () {
                    if (_caregiverWalletController.isLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }

                    final vouchers =
                        _caregiverWalletController.transactions.value;
                    if (vouchers == null || vouchers.isEmpty) {
                      return const Center(
                        child: Text(
                          'No transactions available',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: vouchers.length,
                      itemBuilder: (context, index) {
                        final voucher = vouchers[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.attach_money,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Order# ${voucher.id.substring(0, 8)}',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.9),
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      '\$${voucher.amount}',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                TimeFormatHelper.formatDateString(
                                    voucher.createdAt),
                                // voucher.date,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
