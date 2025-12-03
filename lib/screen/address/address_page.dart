

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/component/loading_overlay.dart';
import 'package:oms_ecommerce/core/services/routeHelper/route_name.dart';
import 'package:oms_ecommerce/screen/address/bloc/address_bloc.dart';
import 'package:oms_ecommerce/screen/address/bloc/address_event.dart';
import 'package:oms_ecommerce/screen/address/bloc/address_state.dart';
import 'package:oms_ecommerce/screen/address/bloc/provience_bloc.dart';
import 'package:oms_ecommerce/screen/address/bloc/provience_event.dart';
import 'package:oms_ecommerce/screen/address/bloc/provience_state.dart';
import 'package:oms_ecommerce/screen/address/model/address_model.dart';
import 'package:oms_ecommerce/screen/address/model/provience_model.dart';
import 'package:oms_ecommerce/theme/theme_bloc.dart';

import '../../core/constant/colors_constant.dart';
import '../../core/constant/textstyle.dart';
import '../../storage/hive_storage.dart';
import '../profile/model/user_model.dart';
import '../widget/text_field_decoration.dart';

class AddressPage extends StatefulWidget {
  final  List<AddressShowModel>? addressList;
  final String addressUpdate ;
  final int index;
  const AddressPage({super.key,this.addressList,required this.addressUpdate,required this.index});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final globalKey = GlobalKey<FormState>();
  String? selectedValue = null;

  int? provienceId;
  int? cityId;
  int? zoneId;

  int? in1=0;
  int? in12=0;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController landMarkController = TextEditingController();
  final TextEditingController textEditingController = TextEditingController();

  ProvienceModel? selectedProvince;
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

      context.read<ProvienceBloc>().add(ProvienceReqEvent());

      // if(widget.addressUpdate == "Update"){
      //   context.read<ProvienceBloc>().add(ProvienceReqEvent(
      //       province: widget.addressList![widget.index].provience!.province_name!,
      //   city: widget.addressList![widget.index].city!.city!,
      //   zone: widget.addressList![widget.index].zone!.zone_name!));
      // }else{
      //   context.read<ProvienceBloc>().add(ProvienceReqEvent());
      // }
      // if(widget.addressUpdate == "Update"){
      //   context.read<AddressBloc>().add(AddressReqEvent(
      //     typeHomeFlag: widget.addressList![widget.index].address_type == "H" ? true : false,
      //     typeOfficeFlag: widget.addressList![widget.index].address_type == "O" ? true : false,
      //     shippingFlag: false,
      //     billingFlag: false,
      //
      //   ));
      // }else{
      //   context.read<AddressBloc>().add(AddressReqEvent(
      //     typeHomeFlag: false,
      //     typeOfficeFlag: false,
      //     shippingFlag: false,
      //     billingFlag: false,
      //   ));
      // }

