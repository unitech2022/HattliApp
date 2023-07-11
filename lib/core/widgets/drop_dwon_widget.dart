import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../meduls/common/models/category.dart';
import '../layout/app_fonts.dart';

class CustomDropDownWidget extends StatefulWidget {
  final List<CategoryModel> list;
  final Function(dynamic) onSelect;
  final String hint;
  final bool isTwoIcons;

  final Color iconColor, textColor;
  final CategoryModel? currentValue;
  final bool selectCar;

  const  CustomDropDownWidget(
      {super.key, this.selectCar = false,
      required this.currentValue,
      required this.textColor,
      required this.iconColor,
      this.isTwoIcons = false,
      required this.list,
      required this.onSelect,
      required this.hint});

  @override
  State<CustomDropDownWidget> createState() => _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<CustomDropDownWidget> {
  dynamic currentValue;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        
        items: widget.list
            .map((item) => DropdownMenuItem<dynamic>(
              
                value: item,
                child: Text(
                  item.name,
                  style:   const TextStyle(
                    fontSize: 14,
                    fontFamily: AppFonts.taM,
                    color:  Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                )))
            .toList(),
        value: currentValue,
        onChanged: (v){
          setState(() {
            currentValue = v!;
          });

          widget.onSelect(v!);

        },
        

        
        hint: Text(
          widget.hint,
          style:  const TextStyle(fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: AppFonts.taM,
                    color:  Colors.black),
        ),
      iconStyleData: IconStyleData(
        icon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SvgPicture.asset("assets/icons/drop.svg"),
        )
      ),
      
      ),
    );
  }
}
