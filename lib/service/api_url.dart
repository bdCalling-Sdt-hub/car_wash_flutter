class ApiUrl {
  static const baseUrl = "http://103.161.9.133:5000";
  static const imageBaseUrl = '$baseUrl/';
  static socketUrl({String userID = ""}) => '$baseUrl?userId=$userID';

  /// ============================ Auth ==============================

  static const signUpClient = "/worker/auth/register";
  static const signUpWorker = "/client/auth/register";

  static const activeClient = "/client/auth/register";
  static const activeWorker = "/worker/auth/register";

  static const forgotPassClient = "/client/auth/forgot-password";
  static const forgotPassWorker = "/worker/auth/forgot-password";

  static const changePassClient = "/client/auth/change-password";
  static const changePassWorker = "/worker/auth/change-password";
}
