import 'dart:async';
import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:intl/intl.dart';
import 'package:manifest/controllers/home_controller_two.dart';
import 'package:manifest/core/services/firebase_notification_service.dart';
import 'package:manifest/core/services/profile_service.dart';
import 'package:manifest/core/utils/mixins/profile_controller_mixin.dart';
import 'package:manifest/features/create_account/creating_account_screen.dart';
import 'package:manifest/features/navbar/navbar_screen.dart';
import 'package:manifest/features/social_auth/social_auth_service.dart';
import 'package:manifest/models/goal_model.dart';
import 'package:manifest/services/api_service.dart';
import 'package:manifest/services/auth_services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/view/auth_screens/complete_profile_screen.dart';
import 'package:manifest/view/auth_screens/reset_password.dart';
import 'package:manifest/view/auth_screens/create_account_main_screen.dart';
import 'package:manifest/view/auth_screens/verification_pin.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SurveyModel {
  final String name;
  final String? iconPath;
  final String? emoji;
  SurveyModel({
    required this.name,
    this.iconPath,
    this.emoji,
  });
}

class AuthController extends GetxController with ProfileControllerMixin {
  /// * social auth service
  final SocialAuthService _socialAuthService = SocialAuthService();

  // firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FacebookLogin facebookLogin = FacebookLogin();

  RxBool isSignInWithGoogle = false.obs;
  final Rxn<User> _firebaseUser = Rxn<User>();
  User? get userCredential => _firebaseUser.value;

  ApiService apiService = Get.find<ApiService>();
  GoalsModel goalsModel = GoalsModel();
  RxList<GoalsModel> goalsList = [
    GoalsModel(title: AppStrings.health, id: 1, emoji: '🏋️'),
    GoalsModel(title: AppStrings.wealth, id: 2, emoji: '💰'),
    GoalsModel(title: AppStrings.happiness, id: 3, emoji: '😊'),
    GoalsModel(title: AppStrings.love, id: 4, emoji: '❤️'),
    GoalsModel(title: AppStrings.success, id: 5, emoji: '🏆'),
    GoalsModel(title: AppStrings.family, id: 6, emoji: '👨‍👩‍👧‍👦'),
    GoalsModel(title: AppStrings.career, id: 7, emoji: '👨‍💼'),
    GoalsModel(title: AppStrings.education, id: 8, emoji: '📚'),
    GoalsModel(title: AppStrings.travel, id: 9, emoji: '✈️'),
    GoalsModel(title: AppStrings.spirituality, id: 10, emoji: '🙏'),
  ].obs;

  // ......
  RxList appLanguage = ['English', 'Spanish', 'Japanese'].obs;

  RxInt selectedLanguageIndex = 0.obs; // Track selected language index

  // Method to switch language
  void switchLanguage(int index) {
    selectedLanguageIndex.value = index;
  }

  // ......

  final RxList<int> _selectedGoalIndex = <int>[].obs;
  List<int> get selectedGoalIndex => _selectedGoalIndex.toList();
  void setSelectedGoalIndex(int index) {
    if (_selectedGoalIndex.contains(index)) {
      _selectedGoalIndex.remove(index);
    } else {
      if (_selectedGoalIndex.length < 3) {
        _selectedGoalIndex.add(index);
      }
    }
    update();
  }

  List<SurveyModel> surveyList = [
    SurveyModel(
      iconPath: 'assets/icons/family.svg',
      name: 'Friends or Family',
    ),
    SurveyModel(
      iconPath: '',
      emoji: '📰',
      name: 'Article or Blog',
    ),
    SurveyModel(
      iconPath: 'assets/icons/facebook.svg',
      name: 'Facebook',
    ),
    SurveyModel(
      iconPath: 'assets/icons/youtube.svg',
      name: 'YouTube',
    ),
    SurveyModel(
      iconPath: 'assets/icons/reddit.svg',
      name: 'Reddit',
    ),
    SurveyModel(
      iconPath: 'assets/icons/apple.svg',
      name: 'Apple App Store',
    ),
    SurveyModel(
      iconPath: 'assets/icons/google.svg',
      name: 'Google Play Store',
    ),
    SurveyModel(
      iconPath: '',
      name: 'Newsletter/Email',
    ),
    SurveyModel(
      iconPath: 'assets/icons/instagram.svg',
      name: 'Instagram',
    ),
    SurveyModel(
      iconPath: 'assets/icons/tiktok.svg',
      name: 'Tiktok',
    ),
    SurveyModel(
      iconPath: 'assets/icons/x.svg',
      name: 'Twitter',
    ),
    SurveyModel(
      iconPath: '',
      emoji: '🌐',
      name: 'Other',
    ),
  ];

