import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/services/routeHelper/route_name.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import '../bloc/order_state.dart';
import '../model/order_model.dart';

class ShippedOrder extends StatefulWidget {
  String status;
  ShippedOrder({super.key, required this.status});

  @override
  State<ShippedOrder> createState() => _ShippedOrderState();
}

class _ShippedOrderState extends State<ShippedOrder> {
  @override
  void initState() {
    context.read<OrderBloc>().add(OrderShowEvent(status: widget.status));
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
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
            child:state.orderResponse!.orders.orders.isNotEmpty ? ListView.separated(
              separatorBuilder: (context,index) => Divider(thickness: 1,),
              itemCount: state.orderResponse!.orders.orders.length,
              itemBuilder: (BuildContext context, index){
                final infoOrder = state.orderResponse!.orders.orders[index];
                return _buildOrderItem(index: index,orderModel: infoOrder,orderList: state.orderResponse!.orders.orders);
              },
            ) : Center(child: Image.asset("assets/icons/shipping.png",width: 150,),),
          );
        }else{
          return const Center(child: Text("No data...."));
        }
      },),
    );
  }
  Widget _buildOrderItem({
    required int index,
    final OrderModel? orderModel,
    final List<OrderModel>? orderList,
  }) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context,
            orderShowDetailsPage,
            arguments: {
              'orderList': orderList,
              'index': index
            }
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
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
                  SizedBox(height: 4),
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
      ),
    );
  }
}
