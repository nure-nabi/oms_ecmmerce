import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oms_ecommerce/config/state_list.dart';
import 'package:oms_ecommerce/screen/address/bloc/address_bloc.dart';
import 'package:oms_ecommerce/screen/address/bloc/provience_bloc.dart';
import 'package:oms_ecommerce/screen/brand/bloc/brand_bloc.dart';
import 'package:oms_ecommerce/screen/category/bloc/category_bloc.dart';
import 'package:oms_ecommerce/screen/category/bloc/category_top_bloc/category_top_bloc.dart';
import 'package:oms_ecommerce/screen/contact_us/bloc/contactus_bloc.dart';
import 'package:oms_ecommerce/screen/flash_salse/bloc/flash_sale_bloc.dart';
import 'package:oms_ecommerce/screen/forget_password/bloc/change_password/change_password_bloc.dart';
import 'package:oms_ecommerce/screen/forget_password/bloc/forget_password_bloc.dart';
import 'package:oms_ecommerce/screen/login/block/login_block.dart';
import 'package:oms_ecommerce/screen/order/bloc/reason/reason_bloc.dart';
import 'package:oms_ecommerce/screen/order/bloc/review/review_bloc.dart';
import 'package:oms_ecommerce/screen/privacy_policy/bloc/compain_bloc/complain_bloc.dart';
import 'package:oms_ecommerce/screen/privacy_policy/bloc/privacy_bloc.dart';
import 'package:oms_ecommerce/screen/product/bloc/ProductLatestBloc.dart';
import 'package:oms_ecommerce/screen/product/bloc/product_bloc/product_list_bloc.dart';
import 'package:oms_ecommerce/screen/profile/block/image_picker_block/image_picker_block.dart';
import 'package:oms_ecommerce/screen/profile/block/profile_edit/edit_profile_bloc.dart';
import 'package:oms_ecommerce/screen/reset_password/bloc/reset_password_bloc.dart';
import 'package:oms_ecommerce/screen/singup/block/register_bloc.dart';
import 'package:oms_ecommerce/screen/splash/splash_bloc/splash_bloc.dart';
import 'package:oms_ecommerce/screen/top_category/bloc/top_category_product_bloc.dart';
import 'package:oms_ecommerce/scroll/scroll_bloc.dart';
import 'package:oms_ecommerce/storage/hive_storage.dart';
import 'package:oms_ecommerce/theme/theme_bloc.dart';
import 'package:oms_ecommerce/theme/theme_data.dart';
import 'package:oms_ecommerce/utils/image_picker_utils.dart';

import 'package:provider/provider.dart';

import '../core/constant/colors_constant.dart';
import '../core/services/routeHelper/route_helper.dart';
import '../core/services/routeHelper/route_name.dart';
import '../screen/banner/banner_bloc/banner_bloc.dart';
import '../screen/brand/bloc/brand_wise_products_bloc/brand_wise_products_bloc.dart';
import '../screen/cart/bloc/add_cart/add_cart_bloc.dart';
import '../screen/cart/bloc/cart_bloc.dart';
import '../screen/category/bloc/category_product/category_product_bloc.dart';
import '../screen/order/bloc/order_bloc.dart';
import '../screen/product/bloc/product_details_bloc.dart';
import '../screen/product/bloc/rec_product_bloc/rec_product_bloc.dart';
import '../screen/product/bloc/serch_bloc/search_bloc.dart';
import '../screen/product/product_related/block/product_related_bloc.dart';
import '../screen/profile/block/profile_bloc/profile_bloc.dart';
import '../screen/search_product/bloc/search_product_bloc.dart';
import '../screen/splash/splash_state.dart';
import '../screen/verification_register/verification_bloc/verification_bloc.dart';
import '../screen/wish_list/bloc/wishlist_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
     providers: [
      BlocProvider(create: (context)=>SplashBloc()),
      BlocProvider(create: (context)=>LoginBlock()),
      BlocProvider(create: (context)=>RegisterBloc()),
      BlocProvider(create: (context)=>VerificationBloc()),
      BlocProvider(create: (context)=>BannerBloc()),
      BlocProvider(create: (context)=>CategoryBloc()),
      BlocProvider(create: (context)=>ProductLatestBloc()),
      BlocProvider(create: (context)=>TopCategoryProductsBloc()),
      BlocProvider(create: (context)=>CategoryProductBloc()),
      BlocProvider(create: (context)=>CartBloc()),
      BlocProvider(create: (context)=>ProductDetailsBloc()),
      BlocProvider(create: (context)=>AddCartBloc()),
      BlocProvider(create: (context)=>ProductRelatedBloc()),
      BlocProvider(create: (context)=>RecProductBloc()),
      BlocProvider(create: (context)=>ProfileBloc()),
      BlocProvider(create: (context)=>EditProfileBloc()),
      BlocProvider(create: (context)=>SearchBloc()),
      BlocProvider(create: (context)=>ProvienceBloc()),
      BlocProvider(create: (context)=>AddressBloc()),
      BlocProvider(create: (context)=>OrderBloc()),
      BlocProvider(create: (context)=>PrivacyBloc()),
      BlocProvider(create: (context)=>ReasonBloc()),
      BlocProvider(create: (context)=>BrandBloc()),
      BlocProvider(create: (context)=>CategoryTopBloc()),
      BlocProvider(create: (context)=>ProductListBloc()),
      BlocProvider(create: (context)=>WishlistBloc()),
      BlocProvider(create: (context)=>ComplainBloc()),
      BlocProvider(create: (context)=>ContactusBloc()),
      BlocProvider(create: (context)=>ReviewBloc()),
      BlocProvider(create: (context)=>FlashSaleBloc()),
      BlocProvider(create: (context)=>ProductSearchBloc()),
      BlocProvider(create: (context)=>ScrollBloc()),
      BlocProvider(create: (context)=>BrandWiseProductsBloc()),
      BlocProvider(create: (context)=>ThemeBloc()),
      BlocProvider(create: (context)=>ForgetPasswordBloc()),
      BlocProvider(create: (context)=>ChangePasswordBloc()),
      BlocProvider(create: (context)=>ResetPasswordBloc()),
      BlocProvider(create: (context)=>ImagePickerBlock(ImagePickerUtils())),
     ],
      child: BlocProvider<ThemeBloc>(
        create: (context) => ThemeBloc(),
        child: BlocBuilder<ThemeBloc, ThemeMode>(builder: (BuildContext context, state) {
          var themeMode = HiveStorage.hasPermission("Thememode") ? ThemeMode.dark : ThemeMode.light;
          return MaterialApp(
            title: 'OMS Ecommerce',
            debugShowCheckedModeBanner: false,
            theme: lighTheme,
            themeMode:themeMode,
            darkTheme: darkTheme,
            // theme: ThemeData(
            //   useMaterial3: false,
            //   scaffoldBackgroundColor: backgroundColor,
            //   primarySwatch: primarySwatch,
            //   primaryColor: gPrimaryColor,
            // ),

            initialRoute: splashPath,
            //initialRoute: loginHomePath,
            onGenerateRoute: RouteGenerator.generateRoute,
          );
        },),
      ),
    );
  }
}
