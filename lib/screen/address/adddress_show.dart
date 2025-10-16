import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/component/loading_overlay.dart';
import 'package:oms_ecommerce/core/constant/colors_constant.dart';
import 'package:oms_ecommerce/core/services/routeHelper/route_name.dart';
import 'package:oms_ecommerce/screen/address/bloc/address_bloc.dart';
import 'package:oms_ecommerce/screen/address/bloc/address_event.dart';
import 'package:oms_ecommerce/screen/address/bloc/address_state.dart';

import '../profile/model/user_model.dart';
import 'bloc/provience_bloc.dart';
import 'bloc/provience_event.dart';

class AddressShow extends StatefulWidget {

  const AddressShow({super.key, });

  @override
  State<AddressShow> createState() => _AddressShowState();
}

class _AddressShowState extends State<AddressShow> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddressBloc>().add(AddressReqEvent(
        typeHomeFlag: false,
        typeOfficeFlag: false,
        shippingFlag: false,
        billingFlag: false,
      ));
    //  context.read<AddressBloc>().add(AddressReqEvent());
    });
  }
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AddressBloc,AddressState>(
    //  bloc: BlocProvider.of<AddressBloc>(context),
      builder: (BuildContext context, state) {
      if(state is AddressLoadingState){
        return Scaffold(
          appBar: AppBar(
            title: Text('My Address',style: GoogleFonts.poppins(
                letterSpacing: 1
            )),
            elevation: 0,
            centerTitle: true,
         //   backgroundColor: Color(0xff003466),
            leading: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Bootstrap.chevron_left)),
          ),

          body: Padding(
            padding: EdgeInsets.all(10),
            child: Center(child: CircularProgressIndicator())
          ),
        );
      }else if(state is AddressLoadedState){
        //Fluttertoast.showToast(msg: state.addressResponseModel!.addresses!.length.toString());
        return Scaffold(
          appBar: AppBar(
            title: Text('My Address',style: GoogleFonts.poppins(
                letterSpacing: 1
            )),
            elevation: 0,
            centerTitle: true,
          //  backgroundColor: Color(0xff003466),
            leading: InkWell(
                onTap: (){
                  context.read<AddressBloc>().add(AddressReqEvent());
                  Navigator.pop(context);
                },
                child: Icon(Bootstrap.chevron_left)),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xff003466),
            onPressed: () {
              Navigator.pushReplacementNamed(context, addressPage,
                  arguments:
                  {
                    'addressList' : state.addressResponseModel!.addresses!,
                    'addressUpdate' : "New",
                    'index' : 0
                  }
              );
            },
            child: Icon(Bootstrap.plus,color: Colors.white,),

          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: state.addressResponseModel!.addresses!.isNotEmpty? ListView.builder(
                itemCount:state.addressResponseModel!.addresses!.length,
                itemBuilder: (BuildContext context,index){
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Icon(Bootstrap.house,size: 30,),
                              SizedBox(width: 10,),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text( state.addressResponseModel!.addresses![index].address_type! == "H" ? "Home" : "Office",style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800
                                  )),
                                  Text('${ state.addressResponseModel!.addresses![index].full_name}',style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: Colors.grey[500]
                                  ),),
                                  Text('${state.addressResponseModel!.addresses![index].address}',style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: Colors.grey[500]
                                  ),),
                                ],
                              ),
                              Spacer(),
                              InkWell(
                                  onTap: (){
                                    Navigator.pushReplacementNamed(context, addressUpdatePage,
                                        arguments:
                                        {
                                          'addressList' : state.addressResponseModel!.addresses,
                                          'addressUpdate' : "Update",
                                          'index' : index,
                                        }
                                    );

                                    context.read<ProvienceBloc>().add(ProvienceReqEvent(
                                      province: state.addressResponseModel!.addresses![index].provience!.province_name!,
                                      city: state.addressResponseModel!.addresses![index].city!.city!,
                                      zone: state.addressResponseModel!.addresses![index].zone!.zone_name!,
                                      indexProvience: -1,
                                      indexCity: 0,
                                      indexZone: 0,
                                    ));
                                  },
                                  child: Icon(Bootstrap.pen,size: 20,)),
                              SizedBox(width: 20,),
                              InkWell(
                                  onTap: (){
                                    LoadingOverlay.show(context);
                                    context.read<AddressBloc>().add(AddressDeleteEvent(id:  state.addressResponseModel!.addresses![index].id.toString()));
                                  },
                                  child: Icon(Bootstrap.trash,size: 20,color: Colors.red,)),
                            ],
                          ),

                          if( state.addressResponseModel!.addresses![index].default_billing! == "Y")
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 7,vertical: 2),
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1,color: Colors.green),
                                  color: gPrimaryColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.all(Radius.circular(5))
                              ),
                              child: Text("default billing address",style: GoogleFonts.poppins(
                                  fontSize: 15, ),),
                            ),
                          SizedBox(height: 5,),
                          if( state.addressResponseModel!.addresses![index].default_shipping! == "Y")
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 7,vertical: 2),
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1,color: Colors.green),
                                  color: Colors.green.withOpacity(0.3),
                                  borderRadius: BorderRadius.all(Radius.circular(5))
                              ),
                              child: Text("default shipping address",style: GoogleFonts.poppins(
                                  fontSize: 15, ),),
                            ),

                          if( state.addressResponseModel!.addresses![index].default_billing! == "")
                            InkWell(
                              onTap: (){
                                LoadingOverlay.show(context);
                                context.read<AddressBloc>().add(AddressBillingBillingEvent(id: state.addressResponseModel!.addresses![index].id!.toString()));
                              },
                              child: Text("Make default billing address",style: GoogleFonts.poppins(
                                  fontSize: 15, color: gPrimaryColor),),
                            ),
                          SizedBox(height: 2,),

                          if( state.addressResponseModel!.addresses![index].default_shipping! == "")
                            InkWell(
                              onTap: (){
                                LoadingOverlay.show(context);
                                context.read<AddressBloc>().add(AddressBillingShippingEvent(id: state.addressResponseModel!.addresses![index].id!.toString()));
                              },
                              child: Text("Make default shipping address",style: GoogleFonts.poppins(fontSize: 15,
                                  color: gPrimaryColor),),
                            ),
                        ],
                      ),
                    ),
                  );
                }
            ) : Center(child: Text("Address no available...",style: GoogleFonts.poppins(

            ),)),
          ),
        );
      }else{
        return Container();
      }
    },);
  }
}
