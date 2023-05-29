import 'package:flutter/material.dart';

import 'circular_progress.dart';

Future circularDialog(BuildContext context, {bool demisable = false}) {
  return showDialog(
    context: context,
    builder: (context) {
      return WillPopScope(
        onWillPop: () => Future.value(demisable),
        child: const CustomCircularProgress(),
      );
    },
  );
}