  final RxInt _selectedSurveyIndex = RxInt(-1);
  int get selectedSurveyIndex => _selectedSurveyIndex.value;
  final RxString _selectedSurvey = ''.obs;
  String get selectedSurvey => _selectedSurvey.value;

  void setSelectedSurveyIndex(int index, SurveyModel surveyName) {
    _selectedSurveyIndex.value = index;
    _selectedSurvey.value = surveyName.name;
  }

  final RxBool _obscureText = true.obs;
  bool get obscureText => _obscureText.value;
  void togglePasswordVisibility() {
    _obscureText.toggle();
  }

  final RxList<int> _selectedDays = <int>[].obs;
  List<int> get selectedDays => _selectedDays.toList();

  void toggleDaySelection(int index) {
    if (_selectedDays.contains(index)) {
      _selectedDays.remove(index);
    } else {
      _selectedDays.add(index);
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();

    /// ! currently not in use [@alok_singh]
    // _firebaseUser.bindStream(_auth.authStateChanges());

    /// * Initialize with existing date if available
    if (dateOfBirth != null) {
      dateOfBirthController.text =
          DateFormat('MM-dd-yyyy').format(dateOfBirth!);
    }

    /// * fetch and save device id
    getDeviceId();
  }

  // get device id
  final deviceInfo = DeviceInfoPlugin();
  String? deviceID;
  getDeviceId() async {
    if (GetPlatform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceID = androidInfo.id;
      update();
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceID = iosInfo.identifierForVendor;
      update();
    }
    LocalStorage.setDeviceID(deviceID.toString());
    LogUtil.v('device info: ${LocalStorage.deviceID}');
  }

  // sign with google  (firebase) .....
  Future<void> signInWithGoogleFirebase() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        // Use LogUtil to log the success details
        LogUtil.v('Successfully signed in with Google', error: {
          'UserID': '${userCredential.user?.uid}\n',
          'Email': '${userCredential.user?.email}\n',
          'DisplayName': '${userCredential.user?.displayName}\n',
          'PhotoURL': '${userCredential.user?.photoURL}\n'
        });
        Get.offAll(() => NavbarScreen());
      }
    } catch (e) {
      ToastUtil.error("Failed to sign in: $e");
      // Use LogUtil to log the error
      LogUtil.e('Sign in failed', error: e);
    }
  }
  // ...............................

  // facebook sign in (firebase) .............
  Future<void> signInWithFacebookFirebase() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(
                loginResult.accessToken!.tokenString // Corrected token access
                );

        final UserCredential userCredential =
            await _auth.signInWithCredential(facebookAuthCredential);
        LogUtil.v('Successfully logged in with Facebook', error: {
          'FirebaseUserID': userCredential.user?.uid,
          'Email': userCredential.user?.email,
        });
      } else {
        ToastUtil.error('Facebook login failed: ${loginResult.message}');
        // Log the failure
        LogUtil.e('Facebook login failed', error: {
          'Status': loginResult.status.toString(),
          'Message': loginResult.message,
        });
      }
    } catch (e) {
      ToastUtil.error('An error occurred during Facebook login');
      LogUtil.e('Facebook login exception', error: e.toString());
    }
  }

  Future<void> logoutFromFacebook() async {
    try {
      // Log out from Facebook
      await FacebookAuth.instance.logOut();
      // Log out from Firebase
      await _auth.signOut();

      // Log the logout event
      LogUtil.v('Successfully logged out from Facebook and Firebase');

      // Navigate back to the login screen
      // Get.offAll(() => AuthenticationScreen());  // Navigate back to the login screen
    } catch (e) {
      // Handle errors during the logout process
      ToastUtil.error('An error occurred during logout');

      // Log the exception
      LogUtil.e('Logout exception', error: e.toString());
    }
  }

  // ...........................

  // RxStatus for the login request
  // Future<void> signInWithGoogle() async {
  //   if (GetPlatform.isAndroid) {
  //     GoogleSignIn(
  //       scopes: <String>[
  //         'email',
  //         'https://www.googleapis.com/auth/contacts.readonly',
  //       ],
  //       clientId: '7453889585-dj9bs3ip8mirlg3k1k8j0t1snjt4v3el.apps.googleusercontent.com'
  //     );
  //     try {
  //       Future<GoogleSignInAccount?> login = GoogleSignIn().signIn();
  //       GoogleSignInAuthentication? auth = await login.then((value) => value!.authentication);
  //       if (auth != null) {
  //         String? accessToken = auth.accessToken;
  //         log("google_token: $accessToken");
  //         await _loginWithSocial(accessToken: accessToken.toString(), provider: 'google');
  //       }
  //     } catch (e) {
  //       log("exception error: $e");
  //     }
  //   }else{
  //     GoogleSignInPlatform.instance.initWithParams(
  //       const SignInInitParameters(
  //         scopes: <String>[
  //           'email',
  //           'https://www.googleapis.com/auth/contacts.readonly',
  //         ],
  //         clientId: '7453889585-vigfd549g7smc47vsmpq1vac5u4lkaog.apps.googleusercontent.com',
  //         signInOption: SignInOption.standard,
  //         forceCodeForRefreshToken: true,
  //         hostedDomain: 'www.ideatrapp.com',
  //       ),
  //     );
  //     Future<GoogleSignInUserData?> login = GoogleSignInPlatform.instance.signIn().then((value) {
  //       GoogleSignInPlatform.instance.getTokens(email: value!.email).then((value) {
  //         log("google_token: ${value.accessToken}");
  //         _loginWithSocial(accessToken: value.accessToken.toString(), provider: 'google');
  //       });
  //       return null;
  //     });
  //   }
  // }

  // Future<void> signInWithApple() async {
  //   try {
  //     final credential = await SignInWithApple.getAppleIDCredential(
  //       scopes: [
  //         AppleIDAuthorizationScopes.email,
  //         AppleIDAuthorizationScopes.fullName,
  //       ],
  //     );
  //     log("apple credential: ${credential.identityToken}");
  //     await _loginWithSocial(
  //         accessToken: credential.identityToken.toString(), provider: 'apple');
  //   } catch (e) {
  //     log("apple credential: $e");
  //   }
  // }

  // Future<void> signInFB() async {
  //   final FacebookLoginResult result = await facebookLogin.logIn(
  //     customPermissions: [
  //       'email',
  //       'public_profile',
  //     ],
  //   );
  //   log("user from fb: ${result.accessToken!.token}");
  //   final String token = result.accessToken!.token;
  //   await _loginWithSocial(accessToken: token, provider: 'facebook');
  // }

  TextEditingController nameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  clearTextEditingControllers() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  // register with email
  Future<void> registerWithEmail() async {
    try {
      LoadingUtil.show();
      Map<String, dynamic> body = {
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'confirm_password': confirmPasswordController.text,
        // 'user_goals': goalsList.map((element) => element.id).join(', '),
        // 'find_from': selectedSurvey != '' ? selectedSurvey : 'Facebook',
        'device_id': LocalStorage.deviceID.toString(),
        'fcm_token': Get.find<FirebaseNotificationService>().token
      };
      var response = await apiService.request(
        apiEndPoint: ApiService.registerWithEmail,
        data: body,
        isPost: true,
        withToken: false,
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        LocalStorage.setLoginToken(data['data']['token']);
        clearTextEditingControllers();
        LoadingUtil.dismiss();
        Get.offAll(
          () => const CompleteProfileScreen(),
        );
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        ToastUtil.error(data['message']);
        LoadingUtil.dismiss();
      } else {
        ToastUtil.error(
            'Something went wrong from server side please try again');
        LoadingUtil.dismiss();
      }
    } catch (e) {
      LogUtil.e('register catch error ${e.toString()}');
      LoadingUtil.dismiss();
    }
  }

  // complete profile
  DateTime? dateOfBirth;
  void setDateOfBirth(DateTime date) {
    dateOfBirth = date;
    dateOfBirthController.text = DateFormat('MM-dd-yyyy').format(date);
    update();
  }

  final RxString _selectGender = ''.obs;
  String get selectGender => _selectGender.value;
  void setSelectedGender(String option) {
    _selectGender.value = option;
  }

  // login with email
  Future<void> loginWithEmail() async {
    try {
      LoadingUtil.show();
      Map<String, dynamic> body = {
        'device_id': LocalStorage.deviceID.toString(),
        'email': emailController.text,
        'password': passwordController.text,
        'fcm_token': Get.find<FirebaseNotificationService>().token,
      };
      var response = await apiService.request(
          apiEndPoint: ApiService.loginWithEmail,
          data: body,
          isPost: true,
          withToken: false);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        /// * save login token
        LocalStorage.setLoginToken(data['data']['token']);
        LoadingUtil.dismiss();

        /// * navigate to home screen
        await profileController.fetchProfile();
        await Get.offAll(() => NavbarScreen());

        ToastUtil.success('Login Successfully');

        /// * reset fields
        clearTextEditingControllers();

        /// * login as guest [to send the fcm and device token] and set reminder
        await Get.find<AuthService>().setInitialReminder();
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        ToastUtil.error(data['message']);
        LoadingUtil.dismiss();
      } else {
        ToastUtil.error(
            'Something went wrong from server side please try again');
        LoadingUtil.dismiss();
      }
    } catch (e) {
      LogUtil.e('register catch error ${e.toString()}');
      LoadingUtil.dismiss();
    }
  }

  // complete profile
  Future<void> completeProfile() async {
    try {
      // EasyLoading.show();
      Map<String, dynamic> body = {
        'name': nameController.text,
        'dob': dateOfBirth?.toIso8601String(),
        'gender': selectGender.toLowerCase(),
        'device_id': LocalStorage.deviceID.toString(),
      };
      var response = await apiService.request(
        apiEndPoint: ApiService.updateProfile,
        data: body,
        isPost: true,
        withToken: true,
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        ToastUtil.success('Profile Completed Successfully');
        LoadingUtil.dismiss();

        /// * navigate to the creatingAccountScreen()
        Get.offAll(() => const CreatingAccountScreen());

        /// * fetch profile details
        profileController.onInit();

        nameController.clear();
        dateOfBirth = null;
        setSelectedGender('');

        /// * early load the home screen data
        Get.find<HomeTwoController>();
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        ToastUtil.error(data['message']);
        LoadingUtil.dismiss();
      } else {
        LoadingUtil.dismiss();
        ToastUtil.error(response.reasonPhrase ??
            'Something went wrong from server side please try again');
      }
    } catch (e) {
      LogUtil.e('register catch error ${e.toString()}');
      LoadingUtil.dismiss();
    }
  }

  // login with social
  // Future<void> _loginWithSocial(
  //     {required String accessToken, required String provider}) async {
  //   try {
  //     Loading.show();
  //     Map<String, dynamic> body = {
  //       'access_token': accessToken,
  //       'provider': provider,
  //       'device_id': LocalStorage.deviceID.toString(),
  //     };
  //     var response = await apiService.request(
  //         apiEndPoint: ApiService.loginWithSocial,
  //         data: body,
  //         isPost: true,
  //         withToken: false);
  //     var data = json.decode(response.body);
  //     if (response.statusCode == 200) {
  //       LocalStorage.setLoginToken(data['data']['token']);
  //       ToastUtil.success('Login Successfully' );
  //       Loading.dismiss();
  //       Get.offAll(() => NavBar());
  //       Get.put(ProfileController()).getProfile();
  //     } else if (response.statusCode == 403 || response.statusCode == 422) {
  //       ToastUtil.error
  //         message: data['message'],
  //
  //       );
  //       Loading.dismiss();
  //     } else {
  //       ToastUtil.error
  //         message: 'Something went wrong from server side please try again',
  //
  //       );
  //       Loading.dismiss();
  //     }
  //   } catch (e) {
  //     log('register catch error ${e.toString()}');
  //     EasyLoading.dismiss();
  //   }
  // }

  // ---------- forgot password with otp verification ----------
  RxString forgotPasswordTokenValue = ''.obs;
  String get forgotPasswordToken => forgotPasswordTokenValue.value;
  void setForgotPasswordTokenValue(String value) {
    forgotPasswordTokenValue.value = value;
  }

  final RxString _forgotPasswordOtp = ''.obs;
  String get forgotPasswordOtp => _forgotPasswordOtp.value;
  void setForgotPasswordOtpValue(String value) {
    _forgotPasswordOtp.value = value;
  }

  void clearForgotPasswordOtpValue() {
    _forgotPasswordOtp.value = '';
  }

  final RxInt _timer = 0.obs;
  Timer? _timerInstance;
  int get timer => _timer.value;
  void startTimer() {
    const int initialTimerValue = 30;
    _timer.value = initialTimerValue;
    _timerInstance?.cancel();
    _timerInstance = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_timer.value == 0) {
        timer.cancel();
      } else {
        _timer.value--;
      }
    });
  }

  Future<void> sendPasswordOtp() async {
    try {
      LoadingUtil.show();
      Map<String, dynamic> body = {
        'email': emailController.text,
        'device_id': LocalStorage.deviceID.toString(),
      };
      var response = await apiService.request(
          apiEndPoint: ApiService.forgotPasswordByOtp,
          data: body,
          isPost: true,
          withToken: false);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        startTimer();
        passwordController.clear();
        confirmPasswordController.clear();
        var data = json.decode(response.body);
        setForgotPasswordTokenValue(data['data']['token']);
        ToastUtil.success('Password reset link sent to your email');
        Get.to(() => VerificationPin(
              emailController.text,
              onContinue: (otp) {},
            ));
        LoadingUtil.dismiss();
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        ToastUtil.error(data['message']);
        LoadingUtil.dismiss();
      } else {
        ToastUtil.error(
            'Something went wrong from server side please try again');
        LoadingUtil.dismiss();
      }
    } catch (e) {
      LogUtil.e('register catch error ${e.toString()}');
      LoadingUtil.dismiss();
    }
  }

  Future<void> verifyForgotPasswordOtp() async {
    try {
      LoadingUtil.show();
      Map<String, dynamic> body = {
        'email': emailController.text,
        'otp': forgotPasswordOtp.toString(),
        'device_id': LocalStorage.deviceID.toString(),
      };
      var response = await apiService.request(
          apiEndPoint: ApiService.verifyForgotPasswordOtp,
          data: body,
          isPost: true,
          withToken: false);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        clearForgotPasswordOtpValue();
        ToastUtil.success('Otp Verified');
        Get.to(() => const ResetPassword());
        LoadingUtil.dismiss();
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        ToastUtil.error(data['message']);
        LoadingUtil.dismiss();
      } else {
        ToastUtil.error(
            'Something went wrong from server side please try again');
        LoadingUtil.dismiss();
      }
    } catch (e) {
      LogUtil.e('register catch error ${e.toString()}');
      LoadingUtil.dismiss();
    }
  }

  Future<void> resetPasswordWithOtp() async {
    try {
      LoadingUtil.show();
      Map<String, dynamic> body = {
        'email': emailController.text,
        'token': forgotPasswordToken,
        'new_password': passwordController.text,
        'confirm_new_password': confirmPasswordController.text,
        'device_id': LocalStorage.deviceID.toString(),
      };
      var response = await apiService.request(
          apiEndPoint: ApiService.resetPasswordByOtp,
          data: body,
          isPost: true,
          withToken: false);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        clearTextEditingControllers();
        setForgotPasswordTokenValue('');
        ToastUtil.success('Password Reset Successfully');
        Get.offAll(() => const CreateAccountMainScreen());
        LoadingUtil.dismiss();
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        ToastUtil.error(data['message']);
        LoadingUtil.dismiss();
      } else {
        ToastUtil.error(
            'Something went wrong from server side please try again');
        LoadingUtil.dismiss();
      }
    } catch (e) {
      LogUtil.e('register catch error ${e.toString()}');
      LoadingUtil.dismiss();
    }
  }
  // ---------- forgot password with otp verification ----------

  /// * logout from app [including server, and socials, and removing the login token]
  Future<void> logout() async {
    try {
      LoadingUtil.show();

      /// * logout from api
      var response = await apiService.request(
          apiEndPoint:
              '${ApiService.logout.toString()}?device_id=${LocalStorage.deviceID.toString()}',
          isPost: true,
          withToken: true);
      var data = json.decode(response.body);

      /// * logout from socials [google, facebook, apple, firebase]
      await _socialAuthService.signOut();

      /// * on success logout, clear the local storage and navigate to login page
      if (response.statusCode == 200) {
        /// * clear the login token from local storage
        LocalStorage.removeLoginToken();

        /// * navigate to login page
        Get.offAll(() => const CreateAccountMainScreen());
        LoadingUtil.dismiss();
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        ToastUtil.error(data['message']);
        LoadingUtil.dismiss();
      } else {
        ToastUtil.error(
            'Something went wrong from server side please try again');
        LoadingUtil.dismiss();
      }
    } catch (e) {
      LogUtil.e('register catch error ${e.toString()}');
      LoadingUtil.dismiss();
    }
  }

  /// ! google sign in (server)
  RxBool get isSigningInWithGoogle =>
      RxBool(_socialAuthService.isSigningInWithGoogle.value ||
          isSendingLoginCredentialsToServer.value);
  Future<void> signInWithGoogleServer() async {
    LoadingUtil.show();

    try {
      final credential = await _socialAuthService.signInWithGoogle();

      /// * send login credentials to server
      final response = await sendLoginCredentialsToServer(
        accessToken: credential?.accessToken.toString() ?? '',
        provider: SocialAuthProvider.google.name,
      );

      if (response != null && response == true) {
        await _onLoginSuccess();
      } else {
        ToastUtil.error(
            'Something went wrong from server side please try again else');
      }
      LoadingUtil.dismiss();
    } catch (e) {
      LoadingUtil.dismiss();
      LogUtil.e('register catch error ${e.toString()}');
    } finally {
      LoadingUtil.dismiss();
    }
  }

  /// ! facebook sign in (server)
  RxBool get isSigningInWithFacebook =>
      RxBool(_socialAuthService.isSigningInWithFacebook.value ||
          isSendingLoginCredentialsToServer.value);
  Future<void> signInWithFacebookServer() async {
    LoadingUtil.show();

    try {
      /// * login with facebook
      final OAuthCredential? result =
          await _socialAuthService.signInWithFacebook();
      if (result == null) {
        LoadingUtil.dismiss();
        throw Exception('Failed to sign in with Facebook');
      }

      /// * get token
      final String token = result.accessToken!;

      /// * send login credentials to server
      final response = await sendLoginCredentialsToServer(
        accessToken: token,
        provider: SocialAuthProvider.facebook.name,
      );

      if (response != null && response == true) {
        await _onLoginSuccess();
      } else {
        ToastUtil.error(
            'Something went wrong from server side please try again');
      }
      LoadingUtil.dismiss();
    } catch (e) {
      LoadingUtil.dismiss();
      LogUtil.log("facebook credential: $e");
      ToastUtil.error('Something went wrong from server side please try again');
    } finally {
      LoadingUtil.dismiss();
    }
  }

  /// ! apple sign in (server)
  RxBool get isSigningInWithApple =>
      RxBool(_socialAuthService.isSigningInWithApple.value ||
          isSendingLoginCredentialsToServer.value);
  Future<void> signInWithAppleServer() async {
    LoadingUtil.show();

    try {
      final credential = await _socialAuthService.signInWithApple();
      LogUtil.log("apple credential: ${credential?.identityToken}");

      /// * send login credentials to server
      final response = await sendLoginCredentialsToServer(
        accessToken: credential?.identityToken.toString() ?? '',
        provider: SocialAuthProvider.apple.name,
      );

      if (response != null && response == true) {
        await _onLoginSuccess();
      } else {
        ToastUtil.error(
            'Something went wrong from server side please try again');
      }
      LoadingUtil.dismiss();
    } catch (e) {
      LoadingUtil.dismiss();
      LogUtil.log("apple credential: $e");
      ToastUtil.error('Something went wrong from server side please try again');
    } finally {
      LoadingUtil.dismiss();
    }
  }

  /// ! On Successfull Login
  Future<void> _onLoginSuccess() async {
    LogUtil.log('Login Successfull');

    /// * fetch user data [wait]
    await Get.find<ProfileService>().getProfile();

    /// * login as guest [to send the fcm and device token] and set reminder
    await Get.find<AuthService>().setInitialReminder();

    /// * navigate to home screen [wait]
    await Get.offAll(() => NavbarScreen());

    LoadingUtil.dismiss();
  }

  /// ! send login credentials to server
  RxBool isSendingLoginCredentialsToServer = false.obs;

  Future<bool?> sendLoginCredentialsToServer({
    String? accessToken,
    required String provider,
  }) async {
    try {
      /// * early return if already sending login credentials to server
      if (isSendingLoginCredentialsToServer.value) return null;

      /// * set loading to true
      isSendingLoginCredentialsToServer.value = true;

      /// * create payload
      Map<String, dynamic> body = {
        'access_token': accessToken,
        'provider': provider,
        'device_id': LocalStorage.deviceID.toString(),
        "fcm_token": Get.find<FirebaseNotificationService>().token
      };

      /// * send login credentials to server
      var response = await ApiService().request(
        apiEndPoint: ApiService.loginWithSocial,
        data: body,
        isPost: true,
        withToken: false,
      );

      /// * handle response
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        LocalStorage.setLoginToken(data['data']['token']);
        return true;
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        return false;
      } else {
        return false;
      }
    } catch (e) {
      LogUtil.log('register catch error ${e.toString()}');
      return false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    _timerInstance?.cancel();
  }
}
