import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class CartScreen extends StatefulWidget {
 final bool? naviFlag;
 const  CartScreen({super.key,this.naviFlag=false});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<Map<String, String>> items = [
    {'price': '\$4.39', 'quantity': '2'},
    {'price': '\$12.00', 'quantity': '2'},
    {'price': '\$4.39', 'quantity': '2'},
    {'price': '\$4.39', 'quantity': '2'},
    {'price': '\$11.75', 'quantity': '2'},
    {'price': '\$14.0', 'quantity': '1kg'},
    {'price': '\$15.0', 'quantity': '1kg'},
    {'price': '\$16.0', 'quantity': '1kg'},
    {'price': '\$17.0', 'quantity': '1kg'},
    {'price': 'Supplement', 'quantity': '1kg'},
    {'price': 'Vitamin', 'quantity': '1kg'},
    {'price': 'VitaminC', 'quantity': '1kg'},
    {'price': 'Vitamind', 'quantity': '1kg'},
    {'price': 'Worser/Vitain', 'quantity': '1kg'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEBF0F1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('My Cart'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xff003466),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10,right: 10),
        child: Column(
          children: [
            // Container(
            //   height: 50,
            //   padding: EdgeInsets.only(left: 7),
            //   decoration: BoxDecoration(
            //     color: Color(0xff003466),
            //     borderRadius: BorderRadius.all(Radius.circular(10))
            //   ),
            //   child: Row(
            //     children: [
            //       if(widget.naviFlag!)
            //      Container(
            //        height: 40,
            //        width: 40,
            //        decoration: BoxDecoration(
            //            color: Colors.white,
            //            borderRadius: BorderRadius.all(Radius.circular(50))
            //        ),
            //        child: Icon(Bootstrap.arrow_left_short,color: Color(0xff003466),),
            //      ),
            //       Expanded(
            //         flex: 2,
            //           child: Center(child: Text("My Cart",style: GoogleFonts.poppins(
            //             fontWeight: FontWeight.w600,
            //             color: Colors.white,
            //             fontSize: 16
            //           ),)))
            //     ],
            //   ),
            // ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                    ),
                    elevation: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         Expanded(
                           flex:1,
                             child: Image.network("https://garg.omsok.com/storage/app/public/backend/productimages/A100001/fleximeter_strips_blue.jpeg")
                         ),
                          SizedBox(width: 10,),
                          Expanded(
                              flex:4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text( items[index]['price']!,style: GoogleFonts.poppins(
                                      color: Colors.orange,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600
                                  )),
                                  SizedBox(height: 10,),
                                  Text( items[index]['quantity']!),
                                ],
                              )
                          ),
                          Expanded(
                              flex:2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Product Name",maxLines: 1,textAlign: TextAlign.end,style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600
                                  ),),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Expanded(child: Row(
                                        // crossAxisAlignment: CrossAxisAlignment.,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                      InkWell(
                                      onTap: (){
                              //context.read<CartBloc>().add(CartIncrementEvent(count: state.qtyLits![index],index: index,id: info.id!,addOne: 1));
                          },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.all(Radius.circular(50))
                                ),
                                child: const Icon(Bootstrap.dash,color: Colors.white,),
                              )),
                                          const SizedBox(width: 5,),
                                          //Text(state.count.toString() =="0" ? info.quantity.toString() : state.count.toString()),
                                          Text("0"),
                                          const SizedBox(width: 5,),
                                          InkWell(
                                              onTap: (){
                                                //context.read<CartBloc>().add(CartIncrementEvent(count: state.qtyLits![index],index: index,id: info.id!,addOne: 1));
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.orange,
                                                  borderRadius: BorderRadius.all(Radius.circular(50))
                                                ),
                                                child: const Icon(Bootstrap.plus,color: Colors.white,),
                                              )),

                                        ],
                                      ))
                                    ],
                                  )
                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10,bottom: 8,top: 10),
        child: Container(
          height: 40,
          padding: EdgeInsets.only(left: 7),
          decoration: BoxDecoration(
              color: Color(0xff003466),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Center(
            child: Text("Proceed to Checkout",style: GoogleFonts.poppins(
              color: Colors.white
            ),),
          ),
        ),
      ),
    );
  }
}
