import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:oms_ecommerce/core/services/routeHelper/route_name.dart';


class NavigationHelper {
  static navigationHelper({
    required BuildContext context,
    required String value,
  }) {
    log("Value => $value");
    switch (value) {
      case scanPagePath:
        Navigator.pushNamed(context, scanPagePath);
        break;
      case profile:
        Navigator.pushNamed(context, profile);
        break;
      case contactUsPage:
        Navigator.pushNamed(context, contactUsPage);
        break;
      case productReviewAndRatingPage:
        Navigator.pushNamed(context, productReviewAndRatingPage);
        break;
      case profileEdit:
        Navigator.pushNamed(context, profileEdit);
        break;

      case productSearch:
        Navigator.pushNamed(context, profileEdit);
        break;

      case addressPage:
        Navigator.pushNamed(context, addressPage);
        break;
      case addressUpdatePage:
        Navigator.pushNamed(context, addressUpdatePage);
        break;

      case addressShow:
        Navigator.pushNamed(context, addressShow);
        break;
      case orderPage:
        Navigator.pushNamed(context, orderPage);
        break;

      case brandProductListPage:
        Navigator.pushNamed(context, brandProductListPage);
        break;

      case topCategoryProductListPage:
        Navigator.pushNamed(context, topCategoryProductListPage);
        break;

      case orderConfirmPage:
        Navigator.pushNamed(context, orderConfirmPage);
        break;

      case orderDetailsPage:
        Navigator.pushNamed(context, orderDetailsPage);
        break;
      case orderShowDetailsPage:
        Navigator.pushNamed(context, orderShowDetailsPage);
        break;
      case cartPage:
        Navigator.pushNamed(context, cartPage);
        break;
      case wishListPage:
        Navigator.pushNamed(context, wishListPage);
        break;
      case privacyPolicyPage:
        Navigator.pushNamed(context, privacyPolicyPage);
        break;
      case orderCartDetailsPage:
        Navigator.pushNamed(context, orderCartDetailsPage);
        break;

      case orderActivityPage:
        Navigator.pushNamed(context, orderActivityPage);
        break;

      case categorySubcategoryListPage:
        Navigator.pushNamed(context, categorySubcategoryListPage);
        break;

      case orderCancelPage:
        Navigator.pushNamed(context, orderCancelPage);
        break;
      case complainGrievancePage:
        Navigator.pushNamed(context, complainGrievancePage);
        break;

      default:
        break;
    }
  }
}
