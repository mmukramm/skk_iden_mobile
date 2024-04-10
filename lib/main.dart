import 'package:flutter/material.dart';
import 'package:skk_iden_mobile/core/keys.dart';
import 'package:skk_iden_mobile/core/theme/theme.dart';
import 'package:skk_iden_mobile/features/common/login_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      navigatorKey: navigatorKey,
      home: const LoginPage(),
    );
  }
}
