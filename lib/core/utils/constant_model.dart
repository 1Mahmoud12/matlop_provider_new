import 'package:matlop_provider/feature/addNewAddress/data/models/city_model.dart';
import 'package:matlop_provider/feature/addNewAddress/data/models/country_model.dart';
import 'package:matlop_provider/feature/addNewAddress/data/models/districts_model.dart';
import 'package:matlop_provider/feature/auth/signUp/data/technical_special_list_model.dart';
import 'package:matlop_provider/feature/menu/views/commonQuestions/data/models/common_question_model.dart';
import 'package:matlop_provider/feature/menu/views/editProfile/data/models/profile_model.dart';
import 'package:matlop_provider/feature/menu/views/privacy&policy/data/models/privacy_and_policy_model.dart';
import 'package:matlop_provider/feature/menu/views/wallet/data/model/transactions_model.dart';
import 'package:matlop_provider/feature/menu/views/wallet/data/model/wallet_model.dart';
import 'package:matlop_provider/feature/myAddresses/data/models/my_address_model.dart';
import 'package:matlop_provider/feature/notification/data/models/fire_notification_model.dart';
import 'package:matlop_provider/feature/order/data/models/details_special_order_model.dart';
import 'package:matlop_provider/feature/order/data/models/get_order_details_model.dart';
import 'package:matlop_provider/feature/order/data/models/order_model.dart';

import '../../feature/menu/views/termsAndConditions/data/models/terms_and_conditions_model.dart';
import '../../feature/order/data/models/special_orders_model.dart';

class ConstantModel {
  static CommonQuestionModel? commonQuestionModel;
  static TermsAndConditionsModel? termAndConditionModel;
  static PrivacyAndPolicyModel? privacyAndPolicyModel;
  static ProfileModel? profileModel;
  static CityModel? cityModel;
  static CountryModel? countryModel;
  static DistrictModel? districtModel;
  static MyAddressModel? myAddressModel;
  static OrderDetailsModel? orderDetailsModel;
  static OrderModel? orderModel;
  static WalletModel? walletModel;
  static TransactionsModel? transactionsModel;
  static SpecialOrdersModel? specialOrdersModel;
  static SpecialOrdersModel? offersModel;
  static DetailsSpecialOrderModel? detailsSpecialOrderModel;
  static TechnicalSpecialListModel? technicalSpecialListModel;
  static FireNotificationModel? notificationModel;
}
