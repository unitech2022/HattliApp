import 'package:flutter/cupertino.dart';
import 'package:hatlli/core/widgets/texts.dart';

import '../layout/app_fonts.dart';
import '../layout/palette.dart';

class EmptyListWidget extends StatelessWidget {
  final String message;
  const EmptyListWidget({
    super.key, required this.message,
    
  });

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Texts(title:message, family: AppFonts.taB, size: 16,textColor: Palette.mainColor,),
    );
  }
}
