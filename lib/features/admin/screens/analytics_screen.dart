import 'package:amazon_clone/features/accounts/services/account_service.dart';
import 'package:amazon_clone/features/admin/services/admin_service.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  final AdminService adminService = AdminService();
  AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Log Out'),
          onPressed: () => adminService.logOut(context),
        ),
      ),
    );
  }
}
