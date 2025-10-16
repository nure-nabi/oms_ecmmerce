
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/core/services/routeHelper/route_name.dart';
import 'package:oms_ecommerce/screen/order/order_activity_page.dart';

import '../../core/constant/colors_constant.dart';
import '../../core/constant/textstyle.dart';

import 'order_page.dart';


class OrderConfirmPage extends StatefulWidget {
  const OrderConfirmPage({super.key});


  @override
  State<OrderConfirmPage> createState() => _OrderConfirmPageState();
}

class _OrderConfirmPageState extends State<OrderConfirmPage>  with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // Makes the animation loop back and forth

    // Fade animation - goes from 0.3 to 1.0 opacity
    _fadeAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Optional scale animation for a pulsing effect
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Bootstrap.check_circle,size: 100,color: Colors.green,),
             SizedBox(height: 30,),
            const Icon(
              Bootstrap.stars, // Using the filled star variant
              size: 50,
              color: Colors.green,
            ),
            SizedBox(height: 15,),
             Text("Order Place!!!",style: headerTextStyle,),
            SizedBox(height: 15,),
            const Text("Your order has been successfully places!",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black45),),
            const SizedBox(height: 15,),

            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: InkWell(
                onTap: (){
                  Navigator.pushNamedAndRemoveUntil(context,  homeNavbar, (route)=> false);
                },
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: gPrimaryColor
                  ),
                  child:  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("CONTINUE SHOPPING",style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white
                    ),),
                  ),
                ),
              ),
            ),
            // const SizedBox(height: 15,),
            // Padding(
            //   padding: const EdgeInsets.only(left: 30,right: 30),
            //   child: InkWell(
            //     onTap: (){
            //      // Navigator.pushNamedAndRemoveUntil(context,  orderActivityPage, (route)=> false);
            //       Navigator.pushReplacementNamed(context, orderActivityPage);
            //     },
            //     child: Container(
            //       alignment: Alignment.center,
            //       width: MediaQuery.of(context).size.width,
            //       decoration: BoxDecoration(
            //           color: Colors.green.shade800,
            //         borderRadius: BorderRadius.all(Radius.circular(5))
            //       ),
            //       child:  Padding(
            //         padding: EdgeInsets.all(8.0),
            //         child: Text("VIEW ALL ORDER",style:
            //         GoogleFonts.poppins(
            //           fontSize: 16,
            //           color: Colors.white
            //         ),),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
