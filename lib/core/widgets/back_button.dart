import 'package:flutter/material.dart';

import '../helpers/helper_functions.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      minWidth: 40,
      height: 40,
        onPressed: () {
          pop(context);
        },
        child: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ));
  }
}
