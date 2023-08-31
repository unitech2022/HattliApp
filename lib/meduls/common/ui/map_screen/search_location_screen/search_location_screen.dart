import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatlli/meduls/common/bloc/address_cubit/address_cubit.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({super.key});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  var _controller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddressCubit, AddressState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin:
                    EdgeInsets.only(top: 50, left: 26, right: 26, bottom: 10),
                child: TextField(
                  controller: _controller,
                  onChanged: (value) {

                    AddressCubit.get(context).getSuggestion(value);
                  },
                  decoration: InputDecoration(
                    hintText: "اكتب اسم المكان",
                    focusColor: Colors.white,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefixIcon: Icon(Icons.map),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        _controller.clear();
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  // physics: NeverScrollableScrollPhysics(),
                  // shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 26),
                  itemCount: AddressCubit.get(context).placeList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
   

                        Navigator.of(context)
                            .pop(AddressCubit.get(context).placeList[index]);
                      },
                      title: Text(AddressCubit.get(context).placeList[index]
                          ["description"]),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
