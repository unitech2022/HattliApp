// import 'package:flutter/services.dart';

// class CustomNumberFormater extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     if (newValue.selection.baseOffset == 0) {
//       return newValue;
//     }

//     String inputData = newValue.text;

//     StringBuffer buffer = StringBuffer();

//     for (int i = 0; i < inputData.length; i++) {
//       buffer.write(inputData[i]);
//       int index = i + 1;

//       if (index % 3 == 0 && inputData.length != index) {
//         buffer.write("  ");
//       }
//     }

//     // Done
//     return TextEditingValue(
//       text: buffer.toString(),
//       selection: TextSelection.collapsed(
//         offset: buffer.toString().length,
//       ),
//     );
//   }
// }
