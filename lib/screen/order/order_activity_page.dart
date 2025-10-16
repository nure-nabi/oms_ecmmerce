import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/core/constant/colors_constant.dart';
import 'package:oms_ecommerce/screen/cart/bloc/cart_bloc.dart';
import 'package:oms_ecommerce/screen/cart/bloc/cart_event.dart';
import 'package:oms_ecommerce/screen/order/bloc/order_bloc.dart';
import 'package:oms_ecommerce/screen/order/bloc/order_state.dart';
import 'package:oms_ecommerce/screen/order/component/delivered_order.dart';
import 'package:oms_ecommerce/screen/order/component/shipped_order.dart';

import 'bloc/order_event.dart';
import 'component/cancel_order.dart';
import 'component/processing_order.dart';
import 'component/return_order.dart';

class OrderActivityPage extends StatefulWidget {
  const OrderActivityPage({super.key});

  @override
  State<OrderActivityPage> createState() => _OrderActivityPageState();
}

class _OrderActivityPageState extends State<OrderActivityPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  List<int> orderCounts = [0, 0, 0,0, 0]; // Initialize with zeros for processing, shipped, delivered, cancelled

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    // Fetch initial order counts
   // context.read<OrderBloc>().add(OrderShowEvent(status: "processing"));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders Status",style: GoogleFonts.poppins(
          letterSpacing: 1
        ),),
        elevation: 0,
        //backgroundColor: gPrimaryColor,
        leading: InkWell(
          onTap: (){
            context.read<CartBloc>().add(CartClearEvent());
            Navigator.pop(context);
          },
          child: Icon(Bootstrap.chevron_left),
        ),
      ),
      body: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderLoadedState) {
            // Update counts when orders are loaded
            setState(() {
              orderCounts = [
                state.orderResponse?.orders.orders.where((o) => o.order_status?.contains('processing') ?? false).length ?? 0,
                state.orderResponse?.orders.orders.where((o) => o.order_status?.contains('shipped') ?? false).length ?? 0,
                state.orderResponse?.orders.orders.where((o) => o.order_status?.contains('delivered') ?? false).length ?? 0,
                state.orderResponse?.orders.orders.where((o) => o.order_status?.contains('returned') ?? false).length ?? 0,
                state.orderResponse?.orders.orders.where((o) => o.order_status?.contains('cancel') ?? false).length ?? 0,
              ];
            });
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(height: 3,),
              TabBar(
                labelStyle: GoogleFonts.poppins(fontSize: 15, color: gPrimaryColor),
                controller: _tabController,
                isScrollable: true,
                indicatorColor: Colors.deepOrange,
                indicatorWeight: 2.0,
                labelColor: Colors.deepOrange,
              //  unselectedLabelColor: Colors.black,
                tabs: [
                  _buildTab("Processing", orderCounts[0]),
                  _buildTab("Shipping", orderCounts[1]),
                  _buildTab("Delivered", orderCounts[2]),
                  _buildTab("Returned", orderCounts[3]),
                  _buildTab("Cancel", orderCounts[4]),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ProcessingOrder(status: "processing"),
                    ShippedOrder(status: "shipped"),
                    DeliveredOrder(status: "delivered"),
                    ReturnOrder(status: "returned"),
                    CancelOrder(status: "cancelled"),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTab(String title, int count) {
    return Tab(
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Text(title),
          if (count > 0)
            Positioned(
              top: -12,
              right: -8,
              child: CircleAvatar(
                radius: 8,
                backgroundColor: Colors.red,
                child: Text(
                  count.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
