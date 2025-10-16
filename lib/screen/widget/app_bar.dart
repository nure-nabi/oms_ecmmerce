import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/screen/cart/bloc/cart_bloc.dart';

import '../cart/bloc/cart_event.dart';
import '../cart/bloc/cart_state.dart';

class AppBarShow extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;
  final bool? leadingFlag;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? cartIcon;
  final VoidCallback? onCartPressed;
  final VoidCallback? onLeadingPressed;

  const AppBarShow({
    super.key,
    required this.title,
     this.leadingFlag,
    this.leading,
    this.actions,
    this.centerTitle = false,
    this.backgroundColor,
    this.textColor,
    this.cartIcon = Bootstrap.cart,
    this.onCartPressed,
    this.onLeadingPressed,
  });

  @override
  Widget build(BuildContext context) {
     context.read<CartBloc>().add(CartReqEvent(count:0,checkedCart:false));

    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: leadingFlag!,
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Theme.of(context).appBarTheme.titleTextStyle?.color,
        ),
      ),
      leading: leading,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? Theme.of(context).appBarTheme.backgroundColor,
      actions: [
        InkWell(
          highlightColor: Colors.transparent,
          onTap: onCartPressed,
          child: Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(Bootstrap.cart),
                onPressed: () {
                  // Navigate to cart page
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if(state is CartLoadingState){
                      return const CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 10,
                        child: Text(
                          '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      );
                    }else if(state is CartLoadedState){
                      return CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 10,
                        child: Text(
                          state.cartResModel!.cart!.items.length.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      );
                    }else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
      // actions: actions ?? [
      //   if (cartIcon != null)
      //     IconButton(
      //       onPressed: onCartPressed,
      //       icon: Icon(cartIcon),
      //       color: textColor ?? Theme.of(context).appBarTheme.iconTheme?.color,
      //     ),
      // ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}