import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/core/constant/colors_constant.dart';
import 'package:oms_ecommerce/screen/order/model/order_model.dart';
import 'package:shimmer/shimmer.dart';

class OrderShowDetails extends StatefulWidget {
 final List<OrderModel> orderModel;
 final int indexOrder;
 final int index;
  const OrderShowDetails({super.key,required this.orderModel,required this.indexOrder,required this.index});

  @override
  State<OrderShowDetails> createState() => _OrderShowDetailsState();
}

class _OrderShowDetailsState extends State<OrderShowDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.orderModel[widget.indexOrder].orderItems[widget.index].productsModel!.product_name!),
        backgroundColor: gPrimaryColor,
        leading: InkWell(
          onTap: ()=>Navigator.pop(context),
            child: Icon(Bootstrap.chevron_left)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'OD${widget.orderModel[widget.indexOrder].order_id}',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 16),
              // Product Details
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(widget.orderModel[widget.indexOrder].orderItems[widget.index].productsModel!.product_name!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // 'Rs. ${orderState.orderProductDetailList[0].orderModel.totalAmount}'),
                        Row(
                          children: [
                            Text('Rs: ${double.parse(widget.orderModel[widget.indexOrder].orderItems[widget.index].price!)}  '),
                            Text('Rs: ${double.parse(widget.orderModel[widget.indexOrder].orderItems[widget.index].actual_price!)}',style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey, fontSize: 10),),
                            // if (double.parse(orderState.orderProductDetailList[index].productDetailModel!.specialPrice) > 0)
                            Text('% OFF ${double.parse(widget.orderModel[widget.indexOrder].discount!)}', style: const TextStyle(color: Colors.green, fontSize: 12),),
                          ],
                        ),
                        // Row(
                        //   children: [
                        //     if (orderState.orderProductDetailList[index].colorModel != null) ...[
                        //
                        //       if(orderState.orderProductDetailList[index].colorModel!.is_active_flash_sale > 0)...[
                        //
                        //         Text('${double.parse(orderState.orderProductDetailList[index].colorModel!.flashSpecialPrice) > 0 ? 'Rs. ${double.parse(orderState.orderProductDetailList[index].colorModel!.flashSpecialPrice) * int.parse(orderState.orderProductDetailList[index].quantity)}' : 'Rs. ${double.parse(orderState.orderProductDetailList[index].colorModel!.flashPrice) * int.parse(orderState.orderProductDetailList[index].quantity)}'} '),
                        //         Text('${double.parse(orderState.orderProductDetailList[index].colorModel!.flashSpecialPrice) <= 0 ? '' : 'Rs. ${double.parse(orderState.orderProductDetailList[index].colorModel!.flashPrice) * int.parse(orderState.orderProductDetailList[index].quantity)}'} ', style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey, fontSize: 12),),
                        //         if (double.parse(orderState.orderProductDetailList[index].colorModel!.flashSpecialPrice) > 0)
                        //           Text('% OFRfF ${discountAmount.toStringAsFixed(1)}', style: const TextStyle(color: Colors.green, fontSize: 12),),
                        //       ]else...[
                        //         Text('${double.parse(orderState.orderProductDetailList[index].colorModel!.specialPrice) > 0 ? 'Rs. ${double.parse(orderState.orderProductDetailList[index].colorModel!.specialPrice) * int.parse(orderState.orderProductDetailList[index].quantity)}' : 'Rs. ${double.parse(orderState.orderProductDetailList[index].colorModel!.price) * int.parse(orderState.orderProductDetailList[index].quantity)}'} '),
                        //         Text('${double.parse(orderState.orderProductDetailList[index].colorModel!.specialPrice) <= 0 ? '' : 'Rs. ${double.parse(orderState.orderProductDetailList[index].colorModel!.price) * int.parse(orderState.orderProductDetailList[index].quantity)}'} ', style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey, fontSize: 12),),
                        //         if (double.parse(orderState.orderProductDetailList[index].colorModel!.specialPrice) > 0)
                        //           Text('% OFsF ${discountAmount.toStringAsFixed(1)}', style: const TextStyle(color: Colors.green, fontSize: 12),),
                        //       ]
                        //
                        //     ] else if (orderState.orderProductDetailList[index].sizeColorModel != null) ...[
                        //
                        //       if(int.parse(orderState.orderProductDetailList[index].sizeColorModel!.is_active_flash_sale) > 0)...[
                        //         Text('Rs. ${double.parse(orderState.orderProductDetailList[index].sizeColorModel!.flashSpecialPrice) > 0 ? 'Rs. ${double.parse(orderState.orderProductDetailList[index].sizeColorModel!.flashSpecialPrice) * int.parse(orderState.orderProductDetailList[index].quantity)}' : '${double.parse(orderState.orderProductDetailList[index].sizeColorModel!.flashPrice) * int.parse(orderState.orderProductDetailList[index].quantity)}'} '),
                        //         Text('Rs. ${double.parse(orderState.orderProductDetailList[index].sizeColorModel!.flashSpecialPrice) <= 0 ? '' : 'Rs. ${double.parse(orderState.orderProductDetailList[index].sizeColorModel!.flashPrice) * int.parse(orderState.orderProductDetailList[index].quantity)}'} ', style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey, fontSize: 12),),
                        //         if (double.parse(orderState.orderProductDetailList[index].sizeColorModel!.flashSpecialPrice) > 0)
                        //           Text('% OFF ${discountAmount.toStringAsFixed(1)}', style: const TextStyle(color: Colors.green, fontSize: 12),),
                        //       ]else...[
                        //         Text('Rs. ${double.parse(orderState.orderProductDetailList[index].sizeColorModel!.specialPrice) > 0 ? 'Rs. ${double.parse(orderState.orderProductDetailList[index].sizeColorModel!.specialPrice) * int.parse(orderState.orderProductDetailList[index].quantity)}' : '${double.parse(orderState.orderProductDetailList[index].sizeColorModel!.price) * int.parse(orderState.orderProductDetailList[index].quantity)}'} '),
                        //         Text('Rs. ${double.parse(orderState.orderProductDetailList[index].sizeColorModel!.specialPrice) <= 0 ? '' : 'Rs. ${double.parse(orderState.orderProductDetailList[index].sizeColorModel!.price) * int.parse(orderState.orderProductDetailList[index].quantity)}'} ', style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey, fontSize: 12),),
                        //         if (double.parse(orderState.orderProductDetailList[index].sizeColorModel!.specialPrice) > 0)
                        //           Text('% OFF ${discountAmount.toStringAsFixed(1)}', style: const TextStyle(color: Colors.green, fontSize: 12),),
                        //       ],
                        //
                        //     ] else ...[
                        //
                        //       if(orderState.orderProductDetailList[index].productDetailModel.is_active_flash_sale > 0)...
                        //       [
                        //         Text('${double.parse(orderState.orderProductDetailList[index].productDetailModel!.flashSpecialPrice) > 0 ? 'Rs. ${double.parse(orderState.orderProductDetailList[index].productDetailModel!.flashSpecialPrice) * int.parse(orderState.orderProductDetailList[index].quantity)}' : 'Rs. ${double.parse(orderState.orderProductDetailList[index]!.productDetailModel!.flashPrice) * int.parse(orderState.orderProductDetailList[index].quantity)}'} '),
                        //         Text('${double.parse(orderState.orderProductDetailList[index].productDetailModel!.flashSpecialPrice) <= 0 ? '' : 'Rs. ${double.parse(orderState.orderProductDetailList[index].productDetailModel!.flashPrice) * int.parse(orderState.orderProductDetailList[index].quantity)}'} ', style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey, fontSize: 10),),
                        //         if (double.parse(orderState.orderProductDetailList[index].productDetailModel!.flashSpecialPrice) > 0)
                        //           Text('% OFF ${discountAmount.toStringAsFixed(1)}', style: const TextStyle(color: Colors.green, fontSize: 12),),
                        //         ] else...[
                        //         Text('${double.parse(orderState.orderProductDetailList[index].productDetailModel!.specialPrice) > 0 ? 'Rs. ${double.parse(orderState.orderProductDetailList[index].productDetailModel!.specialPrice) * int.parse(orderState.orderProductDetailList[index].quantity)}' : 'Rs. ${double.parse(orderState.orderProductDetailList[index]!.price) * int.parse(orderState.orderProductDetailList[index].quantity)}'} '),
                        //         Text('${double.parse(orderState.orderProductDetailList[index].productDetailModel!.specialPrice) <= 0 ? '' : 'Rs. ${double.parse(orderState.orderProductDetailList[index].productDetailModel!.price) * int.parse(orderState.orderProductDetailList[index].quantity)}'} ', style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey, fontSize: 10),),
                        //         if (double.parse(orderState.orderProductDetailList[index].productDetailModel!.specialPrice) > 0)
                        //           Text('% OFF ${discountAmount.toStringAsFixed(1)}', style: const TextStyle(color: Colors.green, fontSize: 12),),
                        //       ]
                        //
                        //     ],
                        //   ],
                        // ),
                      ],
                    ),
                  ),

                    SizedBox(
                      width: 100,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child:  CachedNetworkImage(
                          imageUrl: widget.orderModel[widget.indexOrder].orderItems[widget.index].productsModel!.image_full_url!,
                          placeholder: (context, url) =>Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child:   SizedBox(
                              height: MediaQuery.of(context).size.height * 0.100,
                              width:  MediaQuery.of(context).size.width * 0.120,
                            ),
                          ),
                          fit: BoxFit.cover,
                        ),
                        // child: Image.network(
                        //   orderState.orderProductDetailList[index].colorModel!.productImage,
                        //   fit: BoxFit.cover,
                        //   loadingBuilder: (context, child,
                        //       loadingProgress) {
                        //     if (loadingProgress == null)
                        //       return child;
                        //     return Container(
                        //         color: Colors.grey);
                        //   },
                        //   errorBuilder:
                        //       (context, error, stackTrace) {
                        //     return Container(
                        //         color: Colors
                        //             .grey); // Error placeholder
                        //   },
                        // ),
                      ),
                    ),

                ],
              ),

              const SizedBox(height: 16),
              if(widget.orderModel[widget.indexOrder].order_status == 'processing')
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: (){
                        //  bool nextPage =  showAlertDialog(data.data[0].orderModel.orderNumberId);

                         // Fluttertoast.showToast(msg: nextPage.toString());

                        },
                        child: Text("Cancel Order",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.red),))
                  ],
                ),

              const SizedBox(height: 16),
              _buildPriceRow('Price ( item)',
                  'Rs. ${(double.parse(widget.orderModel[widget.indexOrder].orderItems[widget.index].subtotal!))}'),
              _buildPriceRow('Discount',
                  'Rs. ${(double.parse(widget.orderModel[widget.indexOrder].orderItems[widget.index].discount!))}',
                  isGreen: true),
              _buildPriceRow('Delivery Charges', 'Rs.  ${(double.parse(widget.orderModel[widget.indexOrder].orderItems[widget.index].shipping_cost!))}',
                  originalPrice:
                  'Rs. 100',
                  isGreen: true),
              const Divider(),
              _buildPriceRow('Total Amount',
                  'Rs.  ${(double.parse(widget.orderModel[widget.indexOrder].orderItems[widget.index].subtotal!)) - double.parse(widget.orderModel[widget.indexOrder].orderItems[widget.index].discount!)}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 24),

            ],
          ),
        ),
      ),
    );
  }
  Widget _buildPriceRow(String label, String amount,
      {bool isGreen = false,
        bool showInfoIcon = false,
        String? originalPrice,
        TextStyle? style}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(label),
              if (showInfoIcon)
                const Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: Icon(Icons.info_outline, size: 16),
                ),
            ],
          ),
          Row(
            children: [
              if (originalPrice != null)
                Text(
                  originalPrice,
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                  ),
                ),
              const SizedBox(width: 4),
              Text(
                amount,
                style: style?.copyWith(
                  color: isGreen ? Colors.green[700] : null,
                ) ??
                    TextStyle(
                      color: isGreen ? Colors.green[700] : null,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
