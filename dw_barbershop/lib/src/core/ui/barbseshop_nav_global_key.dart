import 'package:flutter/material.dart';

class BarbershopNavGlobalKey {
  BarbershopNavGlobalKey._();

  static BarbershopNavGlobalKey? _instance;
  final navKey = GlobalKey<NavigatorState>();

  static BarbershopNavGlobalKey get instance =>
      _instance ??= BarbershopNavGlobalKey._();
}
