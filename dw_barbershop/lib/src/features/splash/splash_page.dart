import 'dart:developer';

import 'package:dw_barbershop/src/core/ui/contants.dart';
import 'package:dw_barbershop/src/core/ui/helpers/messages.dart';
import 'package:dw_barbershop/src/features/auth/login/login_page.dart';
import 'package:dw_barbershop/src/features/splash/splash_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  double _scale = 10.0;
  double _animationOpacityLogo = 0.0;

  double get _logoAnimationWidth => 100 * _scale;
  double get _logoAnimationHeight => 120 * _scale;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _animationOpacityLogo = 1.0;
        _scale = 2.0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(splashVmProvider, (_, state) async {
      await Future.delayed(const Duration(seconds: 3)).then((_) {
        state.whenOrNull(
          error: (error, stack) {
            log('Erro ao validar o login', error: error, stackTrace: stack);
            Messages.showError('Erro ao validar o login', context);
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/auth/login', (route) => false);
          },
          data: (data) {
            switch (data) {
              case SplashState.loggedADM:
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/home/adm', (route) => false);
              case SplashState.loggedEmployee:
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/home/employee', (route) => false);
              case _:
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/home/login', (route) => false);
            }
          },
        );
      });
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstants.backgroundChair),
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
        ),
        child: Center(
          child: AnimatedOpacity(
            curve: Curves.easeIn,
            opacity: _animationOpacityLogo,
            duration: const Duration(seconds: 3),
            onEnd: () {
              Navigator.of(context).pushAndRemoveUntil(
                PageRouteBuilder(
                  settings: const RouteSettings(name: 'auth/login'),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const LoginPage();
                  },
                  transitionsBuilder: (_, animation, __, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                ),
                (route) => false,
              );
            },
            child: AnimatedContainer(
              width: _logoAnimationWidth,
              height: _logoAnimationHeight,
              curve: Curves.linearToEaseOut,
              duration: const Duration(seconds: 3),
              child: Image.asset(
                ImageConstants.imgLogo,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
