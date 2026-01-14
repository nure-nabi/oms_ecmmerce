import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oms_ecommerce/screen/offers/bloc/offer_bloc.dart';
import 'package:oms_ecommerce/screen/offers/bloc/offer_event.dart';
import 'package:oms_ecommerce/screen/service/sharepref/get_all_pref.dart';
import 'package:oms_ecommerce/screen/splash/splash_bloc/splash_bloc.dart';
import 'package:oms_ecommerce/screen/splash/splash_bloc/splash_event.dart';
import 'package:oms_ecommerce/screen/splash/splash_bloc/splash_state.dart';

import 'package:oms_ecommerce/screen/widget/gredient_container.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constant/asstes_list.dart';
import '../../core/constant/colors_constant.dart';
import '../../core/services/routeHelper/route_name.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool loginSuccess = false;
  @override
  void initState() {
    BlocProvider.of<SplashBloc>(context).add(SplashReqEvent());
    BlocProvider.of<OfferBloc>(context).add(OfferReqEvent());
    loginSuccessShow();
    super.initState();
  //  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    // Status bar color
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    // Animation setup
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  loginSuccessShow() async{
    loginSuccess = await GetAllPref.loginSuccess();
  }

  setDialogShow()async{
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().substring(0, 10);
    prefs.setString('last_alert_date',today.toString());
  }
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // allows body to draw under status bar
      backgroundColor:Colors.grey,
      appBar: null,
      body: BlocConsumer<SplashBloc,SplashState>(builder: (
          BuildContext context, state) {
        if (state is SplashLoadingState) {
          return Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                       // width: 200,
                       // height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100)
                        ),
                        child: ClipRRect(
                           borderRadius: BorderRadius.circular(50),
                            child: Image.asset("assets/icons/gargicon.png",height: 100,width: 100,)),
                        ),
                      ),


                    const SizedBox(height: 20),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Text(
                        "",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // const CircularProgressIndicator(
                    //   color: Colors.white,
                    //   strokeWidth: 2,
                    // ),
                  ],
                ),
              ),
            ),
          );
        } else {
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
