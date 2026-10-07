import 'package:flutter/material.dart';
import 'package:matamix_task/features/login/presentation/widgets/login_form.dart';
import 'package:matamix_task/features/login/presentation/widgets/login_header.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 430),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 25),
          const LoginHeader(),

          const SizedBox(height: 25),
          const LoginForm(),

          const SizedBox(height: 25),
          SizedBox(height: width < 400 ? 8 : 16),
        ],
      ),
    );
  }
}
