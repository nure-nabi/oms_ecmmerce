import 'dart:core';

import 'package:flutter/material.dart';
import 'package:oms_ecommerce/core/services/routeHelper/route_name.dart';
import 'package:oms_ecommerce/payment/payment_connectips.dart';
import 'package:oms_ecommerce/screen/address/adddress_show.dart';
import 'package:oms_ecommerce/screen/address/address_page.dart';
import 'package:oms_ecommerce/screen/address/model/address_model.dart';
import 'package:oms_ecommerce/screen/brand/brand_product.dart';
import 'package:oms_ecommerce/screen/cart/cart.dart';
import 'package:oms_ecommerce/screen/category/category_subcategory_list.dart';
import 'package:oms_ecommerce/screen/contact_us/contact_us.dart';
import 'package:oms_ecommerce/screen/forget_password/component/change_password_page.dart';
import 'package:oms_ecommerce/screen/forget_password/component/forget_password.dart';
import 'package:oms_ecommerce/screen/home_navbar/home_navbar.dart';
import 'package:oms_ecommerce/screen/login/login_home_page.dart';
import 'package:oms_ecommerce/screen/order/component/order_cancel.dart';
import 'package:oms_ecommerce/screen/order/model/order_model.dart';
import 'package:oms_ecommerce/screen/order/order_activity_page.dart';
import 'package:oms_ecommerce/screen/order/order_details.dart';
import 'package:oms_ecommerce/screen/order/order_page.dart';
import 'package:oms_ecommerce/screen/order/order_show_details.dart';
import 'package:oms_ecommerce/screen/privacy_policy/complain_grevance.dart';
import 'package:oms_ecommerce/screen/privacy_policy/privacy_policy_page.dart';
import 'package:oms_ecommerce/screen/product/product_search.dart';
import 'package:oms_ecommerce/screen/profile/edit_profile.dart';
import 'package:oms_ecommerce/screen/profile/profile_page.dart';
import 'package:oms_ecommerce/screen/search_product/searchpage.dart';
import 'package:oms_ecommerce/screen/singup/singup.dart';
import 'package:oms_ecommerce/screen/verification_register/verification_register.dart';
import 'package:oms_ecommerce/screen/wish_list/wish_list_page.dart';



import '../../../screen/address/address_update_page.dart';
import '../../../screen/cart/model/cart_model.dart';
import '../../../screen/category/category_wise_products_page.dart';
import '../../../screen/login/login_page.dart';
import '../../../screen/order/order_cart_details.dart';
import '../../../screen/order/order_confirm_page.dart';
import '../../../screen/order/product_review_and_ratingpage.dart';
import '../../../screen/profile/model/user_model.dart';
import '../../../screen/reset_password/component/reset_password_page.dart';
import '../../../screen/splash/splash_screen.dart';
import '../../../screen/top_category/top_category_product.dart';

