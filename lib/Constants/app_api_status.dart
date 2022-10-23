class AppAPIStatus {
  static const int okStatus = 200; //OK
  static const int createdStatus = 201; //Created
  static const int acceptedStatus = 202; //Accepted
  static const int badRequestStatus = 400; //Bad Request
  static const int unauthorizedStatus = 401; //Unauthorized
  static const int forbiddenStatus = 403; //Forbidden
  static const int notFoundStatus = 404; //Not Found
  static const int methodNotAllowedStatus = 405; //Method Not Allowed
  static const int notAcceptedStatus = 406; //Not Acceptable
  static const int proxyAuthenticationRequiredStatus =
      407; //Proxy Authentication Required
  static const int requestTimeoutStatus = 408; //Request Timeout
  static const int contentTooLargeStatus = 413; //Content Too Large
  static const int uriTooLongStatus = 414; //URI Too Long
  static const int unsupportedMediaTypeStatus = 415; //Unsupported Media Type
  static const int tooManyRequestsStatus = 429; //Too Many Requests
  static const int requestHeaderTooLargeStatus =
      431; //Request Header Fields Too Large
  static const int internalServerErrorStatus =
      500; //static const internal Server Error
  static const int notImplementedStatus = 501; //Not Implemented
  static const int badGatewayStatus = 502; //Bad Gateway
  static const int serviceUnavailableStatus = 503; //Service Unavailable
  static const int gatewayTimeoutStatus = 504; //Gateway Timeout
}
