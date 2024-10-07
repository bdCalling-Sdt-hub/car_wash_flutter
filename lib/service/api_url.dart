class ApiUrl {
  static const baseUrl = "http://192.168.10.32:8052";
  static const imageBaseUrl = '$baseUrl/';
  static socketUrl({String userID = ""}) => '$baseUrl?userId=$userID';

  /// ============================ Auth ==============================

  static const signUpClient = "/client/auth/register";
  static const signUpWorker = "/worker/auth/register";

  static const activeClient = "/client/auth/activate-user";
  static const activeWorker = "/worker/auth/activate-user";

  static const resendOTpWorker = "/worker/auth/resend-activation-code";
  static const resendOTpClient = "/client/auth/resend-activation-code";

  static const forgotPassClient = "/client/auth/forgot-password";
  static const forgotPassWorker = "/worker/auth/forgot-password";

  static const changePassClient = "/client/auth/change-password";
  static const changePassWorker = "/worker/auth/change-password";

  static const signInClient = "/client/auth/login";
  static const signInWorker = "/worker/auth/login";

  /// ========================== Get Profile =========================
  static const clientProfile = "/client/profile";
  static const workerProfile = "/worker/profile";
}
