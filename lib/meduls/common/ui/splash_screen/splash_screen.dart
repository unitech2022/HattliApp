import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatlli/core/layout/palette.dart';


import '../../bloc/app_cubit/app_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppCubit.get(context).getPage(context);
    
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Palette.mainColor,
          body: Container(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset("assets/images/logo_white.png",height: 150,width: 150,),
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 50),
                      child: CircularProgressIndicator(
                        color:Colors.white,
                      )),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
