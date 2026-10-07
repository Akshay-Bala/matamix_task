import 'package:flutter/material.dart';
import 'package:matamix_task/features/login/presentation/widgets/login_content.dart';

class LoginPage extends StatelessWidget {
  final String? title;

  const LoginPage({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width < 500 ? 24 : 40,
                      vertical: 24,
                    ),
                    child: const LoginContent(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
