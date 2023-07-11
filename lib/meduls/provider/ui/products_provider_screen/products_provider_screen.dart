import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatlli/meduls/common/bloc/home_cubit/home_cubit.dart';
import 'package:hatlli/meduls/common/models/product.dart';

import '../home_screen/components/list_product_provider.dart';

class ProductsProviderScreen extends StatelessWidget {
  const ProductsProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return GridView.builder(
            padding:
                const EdgeInsets.only(top: 30, right: 16, left: 16, bottom: 30),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 240,
                childAspectRatio: 2.3 / 4,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10),
            itemCount: state.homeResponseProvider!.products!.length,
            itemBuilder: (BuildContext context, int index) {
              Product product = state.homeResponseProvider!.products![index];
              return ItemProductProvider(product: product);
            },
          );
        },
      ),
    );
  }
}
