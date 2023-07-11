import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:hatlli/core/utils/api_constatns.dart';
import 'package:hatlli/meduls/common/models/category.dart';

import '../../../../../core/layout/app_fonts.dart';
import '../../../../../core/widgets/texts.dart';

class ListCategories extends StatelessWidget {
final  List<CategoryModel> list;
  const ListCategories({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 77,
      child: ListView.builder(
          itemCount: list.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  height: 55,
                  width: 55,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 240, 238, 238)),
                  child: Center(
                    child: CachedNetworkImage(imageUrl: ApiConstants.imageUrl(list[index].imageUrl),width: 40,height: 40,),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                 Texts(
                    title:list[index].name,
                    family: AppFonts.taM,
                    size: 10,
                    widget: FontWeight.bold),
              ],
            );
          })),
    );
  }
}