import 'package:page_transition/page_transition.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const SplashScreen(),
        );
      case loginHomePath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const LoginHomePage(),
        );
      case loginPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child:  LoginPage(),
        );
      case searchScreenPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child:  SearchScreen(),
        );
      case singupPath:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const SingUpPage(),
        );
      case homeNavbar:
    //   int index = settings.arguments as int;
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child:  HomeNavbar(index: 0,),
        );

      case verificationRegister:
        final verify = settings.arguments as String;
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child:  VerificationRegister(verify: verify,),
        );

      case profile:

        return PageTransition(
          type: PageTransitionType.bottomToTop,
          child:  ProfilePage(),
        );
      case contactUsPage:
        return PageTransition(
          type: PageTransitionType.bottomToTop,
          child:  ContactUs(),
        );
      case productReviewAndRatingPage:
        var productsModel = settings.arguments as Map<String, dynamic>;
        var arg = settings.arguments as Map<String ,dynamic>;
        return PageTransition(
          type: PageTransitionType.bottomToTop,
          child:  ProductReviewAndRatingPage(
            productsModel: arg['productsModel'] as ProductsModel,
            orderId: arg['orderId'] as String,
          ),
        );
      case profileEdit:
        var title = settings.arguments as String;

        return PageTransition(
          type: PageTransitionType.bottomToTop,
          child:  EditProfile(title: title),
        );
      case productSearch:
        return PageTransition(
          type: PageTransitionType.fade,
          child:  ProductSearch(),
        );
      // case paymentConnectipsPage:
      //   return PageTransition(
      //     type: PageTransitionType.fade,
      //     child:  ConnectIPSWebView(),
      //   );
      case brandProductListPage:
        var brandId = settings.arguments as int;
        return PageTransition(
          type: PageTransitionType.fade,
          child:  BrandProductListPage(brandId: brandId,),
        );
      case forgetPasswordPage:
        return PageTransition(
          type: PageTransitionType.fade,
          child:  ForgetPasswordPage(),
        );
      case resetPasswordPage:
        return PageTransition(
          type: PageTransitionType.fade,
          child:  ResetPasswordPage(),
        );
      case changePasswordPage:
        return PageTransition(
          type: PageTransitionType.fade,
          child:  ChangePasswordPage(),
        );
      case topCategoryProductListPage:
        var categoryId = settings.arguments as int;
        return PageTransition(
          type: PageTransitionType.fade,
          child:  TopCategoryProductListPage(categoryId: categoryId,),
        );
      case categoryWiseProductsPage:
        var args = settings.arguments as Map<String,dynamic>;
        return PageTransition(
          type: PageTransitionType.fade,
          child:  CategoryWiseProductsPage(
            categoryId: args['categoryId'],
            title: args['title'],
          ),
        );
      case addressPage:
        // var addressUpdate = settings.arguments as String;
        // var addressList = settings.arguments as List<AddressProfileModel>;
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(
          type: PageTransitionType.fade,
          child: AddressPage(
            addressUpdate: args['addressUpdate'] as String,  // Cast to String
            addressList: args['addressList'] as List<AddressShowModel>,  // Cast to List
            index: args['index'] as int,
          ),
        );

      case addressUpdatePage:
      // var addressUpdate = settings.arguments as String;
      // var addressList = settings.arguments as List<AddressProfileModel>;
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(
          type: PageTransitionType.fade,
          child: AddressUpdatePage(
            addressUpdate: args['addressUpdate'] as String,  // Cast to String
            addressList: args['addressList'] as List<AddressShowModel>,  // Cast to List
            index: args['index'] as int,
          ),
        );

      case addressShow:
        return PageTransition(
          type: PageTransitionType.fade,
          child:  AddressShow(),
        );
      case orderPage:
        return PageTransition(
          type: PageTransitionType.fade,
          child:  OrderPage(),
        );

      case orderDetailsPage:
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(
          type: PageTransitionType.fade,
          child:  OrderDetails(
            productCode: args['productCode'] as String,
            productName: args['productName'] as String,
            productImage: args['productImage'] as String,
            productQuantity: args['productQuantity'] as String,
            productPrice: args['productPrice'] as String,
            shipping_cost: args['shipping_cost'] as String,
          ),
        );
      case orderActivityPage:
        return PageTransition(
          type: PageTransitionType.fade,
          child:  OrderActivityPage(),
        );
      case orderCartDetailsPage:
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(
          type: PageTransitionType.fade,
          child:  OrderCartDetails(
            checkedValue: args['checkedValue'] as List<String>,
            tempCartList: args['tempCartList'] as List<CartProductModel>,
            addressResponseModel: args['addressResponseModel'] as AddressResponseModel,
            shipping_cost: args['shipping_cost'] as String,
          ),
        );
      case cartPage:
        final flag = settings.arguments as bool;
        return PageTransition(
          type: PageTransitionType.fade,
          child:  CartPage(leading: flag,),
        );
      case categorySubcategoryListPage:
        final flag = settings.arguments as bool;
        return PageTransition(
          type: PageTransitionType.fade,
          child:  CategorySubcategoryList(leading: flag,),
        );
      case wishListPage:
        final leading = settings.arguments as bool;
        return PageTransition(
          type: PageTransitionType.fade,
          child:   WishListPage(leading: leading,),
        );
      case orderShowDetailsPage:
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(
          type: PageTransitionType.fade,
          child:  OrderShowDetails(
            orderModel: args["orderList"] as List<OrderModel>,
            orderStatus: args["orderStatus"] as String,
            index: args["index"] as int,
            indexOrder: args["indexOrder"] as int,

          ),
        );
      case privacyPolicyPage:
        final title = settings.arguments as String;
        return PageTransition(
          type: PageTransitionType.fade,
          child:  PrivacyPolicyPage(title : title),
        );
      case orderCancelPage:
        final args = settings.arguments as Map<String, dynamic>;
        return PageTransition(
          type: PageTransitionType.bottomToTop,
          child:  OrderCancel(
            orderId: args['orderId'] as String,
            productName: args['productName'] as String,
            status: args['status'] as String,

          ),
        );

      case complainGrievancePage:
        return PageTransition(
          type: PageTransitionType.bottomToTop,
          child:  const ComplainGrievance(),
        );
      case orderConfirmPage:
        return PageTransition(
          type: PageTransitionType.bottomToTop,
          child:  const OrderConfirmPage(),
        );

      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return PageTransition(
      type: PageTransitionType.rightToLeft,
      child: const Scaffold(
        appBar: null,
        body: Center(child: Text('')),
      ),
    );
  }
}
