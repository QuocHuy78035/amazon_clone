import 'package:amazon_clone/features/accounts/services/account_service.dart';
import 'package:amazon_clone/features/accounts/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButton extends StatelessWidget {

  const TopButton({super.key});

  @override
  Widget build(BuildContext context) {
    final AccountServices accountServices = AccountServices();
    return Column(
      children: [
        Row(
          children: [
            AccountButton(label: 'Your Orders', onPressed: (){}),
            AccountButton(label: 'Turn Seller', onPressed: (){}),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButton(label: 'Log Out', onPressed: (){
              accountServices.logOut(context);
            }),
            AccountButton(label: 'You Wish List', onPressed: (){}),
          ],
        )
      ],
    );
  }
}
