import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/screen/product/bloc/serch_bloc/search_bloc.dart';
import 'package:oms_ecommerce/screen/product/bloc/serch_bloc/search_state.dart';

import '../../core/constant/colors_constant.dart';
import '../../core/constant/textstyle.dart';
import 'bloc/serch_bloc/search_event.dart';

class ProductSearch extends StatefulWidget {
  const ProductSearch({super.key});

  @override
  State<ProductSearch> createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, state) {
        return Scaffold(
            appBar: AppBar(
                backgroundColor: gPrimaryColor,
                elevation: 0,
                leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Bootstrap.chevron_left,
                      size: 21,
                    )),
                title: state.isSearchNameList == false
                    ? const Text("Product search")
                    : Container(
                  height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: TextFormField(
                          controller: controller,
                          style: kInputTextStyle.copyWith(color: Colors.white),
                          onChanged: (string) {
                            // state.searchMember = state.controller.text.trim();
                          },
                          cursorHeight: 20,
                          autofocus: true,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Product search",
                              hintStyle:
                                  kHintTextStyle.copyWith(color: Colors.white),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              // contentPadding: EdgeInsets.symmetric(
                              //     horizontal: 5, vertical: 4)
                          ),
                        ),
                      ),
                actions: [
              const SizedBox(width: 5.0),
              (state.isSearchNameList == false)
                  ? InkWell(
                      onTap: () {
                        context
                            .read<SearchBloc>()
                            .add(SearchEvent(isSearchNameList: true));
                        //    state.changeSearch = this;
                      },
                      child: const Icon(Icons.search),
                    )
                  : InkWell(
                      onTap: () {
                        context
                            .read<SearchBloc>()
                            .add(SearchEvent(isSearchNameList: false));
                        controller.text = "";
                      },
                      child: const Icon(Icons.close),
                    ),
              const SizedBox(width: 15.0),
            ]));
      },
    );
  }
}
