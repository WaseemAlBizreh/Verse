import 'dart:io';

abstract class Api {
  static const prefix = "pos-user";

  /// Authentication
  static String loginUrl = '$prefix/home/login/send-otp';
  static String verifyOtpUrl = '$prefix/home/login/verify-otp';
  static String profileUrl = '$prefix/home/me/profile';
  static String refreshToken = '$prefix/home/token/refresh';
  static String updateDeviceTokenUrl = 'device-tokens';
  static String deleteDeviceTokenUrl(String token) => 'device-tokens/$token';

  /// Options
  static String genderOptions = 'options/genders';
  static String contactUsTypes = 'options/contact-us-types';
  static String gsmTypes = 'options/gsm-types';
  static String simTypes = 'options/sim-types';
  static String simOrderTransactionStatuses =
      'options/sim-order-pos-transaction-statuses';
  static String simRegistrationDocumentTypes =
      'options/sim-registration-document-types';
  static String simRegistrationGenderTypes =
      'options/sim-registration-gender-types';
  static String simRegistrationCustomerTypes =
      'options/sim-registration-customer-types';
  static String simRegistrationSimTypes = 'options/sim-registration-sim-types';

  /// Settings
  static String visualSettings = 'visual-settings';
  static String multiTypeSettings = 'multi-type-settings';

  /// Mobile App Version
  static String get mobileAppVersion => Platform.isAndroid
      ? 'mobile-app-versions/google-play'
      : 'mobile-app-versions/app-store';

  /// FAQ Categories
  static String faqCategories = 'faq-categories';

  /// Contact Us
  static String contactUsUrl = 'contact-us';

  /// Bundle Categories
  static String bundleCategoriesTree = 'bundle-categories/tree';

  /// Transactions
  static String activateBundle = '$prefix/transactions/bundle';
  static String recharge = '$prefix/transactions/recharge';
  static String airtimeOrder = '$prefix/transactions/airtime-order';
  static String posTransactions = 'pos-transactions';
  static String posTransactionById(int id) => 'pos-transactions/$id';
  static String tradePartnerTransactions = 'trade-partner/transactions';

  static String updateTransactionStatus(int id) =>
      'trade-partner/transactions/$id/updated-status';

  /// Push Notifications
  static String pushNotifications = '$prefix/push-notifications';
  static String pushNotificationsUnreadCount =
      '$prefix/push-notifications/unread-count';
  static String markNotificationsAsRead = '$prefix/push-notifications/read-all';

  /// Centers
  static String centers = 'centers';
  static String centersNearby = 'centers/nearby';

  /// Payment Providers
  static String paymentProviders = 'payment-providers';

  /// Sim Order
  static String calculateSimOrderPrices =
      '$prefix/transactions/sim-order/calculate-prices';
  static String simOrder = '$prefix/transactions/sim-order';
  static String simRegistration = '$prefix/transactions/sim-registration';

  /// Service Categories
  static String serviceCategoriesWithTree =
      'service-categories/with-service-tree';

  /// Countries
  static String countries = 'countries';
}
