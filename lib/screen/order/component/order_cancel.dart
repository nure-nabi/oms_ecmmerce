import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/core/constant/colors_constant.dart';

import '../../../core/constant/textstyle.dart';
import '../../widget/text_field_decoration.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import '../bloc/reason/reason_bloc.dart';
import '../bloc/reason/reason_event.dart';
import '../bloc/reason/reason_state.dart';

class OrderCancel extends StatefulWidget {
  String orderId;
  String productName;
  String status;
   OrderCancel({super.key,required this.orderId,required this.productName,required this.status});

  @override
  State<OrderCancel> createState() => _OrderCancelState();
}

class _OrderCancelState extends State<OrderCancel> {
  TextEditingController reasonController = TextEditingController();
  final globalKey = GlobalKey<FormState>();

  @override
  void initState() {
     context.read<ReasonBloc>().add(ReasonReqEven(policyChecked: false,reasonId: "0"));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: gPrimaryColor,
        leading: InkWell(
          onTap: (){
            context.read<OrderBloc>().add(OrderShowEvent(status: widget.status));
            Navigator.pop(context);
          },
            child: Icon(Bootstrap.chevron_left)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Order Cancel",style: GoogleFonts.poppins(),),
            Text('Order no: #${widget.orderId}',style: GoogleFonts.poppins(
             fontSize: 15,
            ),),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: globalKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

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
                          borderRadius: BorderRadius.circular(5),
                        ),
                        // Add more decoration..
                      ),
                      hint: const Text(
                        'Select reason',
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
                          return 'Please select reason.';
                        }
                        return null;
                      },
                      onChanged: (value) {

                        int index = state.reasonResponse!.reasons.indexWhere((reason)=> reason.reason_name == value);
                        if(index != -1){
                          String v =  state.reasonResponse!.reasons[index].id.toString();

                          context.read<ReasonBloc>().add(ReasonReqEven(reasonId: state.reasonResponse!.reasons[index].id.toString(),policyChecked: false));
                        }


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
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                      ),
                    ),
                  );
                }else{
                  return Container();
                }
              },),
              SizedBox(height: 20,),
              TextFormField(
                controller: reasonController,
                maxLines: 4,
                decoration: InputDecoration(
                  counter: const Offstage(),
                  isDense: true,
                  hintText: 'Type reason description.....',
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                 // hintStyle: hintTextStyle,
                  contentPadding:  const EdgeInsets.all(10.0),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: primaryColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(color: Colors.grey)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
                validator: (value){
                  if(value == ""){
                    return "Please write description";
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Before cancelling the order, kindly read thoroughly our following terms and conditions:",
                    style: GoogleFonts.poppins(
                      fontSize: 12
                    ),),
                    RichText(
                      // textAlign: TextAlign.left, // Important for indentation
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "• ",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                             // color: Colors.black45,
                            ),
                          ),
                          TextSpan(
                            text: "Once you submit this form you agree to cancel the\n",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                             // color: Colors.black45,
                            ),
                          ),
                          TextSpan(
                            text: "   selected item in your order. We will be unable to retrive your order once it is cancelled.",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                             // color: Colors.black45,
                            ),
                          ),

                        ],
                      ),
                    ),
                    RichText(
                      // textAlign: TextAlign.left, // Important for indentation
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "• ",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                             // color: Colors.black45,
                            ),
                          ),
                          TextSpan(
                            text: "if you are cancelling your order partially, i.e. Not all the \n",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                             // color: Colors.black45,
                            ),
                          ),
                          TextSpan(
                            text: "   items in your order, then we will be unable to refund you the shipping fee.",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                            //  color: Colors.black45,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
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
                  return Row(
                    children: [
                      Checkbox(
                          value: state.policyChecked,
                          focusColor: Colors.white,
                          checkColor: gPrimaryColor,
                          onChanged: (policyChecked){
                            context.read<ReasonBloc>().add(ReasonReqEven(policyChecked: !state.policyChecked!,reasonId: state.reasonId.toString(),));
                            // Fluttertoast.showToast(msg: policyChecked.toString());
                          }),
                      Expanded(child: Text("I have read and accepted the Cancellation policy mentioned below.",maxLines: 2,
                        style: GoogleFonts.poppins(
                          fontSize: 12
                        ),))
                    ],
                  );
                }else{
                  return Container();
                }
              },),
              SizedBox(height: 30,),
              BlocConsumer<ReasonBloc,ReasonState>(
                  builder: (context, state){
                    if(state is ReasonInitialState){
                      return  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: gPrimaryColor, // Background color
                                foregroundColor: Colors.white, // Text color
                                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8), // Rounded corners
                                ),
                                elevation: 0, // Shadow depth
                              ),
                              onPressed: (){},
                              child: Text("Cancel")
                          )
                        ],
                      );
                    }else if(state is ReasonLoadedState){

                      return  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          state.policyChecked == true ?
                          TextButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: gPrimaryColor, // Background color
                                foregroundColor: Colors.white, // Text color
                                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8), // Rounded corners
                                ),
                                elevation: 0, // Shadow depth
                              ),
                              onPressed: (){
                                if(globalKey.currentState!.validate() && state.policyChecked!){
                                  context.read<ReasonBloc>().add(ReasonSaveEven(
                                      orderId:  widget.orderId,
                                      reasonId:    state.reasonId.toString(),
                                      description:   reasonController.text.trim(),
                                      check:  state.policyChecked,
                                   context: context)
                                  );
                                }else{
                                 // Fluttertoast.showToast(msg: "msg");
                                }

                              },
                              child: Text("Order Cancel",style: GoogleFonts.poppins(
                                letterSpacing: 1
                              ),)
                          ) : TextButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: gPrimaryColor, // Background color
                                foregroundColor: Colors.white, // Text color
                                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8), // Rounded corners
                                ),
                                elevation: 0, // Shadow depth
                                disabledBackgroundColor: gPrimaryColor, // Maintains background color when disabled
                                disabledForegroundColor: Colors.white.withOpacity(0.38), // Standard disabled text opacity
                              ),
                              onPressed: null,
                              child: Text("Order Cancel",style: GoogleFonts.poppins(
                                  letterSpacing: 1
                              ),)
                          )
                        ],
                      );
                    }else{
                      return Container();
                    }
                  },
                  listener: (context ,state){

                  })
            ],
          ),
        ),
      ),
    );
  }
}
