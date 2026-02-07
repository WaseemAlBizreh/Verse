import 'package:easy_localization/easy_localization.dart';

import '../utils/types.dart';
import 'base_error.dart';
import 'connection/net_error.dart';
import 'connection/socket_error.dart';
import 'connection/timeout_error.dart';
import 'custom_error.dart';
import 'http/bad_request_error.dart';
import 'http/custom_http_error.dart';
import 'http/forbidden_error.dart';
import 'http/internal_server_error.dart';
import 'http/not_found_error.dart';
import 'http/unauthorized_error.dart';



abstract class ErrorHelper {
  static String badRequestErrorErrorMessage = 'bad_request_err'.tr();
  static String notFoundErrorMessage = 'not_found_err'.tr();
  static String unauthorizedErrorMessage = 'unauthorized_err'.tr();
  static String forbiddenErrorErrorMessage = 'forbidden_err'.tr();
  static String internalServerErrorMessage = 'server_err'.tr();
  static String timeoutErrorErrorMessage = 'timeout_err'.tr();
  static String unExpectedErrorMessage = 'unexpected_err'.tr();
  static String connectionErrorMessage = 'connection_err'.tr();

  static Entry<T, S?> getErrorMessage<T, S>(BaseError error) {
    if (error is NotFoundError) {
      return Entry<T,S?>(notFoundErrorMessage as T, null);
    } else if (error is UnauthorizedError) {
      return Entry<T,S?>(unauthorizedErrorMessage as T, null);
    } else if (error is BadRequestError) {
      return Entry<T,S?>(badRequestErrorErrorMessage as T, null);
    } else if (error is ForbiddenError) {
      return Entry<T,S?>(forbiddenErrorErrorMessage as T, null);
    } else if (error is InternalServerError) {
      return Entry<T,S?>(internalServerErrorMessage as T, null);
    } else if (error is TimeoutError) {
      return Entry<T,S?>(timeoutErrorErrorMessage as T, null);
    } else if (error is NetError || error is SocketError) {
      return Entry<T,S?>(connectionErrorMessage as T, null);
    } else if (error is CustomError) {
      return Entry<T,S?>(error.message as T, null);
    } else if (error is HttpFailure) {
      if (error.errorModel != null) {
        return Entry<T,S?>(error.errorModel!.message as T, error.errorModel!.errors as S?);
      }
    }
    return Entry<T,S?>(unExpectedErrorMessage as T, null);
  }
}
