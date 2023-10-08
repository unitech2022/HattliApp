import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';

import '../../../../../core/layout/palette.dart';
import '../../../../common/models/product.dart';
import '../../../bloc/favoraite_cubit/favoraite_cubit.dart';

class IconFavorite extends StatelessWidget {
  final Product product;
  const IconFavorite({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        return IconButton(
            padding: const EdgeInsets.all(5),
            constraints: const BoxConstraints(),
            onPressed: () {
              if (isLogin()) {
                   FavoriteCubit.get(context).addFav(product.id, context: context);
              } else {
                showDialogLogin(context: context);
              }
           
            },
            icon: Icon(
              FavoriteCubit.get(context).favFound.containsKey(product.id)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Palette.mainColor,
            ));
      },
    );
  }
}
