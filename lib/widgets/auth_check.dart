import 'package:flutter/material.dart';
import 'package:my_finance/services/local_auth_service.dart';
import 'package:my_finance/utils/app_routes.dart';

import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  final ValueNotifier<bool> isLocalAuthFailed = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    checkLocalAuth();
  }

  checkLocalAuth() async {
    final auth = context.read<LocalAuthService>();
    final isLocalAuthAvailable = await auth.isBiometricAvailable();
    isLocalAuthFailed.value = false;

    if (isLocalAuthAvailable) {
      final authenticated = await auth.authenticate();

      if (!authenticated) {
        isLocalAuthFailed.value = true;
      } else {
        if (!mounted) return;
        Navigator.of(context).pushReplacementNamed(
          AppRoutes.DEFAULT,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ValueListenableBuilder<bool>(
        valueListenable: isLocalAuthFailed,
        builder: (context, failed, _) {
          if (failed) {
            return Center(
                child: ElevatedButton(
              onPressed: () {
                checkLocalAuth();
              },
              child: const Text('Tentar novamente'),
            ));
          }
          return Center(
            child: SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                color: Colors.white,
                backgroundColor: Colors.deepPurple.shade400,
              ),
            ),
          );
        },
      ),
    );
  }
}