      // context.read<ProvienceBloc>().add(
      //     ProvienceProvienceIndexEvent(province: widget.addressList![0].provience!.province_name!)
      // );
    });
  }
  @override
  Widget build(BuildContext context) {

    // context.read<ProvienceBloc>().add(ProvienceReqEvent());
    //context.read<AddressBloc>().add(AddressReqEvent(typeHomeFlag: false,typeOfficeFlag: false));

    // if(widget.addressUpdate == "Update"){
    //  fullNameController.text = widget.addressList![widget.index].full_name!;
    //  mobileNoController.text = widget.addressList![widget.index].phone!;
    //  addressController.text = widget.addressList![widget.index].address!;
    //  landMarkController.text = widget.addressList![widget.index].landmark!;
    //
    // }

    return BlocBuilder<ThemeBloc,ThemeMode>(builder: (BuildContext context, state) {
      final bool isDarkMode = state == ThemeMode.dark;
      final Color backgroundColor = HiveStorage.hasPermission("Thememode") ? Colors.black : Colors.white;
      final Color textColor = HiveStorage.hasPermission("Thememode") ? Colors.grey : Colors.grey.shade400;
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Add Address",style: GoogleFonts.poppins(
                letterSpacing: 1
            ),),
            elevation: 0,
            //  backgroundColor: Color(0xff003466),
            leading: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Bootstrap.chevron_left)),
          ),
          body: BlocBuilder<AddressBloc,AddressState>(builder: (BuildContext context, state) {
            if(state is AddressLoadedState){
              // Fluttertoast.showToast(msg: state.addressTypeOfficeFlag.toString());
              return  SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: globalKey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Column(
                      children: [
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: fullNameController,
                          onChanged: (value) {
                            if (value.isEmpty) {

                            }
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please enter full name";
                            }
                            return null;
                          },
                          decoration: TextFormDecoration.decoration(
                            hintText: "Full Name",
                            hintStyle: hintTextStyle,
                            prefixIcon: Icons.person,
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: mobileNoController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          onChanged: (value) {
                            if (value.isEmpty) {

                            }
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please enter mobile no";
                            }
                            return null;
                          },
                          decoration: TextFormDecoration.decoration(
                            hintText: "Mobile No",
                            hintStyle: hintTextStyle,
                            prefixIcon: Icons.phone,
                          ),
                        ),
                        SizedBox(height: 5,),
                        BlocBuilder<ProvienceBloc,ProvienceState>(builder: (BuildContext context, state) {

                          if(state is ProvienceLoadedState){

                            // Check if provienceRes and its data exists and is not empty
                            if (state.provienceRes?.data == null || state.provienceRes!.data.isEmpty) {
                              return const Text("No province data available!");
                            }
                            // Check if indexCity is valid
                            final hasValidCityIndex = state.indexCity != null &&
                                state.indexCity! >= 0 &&
                                state.indexCity! < state.provienceRes!.data.length;

                            // Check if cityies exists and is not empty (if indexCity is valid)
                            final hasCities = hasValidCityIndex &&
                                state.provienceRes!.data[state.indexCity!].cityies!.isNotEmpty;
                            //  state.cityValue!.isNotEmpty ? state.provienceRes!.data[0].cityies!.isNotEmpty : state.provienceRes!.data[state.indexCity!].cityies!.isNotEmpty;

                            // for update
                            //  bool hasCities2=false;
                            //   if(state.cityValue != null){
                            //     hasCities2 = state.provienceRes!.data[0].cityies!.isNotEmpty;
                            //     Fluttertoast.showToast(msg: hasCities2.toString());
                            //   }

                            // Check if indexZone is valid (if hasCities is true)
                            final hasValidZoneIndex = hasCities
                                &&
                                state.indexZone != null &&
                                state.indexZone! >= 0 &&
                                state.indexZone! < state.provienceRes!.data[state.indexCity!].cityies!.length;

                            // for update
                            // final hasValidZoneIndex2;
                            // if(state.cityValue!.isNotEmpty){
                            //    hasValidZoneIndex2 = hasCities
                            //       &&
                            //       state.indexZone != null &&
                            //       state.indexZone! >= 0 &&
                            //       state.indexZone! < state.provienceRes!.data[state.indexCity!].cityies!.length;
                            // }

                            // Check if zone exists and is not empty (if hasValidZoneIndex is true)
                            final hasZones = hasValidZoneIndex &&
                                state.provienceRes!.data[state.indexCity!].cityies![state.indexZone!].zone.isNotEmpty;
                            return  Padding(
                              padding: const EdgeInsets.only(left: 0,right: 0),
                              child: Column(
                                children: [

                                  Container(
                                    color: textFormFieldColor,
                                    padding: EdgeInsets.all(0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        value: state.provienceValue,
                                        isDense: true,
                                        isExpanded: true,
                                        hint: Text(
                                          'Select province',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Theme.of(context).hintColor,
                                          ),
                                        ),
                                        items: state.provienceRes!.data.map((party) =>
                                            DropdownMenuItem<String>(
                                              value: party.name.toString(),
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 8),
                                                child: Container(
                                                  padding: const EdgeInsets.all(8.0),
                                                  width: MediaQuery.of(context).size.width,
                                                  decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(
                                                        Radius.circular(12.0)),
                                                  //  color: Colors.grey[200],
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey.withOpacity(0.5),
                                                        spreadRadius: 2,
                                                        blurRadius: 5,
                                                        offset: const Offset(0,
                                                            3), // changes position of shadow
                                                      ),
                                                    ],
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        party.name.toString(),

                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )).toList(),
                                        // Custom display of the selected item
                                        selectedItemBuilder: (BuildContext context) {
                                          return state.provienceRes!.data.map((party) {
                                            return Text(
                                              party.name!,

                                            );
                                          }).toList();
                                        },
                                        onChanged: (value) {
                                          if (value != null) {
                                            int index = state.provienceRes!.data.indexWhere(
                                                    (item) => item.name == value
                                            );

                                            if(index != -1){
                                              context.read<ProvienceBloc>().add(
                                                  ProvienceProvienceIndexEvent(index: index,province: value,)
                                              );
                                              provienceId = state.provienceRes!.data[index].id!;
                                              in1 = index;
                                            }
                                          }
                                        },
                                        buttonStyleData: ButtonStyleData(
                                          height: 50,
                                          width: MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.only(left: 14, right: 14),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(
                                              color: textColor,
                                            ),
                                            // color: Colors.redAccent,
                                          ),
                                          // elevation: 2,
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          maxHeight: MediaQuery.of(context).size.height * 0.8,
                                          //maxHeight: 700,
                                        ),
                                        menuItemStyleData: MenuItemStyleData(
                                          height:50,
                                          // widght: MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.only(left: 14, right: 14),
                                        ),
                                        dropdownSearchData: DropdownSearchData(
                                          searchController: textEditingController,
                                          searchInnerWidgetHeight: 50,
                                          searchInnerWidget: Container(
                                            height: 50,
                                            padding: const EdgeInsets.only(
                                              top: 8,
                                              bottom: 4,
                                              right: 8,
                                              left: 8,
                                            ),
                                            child: TextFormField(
                                              expands: true,
                                              maxLines: null,
                                              controller: textEditingController,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                contentPadding: const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 8,
                                                ),
                                                hintText: 'Search for provience...',
                                                hintStyle: const TextStyle(fontSize: 12),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.orange, width: 1),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.orange, width: 1),
                                                ),

                                              ),
                                            ),
                                          ),
                                          searchMatchFn: (item, searchValue) {
                                            String itemValue = item.value.toString();
                                            String lowercaseItemValue =
                                            itemValue.toLowerCase();
                                            String uppercaseItemValue =
                                            itemValue.toUpperCase();
                                            String lowercaseSearchValue =
                                            searchValue.toLowerCase();
                                            String uppercaseSearchValue =
                                            searchValue.toUpperCase();
                                            return lowercaseItemValue
                                                .contains(lowercaseSearchValue) ||
                                                uppercaseItemValue
                                                    .contains(uppercaseSearchValue) ||
                                                itemValue.contains(searchValue);
                                          },
                                        ),
                                        //This to clear the search value when you close the menu
                                        onMenuStateChange: (isOpen) {
                                          if (!isOpen) {
                                            textEditingController.clear();
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  //
                                  //   Container(
                                  //   color: textFormFieldColor,
                                  //   padding: const EdgeInsets.symmetric(horizontal: 0),
                                  //   child: DropdownButtonFormField2<String>(// Changed to String type
                                  //     value: state.provienceValue,
                                  //     isExpanded: true,
                                  //     decoration: InputDecoration(
                                  //       contentPadding: const EdgeInsets.symmetric(vertical: 5),
                                  //       border: OutlineInputBorder(
                                  //         borderRadius: BorderRadius.circular(5),
                                  //       ),
                                  //     ),
                                  //     hint: const Text(
                                  //       'Please select provience',
                                  //       style: TextStyle(fontSize: 14),
                                  //     ),
                                  //     items: state.provienceRes!.data
                                  //         .map((item) => DropdownMenuItem<String>(  // Changed to String type
                                  //       value: item.name!,  // Using name as the value
                                  //       child: Text(
                                  //         item.name!,
                                  //         style: const TextStyle(
                                  //           fontSize: 14,
                                  //         ),
                                  //       ),
                                  //     ))
                                  //         .toList(),
                                  //     validator: (value) {
                                  //       if (value == null) {
                                  //         return 'Please select provience.';
                                  //       }
                                  //       return null;
                                  //     },
                                  //     onChanged: (value) {
                                  //       if (value != null) {
                                  //         int index = state.provienceRes!.data.indexWhere(
                                  //                 (item) => item.name == value
                                  //         );
                                  //
                                  //         if(index != -1){
                                  //           context.read<ProvienceBloc>().add(
                                  //               ProvienceProvienceIndexEvent(index: index,province: value)
                                  //           );
                                  //           provienceId = state.provienceRes!.data[index].id!;
                                  //           in1 = index;
                                  //         }
                                  //       }
                                  //     },
                                  //     onSaved: (value) {
                                  //       // Handle saved value if needed
                                  //     },
                                  //     buttonStyleData: const ButtonStyleData(
                                  //       padding: EdgeInsets.only(right: 8),
                                  //     ),
                                  //     iconStyleData: const IconStyleData(
                                  //       icon: Icon(
                                  //         Icons.arrow_drop_down,
                                  //         color: Colors.black45,
                                  //       ),
                                  //       iconSize: 24,
                                  //     ),
                                  //     dropdownStyleData: DropdownStyleData(
                                  //       decoration: BoxDecoration(
                                  //         borderRadius: BorderRadius.circular(10),
                                  //       ),
                                  //     ),
                                  //     menuItemStyleData: const MenuItemStyleData(
                                  //       padding: EdgeInsets.symmetric(horizontal: 10),
                                  //     ),
                                  //   ),
                                  // ),
                                  SizedBox(height: 10,),
                                  if(hasCities)
                                  // Container(
                                  //   color: textFormFieldColor,
                                  //   padding: const EdgeInsets.symmetric(horizontal: 0),
                                  //   child: DropdownButtonFormField2<CityModel>(
                                  //     isExpanded: true,
                                  //     decoration: InputDecoration(
                                  //       contentPadding: const EdgeInsets.symmetric(vertical: 5),
                                  //       border: OutlineInputBorder(
                                  //         borderRadius: BorderRadius.circular(5),
                                  //       ),
                                  //       // Add more decoration..
                                  //     ),
                                  //     hint: const Text(
                                  //       'Please select city',
                                  //       style: TextStyle(fontSize: 14),
                                  //     ),
                                  //     items: state.provienceRes!.data[state.indexCity!].cityies!
                                  //         .map((item) => DropdownMenuItem<CityModel>(
                                  //       value:item,
                                  //       child: Text(
                                  //         item.name!,
                                  //         style: const TextStyle(
                                  //           fontSize: 14,
                                  //         ),
                                  //       ),
                                  //     ))
                                  //         .toList(),
                                  //     validator: (value) {
                                  //       if (value == null) {
                                  //         return 'Please select city.';
                                  //       }
                                  //       return null;
                                  //     },
                                  //     onChanged: (value) {
                                  //       int index = state.provienceRes!.data[state.indexCity!].cityies!.indexWhere(
                                  //               (name) => name.name == value!.name
                                  //       );
                                  //
                                  //       if(index != -1){
                                  //         in12 = index;
                                  //          Fluttertoast.showToast(msg:in12.toString() );
                                  //
                                  //         //  state.provienceRes!.data[state.indexCity!].cityies[state.indexZone!].zone = [];
                                  //         context.read<ProvienceBloc>().add(ProvienceZoneIndexEvent(
                                  //             indexcITY:state.indexCity,indexZone: index,zoneValue: null,province: state.provienceValue));
                                  //         cityId = state.provienceRes!.data[state.indexCity!].cityies![index].id!;
                                  //      //   Fluttertoast.showToast(msg: state.provienceRes!.data[state.indexCity!].cityies[state.indexZone!].zone![0].name!);
                                  //
                                  //       }
                                  //     },
                                  //     onSaved: (value) {
                                  //       // state.selectAgeGroup = value.toString();
                                  //       // Fluttertoast.showToast(msg: state.paymentType);
                                  //       // selectedValue = value.toString();
                                  //     },
                                  //     buttonStyleData: const ButtonStyleData(
                                  //       padding: EdgeInsets.only(right: 8),
                                  //     ),
                                  //     iconStyleData: const IconStyleData(
                                  //       icon: Icon(
                                  //         Icons.arrow_drop_down,
                                  //         color: Colors.black45,
                                  //       ),
                                  //       iconSize: 24,
                                  //     ),
                                  //     dropdownStyleData: DropdownStyleData(
                                  //       decoration: BoxDecoration(
                                  //         borderRadius: BorderRadius.circular(10),
                                  //       ),
                                  //     ),
                                  //     menuItemStyleData: const MenuItemStyleData(
                                  //       padding: EdgeInsets.symmetric(horizontal: 10),
                                  //     ),
                                  //   ),
                                  // ),
                                    Container(
                                      color: textFormFieldColor,
                                      padding: EdgeInsets.all(0),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2<String>(
                                          value:  state.cityValue,
                                          isDense: true,
                                          isExpanded: true,
                                          hint: Text(
                                            'Select Customer',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context).hintColor,
                                            ),
                                          ),
                                          items: state.provienceRes!.data[state.indexCity!].cityies!.map((party) =>
                                              DropdownMenuItem<String>(
                                                value: party.name.toString(),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(bottom: 8),
                                                  child: Container(
                                                    padding: const EdgeInsets.all(8.0),
                                                    width: MediaQuery.of(context).size.width,
                                                    decoration: BoxDecoration(
                                                      borderRadius: const BorderRadius.all(
                                                          Radius.circular(12.0)),
                                                      color: Colors.grey[200],
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey.withOpacity(0.5),
                                                          spreadRadius: 2,
                                                          blurRadius: 5,
                                                          offset: const Offset(0,
                                                              3), // changes position of shadow
                                                        ),
                                                      ],
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          party.name.toString(),

                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )).toList(),
                                          // Custom display of the selected item
                                          selectedItemBuilder: (BuildContext context) {
                                            return state.provienceRes!.data[state.indexCity!].cityies!.map((party) {
                                              return Text(
                                                party.name!,

                                              );
                                            }).toList();
                                          },
                                          onChanged: (value) {
                                            int index = state.provienceRes!.data[state.indexCity!].cityies!.indexWhere((name) => name.name == value!);
                                            if(index != -1){
                                              context.read<ProvienceBloc>().add(ProvienceZoneIndexEvent(
                                                  indexcITY:state.indexCity,
                                                  indexZone:
                                                  index,zoneValue: null,
                                                  province: state.provienceValue,
                                                  city: value));
                                                 cityId = state.provienceRes!.data[state.indexCity!].cityies![index].id!;
                                              //Fluttertoast.showToast(msg: state.cityValue!);
                                            }
                                          },
                                          buttonStyleData: ButtonStyleData(
                                            height: 50,
                                            width: MediaQuery.of(context).size.width,
                                            padding: const EdgeInsets.only(left: 14, right: 14),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(
                                                color: textColor,
                                              ),
                                              // color: Colors.redAccent,
                                            ),
                                            // elevation: 2,
                                          ),
                                          dropdownStyleData: DropdownStyleData(
                                            maxHeight: MediaQuery.of(context).size.height * 0.8,
                                            //maxHeight: 700,
                                          ),
                                          menuItemStyleData: MenuItemStyleData(
                                            height:50,
                                            // widght: MediaQuery.of(context).size.width,
                                            padding: const EdgeInsets.only(left: 14, right: 14),
                                          ),
                                          dropdownSearchData: DropdownSearchData(
                                            searchController: textEditingController,
                                            searchInnerWidgetHeight: 50,
                                            searchInnerWidget: Container(
                                              height: 50,
                                              padding: const EdgeInsets.only(
                                                top: 8,
                                                bottom: 4,
                                                right: 8,
                                                left: 8,
                                              ),
                                              child: TextFormField(
                                                expands: true,
                                                maxLines: null,
                                                controller: textEditingController,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding: const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 8,
                                                  ),
                                                  hintText: 'Search for zone...',
                                                  hintStyle: const TextStyle(fontSize: 12),
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    borderSide: const BorderSide(
                                                        color: Colors.orange, width: 1),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    borderSide: const BorderSide(
                                                        color: Colors.orange, width: 1),
                                                  ),

                                                ),
                                              ),
                                            ),
                                            searchMatchFn: (item, searchValue) {
                                              String itemValue = item.value.toString();
                                              String lowercaseItemValue =
                                              itemValue.toLowerCase();
                                              String uppercaseItemValue =
                                              itemValue.toUpperCase();
                                              String lowercaseSearchValue =
                                              searchValue.toLowerCase();
                                              String uppercaseSearchValue =
                                              searchValue.toUpperCase();
                                              return lowercaseItemValue
                                                  .contains(lowercaseSearchValue) ||
                                                  uppercaseItemValue
                                                      .contains(uppercaseSearchValue) ||
                                                  itemValue.contains(searchValue);
                                            },
                                          ),
                                          //This to clear the search value when you close the menu
                                          onMenuStateChange: (isOpen) {
                                            if (!isOpen) {
                                              textEditingController.clear();
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  SizedBox(height: 10,),
                                  // if(hasZones)
                                  //   Padding(
                                  //     padding: const EdgeInsets.symmetric(horizontal: 0),
                                  //     child: DropdownButtonFormField2<ZoneModel>(
                                  //
                                  //       isExpanded: true,
                                  //       decoration: InputDecoration(
                                  //         contentPadding: const EdgeInsets.symmetric(vertical: 5),
                                  //         border: OutlineInputBorder(
                                  //           borderRadius: BorderRadius.circular(5),
                                  //         ),
                                  //         // Add more decoration..
                                  //       ),
                                  //       hint: const Text(
                                  //         'Please select Zone',
                                  //         style: TextStyle(fontSize: 14),
                                  //       ),
                                  //       items: state.provienceRes!.data[state.indexCity!].cityies[state.indexZone!].zone
                                  //       //  items: state.provienceRes!.data[2].cityies[1].zone
                                  //           .map((item) => DropdownMenuItem<ZoneModel>(
                                  //         value:item,
                                  //         child: Text(
                                  //           item.name!,
                                  //           style: const TextStyle(
                                  //             fontSize: 14,
                                  //           ),
                                  //         ),
                                  //       ))
                                  //           .toList(),
                                  //       validator: (value) {
                                  //         if (value == null) {
                                  //           return 'Please select Zone.';
                                  //         }
                                  //         return null;
                                  //       },
                                  //       onChanged: (value) {
                                  //         int index = state.provienceRes!.data[state.indexCity!].cityies[state.indexZone!].zone.indexWhere(
                                  //                 (name) => name.name == value!.name
                                  //         );
                                  //         if(index != -1){
                                  //           zoneId = state.provienceRes!.data[state.indexCity!].cityies[state.indexZone!].zone[index].id!;
                                  //         }
                                  //       },
                                  //       onSaved: (value) {
                                  //         // state.selectAgeGroup = value.toString();
                                  //         // Fluttertoast.showToast(msg: state.paymentType);
                                  //         // selectedValue = value.toString();
                                  //       },
                                  //       buttonStyleData: const ButtonStyleData(
                                  //         padding: EdgeInsets.only(right: 8),
                                  //       ),
                                  //       iconStyleData: const IconStyleData(
                                  //         icon: Icon(
                                  //           Icons.arrow_drop_down,
                                  //           color: Colors.black45,
                                  //         ),
                                  //         iconSize: 24,
                                  //       ),
                                  //       dropdownStyleData: DropdownStyleData(
                                  //         decoration: BoxDecoration(
                                  //           borderRadius: BorderRadius.circular(10),
                                  //         ),
                                  //       ),
                                  //       menuItemStyleData: const MenuItemStyleData(
                                  //         padding: EdgeInsets.symmetric(horizontal: 10),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // zone
                                  if(hasZones)...[
                                    Container(
                                      color: textFormFieldColor,
                                      padding: EdgeInsets.all(0),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2<String>(
                                          value:  state.zoveValue,
                                          isDense: true,
                                          isExpanded: true,
                                          hint: Text(
                                            'Select zone',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context).hintColor,
                                            ),
                                          ),
                                          items: state.provienceRes!.data[state.indexCity!].cityies![state.indexZone!].zone.map((party) =>
                                              DropdownMenuItem<String>(
                                                value: party.name.toString(),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(bottom: 8),
                                                  child: Container(
                                                    padding: const EdgeInsets.all(8.0),
                                                    width: MediaQuery.of(context).size.width,
                                                    decoration: BoxDecoration(
                                                      borderRadius: const BorderRadius.all(
                                                          Radius.circular(12.0)),
                                                      color: Colors.grey[200],
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey.withOpacity(0.5),
                                                          spreadRadius: 2,
                                                          blurRadius: 5,
                                                          offset: const Offset(0,
                                                              3), // changes position of shadow
                                                        ),
                                                      ],
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          party.name.toString(),

                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )).toList(),
                                          // Custom display of the selected item
                                          selectedItemBuilder: (BuildContext context) {
                                            return state.provienceRes!.data[state.indexCity!].cityies![state.indexZone!].zone.map((party) {
                                              return Text(
                                                party.name!,

                                              );
                                            }).toList();
                                          },
                                          onChanged: (value) {
                                            int index = state.provienceRes!.data[state.indexCity!].cityies![state.indexZone!].zone.indexWhere(
                                                    (name) => name.name == value!
                                            );
                                            if(index != -1){
                                              context.read<ProvienceBloc>().add(ProvienceZoneIndexEvent(
                                                  indexcITY:state.indexCity,
                                                  indexZone: state.indexZone,
                                                  zoneValue: value,
                                                  province: state.provienceValue,
                                                  city: state.cityValue));
                                                zoneId = state.provienceRes!.data[state.indexCity!].cityies![state.indexZone!].zone[index].id!;
                                            }
                                          },
                                          buttonStyleData: ButtonStyleData(
                                            height: 50,
                                            width: MediaQuery.of(context).size.width,
                                            padding: const EdgeInsets.only(left: 14, right: 14),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(
                                                color: textColor,
                                              ),
                                              // color: Colors.redAccent,
                                            ),
                                            // elevation: 2,
                                          ),
                                          dropdownStyleData: DropdownStyleData(
                                            maxHeight: MediaQuery.of(context).size.height * 0.8,
                                            //maxHeight: 700,
                                          ),
                                          menuItemStyleData: MenuItemStyleData(
                                            height:50,
                                            // widght: MediaQuery.of(context).size.width,
                                            padding: const EdgeInsets.only(left: 14, right: 14),
                                          ),
                                          dropdownSearchData: DropdownSearchData(
                                            searchController: textEditingController,
                                            searchInnerWidgetHeight: 50,
                                            searchInnerWidget: Container(
                                              height: 50,
                                              padding: const EdgeInsets.only(
                                                top: 8,
                                                bottom: 4,
                                                right: 8,
                                                left: 8,
                                              ),
                                              child: TextFormField(
                                                expands: true,
                                                maxLines: null,
                                                controller: textEditingController,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  contentPadding: const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 8,
                                                  ),
                                                  hintText: 'Search for zone...',
                                                  hintStyle: const TextStyle(fontSize: 12),
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    borderSide: const BorderSide(
                                                        color: Colors.orange, width: 1),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    borderSide: const BorderSide(
                                                        color: Colors.orange, width: 1),
                                                  ),

                                                ),
                                              ),
                                            ),
                                            searchMatchFn: (item, searchValue) {
                                              String itemValue = item.value.toString();
                                              String lowercaseItemValue =
                                              itemValue.toLowerCase();
                                              String uppercaseItemValue =
                                              itemValue.toUpperCase();
                                              String lowercaseSearchValue =
                                              searchValue.toLowerCase();
                                              String uppercaseSearchValue =
                                              searchValue.toUpperCase();
                                              return lowercaseItemValue
                                                  .contains(lowercaseSearchValue) ||
                                                  uppercaseItemValue
                                                      .contains(uppercaseSearchValue) ||
                                                  itemValue.contains(searchValue);
                                            },
                                          ),
                                          //This to clear the search value when you close the menu
                                          onMenuStateChange: (isOpen) {
                                            if (!isOpen) {
                                              textEditingController.clear();
                                            }
                                          },
                                        ),
                                      ),
                                    )
                                  ] else ...[

                                  ]
                                ],
                              ),
                            );
                          }else{
                            return  Padding(
                              padding: const EdgeInsets.only(left: 0,right: 0),
                              child: Column(
                                children: [
                                  Container(
                                    color: textFormFieldColor,
                                    padding: EdgeInsets.all(0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        isDense: true,
                                        isExpanded: true,
                                        hint: Text(
                                          'Select province',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Theme.of(context).hintColor,
                                          ),
                                        ),
                                        items: [],

                                        buttonStyleData: ButtonStyleData(
                                          height: 50,
                                          width: MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.only(left: 14, right: 14),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(
                                              color: textColor,
                                            ),
                                            // color: Colors.redAccent,
                                          ),
                                          // elevation: 2,
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          maxHeight: MediaQuery.of(context).size.height * 0.8,
                                          //maxHeight: 700,
                                        ),
                                        menuItemStyleData: MenuItemStyleData(
                                          height:50,
                                          // widght: MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.only(left: 14, right: 14),
                                        ),
                                        dropdownSearchData: DropdownSearchData(
                                          searchController: textEditingController,
                                          searchInnerWidgetHeight: 50,
                                          searchInnerWidget: Container(
                                            height: 50,
                                            padding: const EdgeInsets.only(
                                              top: 8,
                                              bottom: 4,
                                              right: 8,
                                              left: 8,
                                            ),
                                            child: TextFormField(
                                              expands: true,
                                              maxLines: null,
                                              controller: textEditingController,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                contentPadding: const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 8,
                                                ),
                                                hintText: 'Search for provience...',
                                                hintStyle: const TextStyle(fontSize: 12),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.orange, width: 1),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.orange, width: 1),
                                                ),

                                              ),
                                            ),
                                          ),
                                          searchMatchFn: (item, searchValue) {
                                            String itemValue = item.value.toString();
                                            String lowercaseItemValue =
                                            itemValue.toLowerCase();
                                            String uppercaseItemValue =
                                            itemValue.toUpperCase();
                                            String lowercaseSearchValue =
                                            searchValue.toLowerCase();
                                            String uppercaseSearchValue =
                                            searchValue.toUpperCase();
                                            return lowercaseItemValue
                                                .contains(lowercaseSearchValue) ||
                                                uppercaseItemValue
                                                    .contains(uppercaseSearchValue) ||
                                                itemValue.contains(searchValue);
                                          },
                                        ),
                                        //This to clear the search value when you close the menu
                                        onMenuStateChange: (isOpen) {
                                          if (!isOpen) {
                                            textEditingController.clear();
                                          }
                                        },
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            );
                          }
                        },),

                        SizedBox(height: 10,),
                        TextFormField(
                          controller: addressController,
                          maxLines: 3,
                          onChanged: (value) {
                            if (value.isEmpty) {

                            }
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please enter address";
                            }
                            return null;
                          },
                          decoration: TextFormDecoration.decoration(
                            hintText: "Address",
                            hintStyle: hintTextStyle,
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: landMarkController,
                          onChanged: (value) {
                            if (value.isEmpty) {

                            }
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please enter land mark";
                            }
                            return null;
                          },
                          decoration: TextFormDecoration.decoration(
                            hintText: "Land Mark",
                            hintStyle: hintTextStyle,
                            prefixIcon: Icons.house,
                          ),
                        ),
                        SizedBox(height: 10,),
                        if(widget.addressList!.isEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: Colors.orange,
                                    value: state.shippingFlag,
                                    onChanged: (checked) {
                                      context.read<AddressBloc>().add(AddressReqEvent(typeHomeFlag: state.addressTypeHomeFlag!,
                                          typeOfficeFlag: state.addressTypeOfficeFlag!,shippingFlag: checked!,billingFlag: state.billingFlag == true ? true : false));
                                      // context.read<AddressBloc>().add(AddressShippingEvent(shippingFlag: checked!));
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  const Text('Default Shipping',),
                                ],
                              ),
                              if(!state.shippingFlag!)
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text("Please check shipping",style: GoogleFonts.poppins(
                                      color: Colors.red,
                                      fontSize: 10
                                  ),),
                                )
                            ],
                          ),
                        if(widget.addressList!.isEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [

                                  Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: Colors.orange,
                                    value: state.billingFlag,
                                    onChanged: (checked) {
                                      context.read<AddressBloc>().add(AddressReqEvent(typeHomeFlag: state.addressTypeHomeFlag!,
                                          typeOfficeFlag: state.addressTypeOfficeFlag!,billingFlag: checked!,shippingFlag: state.shippingFlag == true ? true : false));
                                      // context.read<AddressBloc>().add(AddressBillingEvent(billingFlag: checked!));
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  const Text('Default Billing'),
                                ],
                              ),
                              if(!state.billingFlag!)
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text("Please check billing",style: GoogleFonts.poppins(
                                      color: Colors.red,
                                      fontSize: 10
                                  ),),
                                )
                            ],
                          ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.only(left: 0,right: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Address Type",textAlign: TextAlign.start,style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15
                              ),),
                              SizedBox(height: 10,),
                              if(widget.addressUpdate == "Update")...[
                                Row(
                                  children: [
                                    InkWell(
                                      onTap:(){
                                        context.read<AddressBloc>().add(AddressReqEvent(
                                            typeHomeFlag: true,typeOfficeFlag: false,shippingFlag: state.shippingFlag,billingFlag: state.billingFlag));
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: state.addressTypeHomeFlag==true ? gPrimaryColor : Colors.white,
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            border: Border.all(width: 1,color: Colors.grey)
                                        ),
                                        child: Icon(Bootstrap.house,color: state.addressTypeHomeFlag==true ? Colors.white : Colors.black,),
                                      ),
                                    ),
                                    SizedBox(width: 40,),
                                    InkWell(
                                      onTap:(){
                                        context.read<AddressBloc>().add(AddressReqEvent(typeOfficeFlag: true,typeHomeFlag: false,shippingFlag: state.shippingFlag,billingFlag: state.billingFlag));

                                      },
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: state.addressTypeOfficeFlag==true ? gPrimaryColor : Colors.white,
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            border: Border.all(width: 1,color: Colors.grey)
                                        ),
                                        child: Icon(Bootstrap.building,color: state.addressTypeOfficeFlag==true ? Colors.white : Colors.black,),
                                      ),
                                    )
                                  ],
                                )
                              ]else ...[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap:(){
                                            context.read<AddressBloc>().add(AddressReqEvent(
                                                typeHomeFlag: true,typeOfficeFlag: false,shippingFlag: state.shippingFlag,billingFlag: state.billingFlag));
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                color: state.addressTypeHomeFlag==true ? gPrimaryColor : Colors.white,
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                border: Border.all(width: 1,color: Colors.grey)
                                            ),
                                            child: Icon(Bootstrap.house,color: state.addressTypeHomeFlag==true ? Colors.white : Colors.black,),
                                          ),
                                        ),
                                        SizedBox(width: 40,),
                                        InkWell(
                                          onTap:(){
                                            context.read<AddressBloc>().add(AddressReqEvent(typeOfficeFlag: true,typeHomeFlag: false,shippingFlag: state.shippingFlag,billingFlag: state.billingFlag));

                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                color: state.addressTypeOfficeFlag==true ? gPrimaryColor : Colors.white,
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                border: Border.all(width: 1,color: Colors.grey)
                                            ),
                                            child: Icon(Bootstrap.building,color: state.addressTypeOfficeFlag==true ? Colors.white : Colors.black,),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    if(!state.addressTypeHomeFlag! && !state.addressTypeOfficeFlag!)
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text("Please check address type",style: GoogleFonts.poppins(
                                            color: Colors.red,
                                            fontSize: 10
                                        ),),
                                      )
                                  ],
                                )
                              ]

                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              );
            }else{
              return Container(child: Text("ss"),);
            }
          },),
          bottomNavigationBar: BlocBuilder<AddressBloc,AddressState>(builder: (BuildContext context, state) {
            if(state is AddressInitialState){
              return  Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,bottom: 8,top: 10),
                child: InkWell(
                  onTap: (){

                  },
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.only(left: 7),
                    decoration: BoxDecoration(
                        color: Color(0xff003466),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Center(
                      child: Text("Save Address",style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                      ),),
                    ),
                  ),
                ),
              );
            }else if(state is AddressLoadedState){
              return  Container(
                //color: Colors.green,
                height: 60,
                padding: const EdgeInsets.only(left: 10,right: 10,bottom: 2,top: 0),
                child: InkWell(
                  onTap: (){

                    if(globalKey.currentState!.validate() &&
                        (widget.addressList!.isEmpty ? state.shippingFlag! : true) &&
                        (widget.addressList!.isEmpty ? state.billingFlag! : true )
                        && provienceId!= null &&cityId != null && zoneId != null) {
                      LoadingOverlay.show(context);
                      AddressModel addressModel = AddressModel(
                          id: "0",
                          full_name:fullNameController.text.trim(),
                          phone: mobileNoController.text.trim(),
                          province: provienceId.toString(),
                          city: cityId.toString(),
                          zone: zoneId.toString(),
                          address: addressController.text.trim(),
                          address_type: state.addressTypeHomeFlag == true ? "H" : state.addressTypeOfficeFlag == true ? "O" : "H",
                          default_shipping: state.shippingFlag == true ? "Y" : "",
                          default_billing: state.billingFlag == true ? "Y" : "",
                          landmark: landMarkController.text.trim()
                      );
                      context.read<AddressBloc>().add(AddressSaveEvent(addressModel: addressModel,valueMap: widget.addressUpdate,context: context));

                    } else{
                      Fluttertoast.showToast(msg: "Required all fields");
                    }

                    // if(globalKey.currentState!.validate() && ((state.shippingFlag! && state.billingFlag!) || state.addressTypeHomeFlag! || state.addressTypeOfficeFlag!)){
                    //
                    // }

                  },
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 7),
                    decoration: BoxDecoration(
                        color: Color(0xff003466),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Center(
                      child: Text("Save Address",style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                      ),),
                    ),
                  ),
                ),
              );
            }else{
              return  Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,bottom: 8,top: 10),
                child: InkWell(
                  onTap: (){

                  },
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.only(left: 7),
                    decoration: BoxDecoration(
                        color: Color(0xff003466),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Center(
                      child: Text("Save Address",style: GoogleFonts.poppins(
                          color: Colors.white
                      ),),
                    ),
                  ),
                ),
              );
            }
          },),
        ),
      );
    },);
  }
}
