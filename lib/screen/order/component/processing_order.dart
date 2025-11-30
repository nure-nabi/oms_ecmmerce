import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/screen/order/bloc/reason/reason_bloc.dart';
import 'package:oms_ecommerce/screen/order/bloc/reason/reason_event.dart';
import 'package:oms_ecommerce/screen/order/bloc/reason/reason_state.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/constant/colors_constant.dart';
import '../../../core/constant/textstyle.dart';
import '../../../core/services/routeHelper/route_name.dart';
import '../../widget/text_field_decoration.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import '../bloc/order_state.dart';
import '../model/order_model.dart';

class ProcessingOrder extends StatefulWidget {
  String status;
  ProcessingOrder({super.key, required this.status});

  @override
  State<ProcessingOrder> createState() => _ProcessingOrderState();
}

class _ProcessingOrderState extends State<ProcessingOrder> {

  @override
  void initState() {
    context.read<OrderBloc>().add(OrderShowEvent(status: widget.status));
    context.read<ReasonBloc>().add(ReasonReqEven(policyChecked: false));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
      onRefresh: () async{
        context.read<OrderBloc>().add(OrderShowEvent(status: widget.status));

        await context.read<OrderBloc>().stream.firstWhere(
              (state) => state is! OrderLoadingState,
        );
      },
      child: BlocBuilder<OrderBloc,OrderState>(builder: (BuildContext context, state) {
        if(state is OrderLoadingState){
          return Align(
            alignment: Alignment.center,
            child: Container(
              height: 40,
              width: 40,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
          );
        }else if(state is OrderLoadedState){
        //  Fluttertoast.showToast(msg: "processing SADFSD ${state.orderResponse!.orders.orders.length}");
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
            child: state.orderResponse!.orders!.orders.isNotEmpty ? ListView.separated(
              separatorBuilder: (context,index) => Divider(thickness: 1,),
              itemCount: state.orderResponse!.orders.orders.length,
              itemBuilder: (BuildContext context, index){
                final infoOrder = state.orderResponse!.orders.orders[index];
                return _buildOrderItem(index: index,
                    orderModel: infoOrder,orderList: state.orderResponse!.orders.orders,
                    orderId: state.orderResponse!.orders.orders[index].order_id!);
              },
            ) : Center(child: Image.asset("assets/icons/orderno.png"),),
          );
        }else{
          return const Center(child: Text("No data...."));
        }
      },),
    );
  }
  Widget _buildOrderItem({
    required int index,
    required int orderId,

    final OrderModel? orderModel,
    final List<OrderModel>? orderList,
  }) {
    return InkWell(
      onTap: (){

        Navigator.pushNamed(context,
            orderShowDetailsPage,
            arguments: {
              'orderStatus':orderModel.order_status!,
              'orderList': orderList,
              'indexOrder': index,
              'index': index,
            }
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
        //  border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: CachedNetworkImage(
                      imageUrl:  orderModel!.orderItems[0].productsModel!.main_image_full_url! != "" ?orderModel!.orderItems[0].productsModel!.main_image_full_url! : orderModel!.orderItems[0].productsModel!.image_full_url!,
                      placeholder: (context, url) =>Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child:   SizedBox(
                          height: MediaQuery.of(context).size.height * 0.080,
                          width:  MediaQuery.of(context).size.width * 0.080,
                        ),
                      ),
                      fit: BoxFit.cover,
                    ),
                    // child: Image.network(
                    //   image,
                    //   fit: BoxFit.cover,
                    //   loadingBuilder: (context, child, loadingProgress) {
                    //     if (loadingProgress == null) return child;
                    //     return Container(color: Colors.grey);
                    //   },
                    //   errorBuilder: (context, error, stackTrace) {
                    //     return Container(color: Colors.grey); // Error placeholder
                    //   },
                    // ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        orderModel.order_status!,
                        style: TextStyle(
                          // color: status.contains('cancel')
                          color: orderModel.order_status!.contains('cancel')
                              ? Colors.red
                              : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        orderModel.orderItems[0].productsModel!.product_name!,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                        ),
                      ),

                    ],
                  ),
                ),
                Icon(Bootstrap.chevron_right,size: 20,color: Colors.grey.shade500,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: ()=> Navigator.pushNamed(context, orderCancelPage,
                   arguments: {
                    'orderId' :  orderModel.order_id.toString(),
                    'productName' :  orderModel.orderItems[0].productsModel!.product_name!,
                    'status' :  widget.status,
                   }
                  )
                  //     showDialog(
                  //     context: context,
                  //   builder: (BuildContext context){
                  //    return   dialogCancel(orderId.toString());
                  //   }
                  // )
                  ,
                  child: Container(
                    padding: EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(width: 1,color: Colors.red)
                    ),
                      child: Text("Cancel Order",style: GoogleFonts.poppins(
                        color: Colors.red
                      ),)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
//order_id
 // reason_id
 // reason_description
 // policy_checked
  Widget dialogCancel(String orderId) {

    return  Dialog(
      //  shape: Border.fromBorderSide(BorderSide()),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child: SizedBox()),
                Expanded(
                  flex: 2,
                  child: Text("Order Cancel",style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.red
                  ),),
                ),
                Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                            onTap: ()=>Navigator.pop(context),
                            child: Icon(Bootstrap.x,color: Colors.black,size: 20,))))
              ],
            ),
            //reason
            BlocBuilder<ReasonBloc,ReasonState>(builder: (BuildContext context, state) {
              if(state is ReasonLoadedState){
                return   Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: DropdownButtonFormField2<String>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      // Add Horizontal padding using menuItemStyleData.padding so it matches
                      // the menu padding when button's width is not specified.
                      contentPadding: const EdgeInsets.symmetric(vertical: 5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      // Add more decoration..
                    ),
                    hint: const Text(
                      'Select Head Count',
                      style: TextStyle(fontSize: 14),
                    ),
                    items: state.reasonResponse?.reasons
                        .map((item) => DropdownMenuItem<String>(
                      value: item.reason_name,
                      child: Text(
                        item.reason_name!,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select head count.';
                      }
                      Fluttertoast.showToast(msg: value);
                      return null;
                    },
                    onChanged: (value) {

                      // state.getHeadCounter = value.toString();
                      // Fluttertoast.showToast(msg: state.paymentType);
                    },
                    onSaved: (value) {
                      // state.getHeadCounter = value.toString();
                      // Fluttertoast.showToast(msg: state.paymentType);
                      // selectedValue = value.toString();
                    },
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.only(right: 8),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 24,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                );
              }else{
                return Container();
              }
            },),
            SizedBox(height: 20,),
            TextFormField(
              maxLines: 2,
              decoration: TextFormDecoration.decoration(
                hintText: "Type reason description......",
                hintStyle: hintTextStyle,
              ),
            ),

            BlocBuilder<ReasonBloc,ReasonState>(builder: (BuildContext context, state) {
              if(state is ReasonLoadingState){
                return Checkbox(
                    value: false,
                    checkColor: Colors.green,
                    onChanged: (policyChecked){
                      // Fluttertoast.showToast(msg: policyChecked.toString());
                    });
              }else if(state is ReasonLoadedState){
                return Checkbox(
                    value: state.policyChecked,
                    checkColor: Colors.green,
                    onChanged: (policyChecked){
                      context.read<ReasonBloc>().add(ReasonReqEven(policyChecked: !state.policyChecked!));
                      // Fluttertoast.showToast(msg: policyChecked.toString());
                    });
              }else{
                return Container();
              }
            },),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: gPrimaryColor, // Background color
                      foregroundColor: Colors.white, // Text color
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Rounded corners
                      ),
                      elevation: 0, // Shadow depth
                    ),
                    onPressed: (){},
                    child: Text("Ok")
                )
              ],
            )
          ],
        ),
      ),
    );


    // return  BlocBuilder<ReasonBloc,ReasonState>(builder: (BuildContext context, state) {
    //    if(state is ReasonLoadedState){
    //     return;
    //   }else{
    //     return Container();
    //   }
    // },);
  }
}
