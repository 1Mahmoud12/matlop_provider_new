import 'package:matlop_provider/core/themes/styles.dart';
import 'package:flutter/material.dart';

class HeaderApp extends StatelessWidget {
  const HeaderApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Builder',
      textAlign: TextAlign.center,
      style: Styles.styleHeader,
    );
  }
}
