import 'package:flutter/material.dart';

import '../../../core/widgets/custom_app_bar.dart';


class DeposiitMoneyView extends StatefulWidget {
  const DeposiitMoneyView({super.key});

  @override
  State<DeposiitMoneyView> createState() => _DeposiitMoneyViewState();
}

class _DeposiitMoneyViewState extends State<DeposiitMoneyView> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        theme: theme,
      ),
    );
  }
}
