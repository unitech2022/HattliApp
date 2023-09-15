import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatlli/core/enums/loading_status.dart';
import 'package:hatlli/core/utils/app_model.dart';
import 'package:hatlli/core/utils/app_sittings.dart';
import 'package:hatlli/core/widgets/circular_progress.dart';
import 'package:hatlli/core/widgets/empty_list_widget.dart';

import 'package:hatlli/meduls/common/models/product.dart';
import 'package:hatlli/meduls/provider/bloc/provider_cubit/provider_cubit.dart';

import '../home_screen/components/list_product_provider.dart';

class ProductsProviderScreen extends StatefulWidget {
  const ProductsProviderScreen({super.key});

  @override
  State<ProductsProviderScreen> createState() => _ProductsProviderScreenState();
}

class _ProductsProviderScreenState extends State<ProductsProviderScreen> {
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  @override
  void initState() {
  

    super.initState();

    //
    fetchData();
    
  }

  Future<void> fetchData() async {
    print(ProviderCubit.get(context).products.length.toString() + " =====>");

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
       
        if (ProviderCubit.get(context).currentPage < ProviderCubit.get(context).totalPages &&
            ProviderCubit.get(context).newProducts.length == AppSittings.pageSize) {
          ProviderCubit.get(context).currentPage++;
          ProviderCubit.get(context).getProductsByProviderId(
              page:  ProviderCubit.get(context).currentPage,
              context: context,
              providerId: currentProvider!.id);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProviderCubit, ProviderState>(
        builder: (context, state) {

          return state.getProvidersByProviderIdState==RequestState.loaded&& ProviderCubit.get(context).products.isEmpty
              ? EmptyListWidget(message: "لا توجد منتجات".tr())
              : SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      GridView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(15),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 266,
                                  childAspectRatio: 1.2 / 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: ProviderCubit.get(context).products.length,
                          itemBuilder: (BuildContext context, int index) {
                            Product product =
                                ProviderCubit.get(context).products[index];
                            return ItemProductProvider(product: product);
                          }),
                      SizedBox(
                        height: 60,
                      ),
                      state.getProvidersByProviderIdState ==
                              RequestState.loading
                          ? CustomCircularProgress(
                              strokeWidth: 3,
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                );
       
        },
      ),
    );
  }
}
