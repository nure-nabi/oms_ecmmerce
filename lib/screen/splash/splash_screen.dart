import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_ecommerce/screen/service/sharepref/get_all_pref.dart';
import 'package:oms_ecommerce/screen/splash/splash_bloc/splash_bloc.dart';
import 'package:oms_ecommerce/screen/splash/splash_bloc/splash_event.dart';
import 'package:oms_ecommerce/screen/splash/splash_bloc/splash_state.dart';

import 'package:oms_ecommerce/screen/widget/gredient_container.dart';
import 'package:provider/provider.dart';

import '../../core/constant/asstes_list.dart';
import '../../core/constant/colors_constant.dart';
import '../../core/services/routeHelper/route_name.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool loginSuccess = false;
  @override
  void initState() {
    BlocProvider.of<SplashBloc>(context).add(SplashReqEvent());
    loginSuccessShow();
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  loginSuccessShow() async{
    loginSuccess = await GetAllPref.loginSuccess();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Dispatch the event when the screen initializes

    return Scaffold(
      backgroundColor:gPrimaryColor.withOpacity(0.5),
      appBar: null,
      body: BlocConsumer<SplashBloc,SplashState>(builder: (
          BuildContext context, state) {
        if(state is SplashLoadingState){
          return  Center(
            child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FittedBox(
                  fit: BoxFit.cover, // or BoxFit.scaleDown to prevent upscaling
                  child: CircleAvatar(
                    radius: 50, // Adjust as needed
                    backgroundImage: AssetImage("assets/icons/gargimage.png"),
                  ),
                ),
                SizedBox(height: 10,),
                Text("Loading.....",style: GoogleFonts.poppins(
                    color: Colors.white
                ),)
              //  CircularProgressIndicator()
              ],
            ),
          );
        }else{
          return Container();
        }
      },
        listener: (BuildContext context, Object? state) {
           if(state is SplashLoadedState){
          //   if(loginSuccess){
               Navigator.pushReplacementNamed(context,homeNavbar,arguments: 0);
         //    }else{
           //    Navigator.pushNamed(context,loginHomePath);
          //   }
          }
        },),

    );
  }

}
