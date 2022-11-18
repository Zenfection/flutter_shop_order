import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Source
import 'package:shop_order/main/store/AppStore.dart';
import 'package:shop_order/main/utils/AppColors.dart';
import 'package:shop_order/utils/GSWidgets.dart';
import 'package:shop_order/utils/GSColors.dart';
import 'package:shop_order/utils/AppConstants.dart';
// import 'package:shop_order/main.dart';

// Redirection
import 'package:shop_order/screens/GSRegisterScreen.dart';
import 'package:shop_order/screens/GSMainScreen.dart';

// import 'package:shop_order/screens/GSForgotPasswordScreen.dart';

class GSLoginScreen extends StatefulWidget {
  static String tag = '/GSLoginScreen';

  const GSLoginScreen({super.key});

  @override
  GSLoginScreenState createState() => GSLoginScreenState();
}

class GSLoginScreenState extends State<GSLoginScreen> {
  // appstore
  AppStore appStore = AppStore();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool showPassword = false;

// add list error
  final String _usernameErr = 'Tài khoản không hợp lệ';
  final String _passwordErr = 'Mật khẩu không hợp lệ';
  bool _userInvalid = false;
  bool _passInvalid = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    setStatusBarColor(appStore.isDarkModeOn ? scaffoldColorDark : Colors.white,
        statusBarIconBrightness: Brightness.dark);
  }

  @override
  void dispose() {
    setStatusBarColor(appStore.isDarkModeOn ? scaffoldColorDark : Colors.white);
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: appBarWidget('',
            color: appStore.isDarkModeOn ? scaffoldColorDark : Colors.white),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Đăng nhập", style: boldTextStyle(size: 20)),
              16.height,
              Form(
                key: formKey,
                child: Column(
                  children: [
                    AppTextField(
                      controller: emailController,
                      textFieldType: TextFieldType.EMAIL,
                      decoration: inputDecoration(
                          label: "Username",
                          error: _userInvalid ? _usernameErr : null),
                      focus: emailNode,
                      nextFocus: passwordNode,
                      keyboardType: TextInputType.text,
                    ),
                    16.height,
                    TextFormField(
                      focusNode: passwordNode,
                      controller: passwordController,
                      autofocus: false,
                      obscureText: showPassword ? false : true,
                      onFieldSubmitted: (term) {
                        passwordNode.unfocus();
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            showPassword = !showPassword;
                            setState(() {});
                          },
                          child: Icon(
                              showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: primaryColor),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor)),
                        labelStyle: secondaryTextStyle(size: 14),
                        labelText: "Mật Khẩu",
                        errorText: _passInvalid ? _passwordErr : null,
                      ),
                    ),
                  ],
                ),
              ),
              50.height,
              gsAppButton(
                context,
                'Đăng Nhập',
                () {
                  loginClicked();
                },
              ),
              // 16.height,
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: Text("Quên Mật Khẩu?",
              //           style: boldTextStyle(color: primaryColor, size: 14))
              //       .onTap(() {
              //     GSForgotPasswordScreen().launch(context);
              //   }),
              // ),
              30.height,
              createRichText(list: [
                TextSpan(
                    text: "Nếu bạn chưa có tài khoản? ",
                    style: secondaryTextStyle(size: 16)),
                TextSpan(
                  text: "Đăng Ký",
                  style: boldTextStyle(color: primaryColor, size: 18),
                ),
              ]).center().onTap(() {
                const GSRegisterScreen().launch(context);
              }),
            ],
          ).paddingAll(16),
        ),
      ),
    );
  }

  void loadFlutterToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future loginUser(String username, String password) async {
    // ignore: unnecessary_brace_in_string_interps
    //*  http post
    String md5password = md5.convert(utf8.encode(password)).toString();
    // String baseUrl = 'http://localhost:7316/api';
    var uri = Uri.parse('$baseUrl/login');
    var response = await http.post(uri,
        body: (<String, String>{
          'username': username,
          'password': md5password,
        }));

    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes));
      if (data['status'] == 'success') {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('username', username);
        prefs.setString('password', md5password);
        prefs.setBool('isLogged', true);
        appStore.isLoggedIn = true;
        goMainScreen();
      } else if (data['status'] == 'error') {
        loadFlutterToast(data['message']);
      } else if (data['status'] == 'failed') {
        loadFlutterToast(data['message']);
      }
    }
  }

  void goMainScreen() => {
        finish(context),
        const GSMainScreen().launch(context),
      };

  void loginClicked() {
    setState(() {
      String username = emailController.text;
      String password = passwordController.text;

      if (username.isEmpty || username.length < 3) {
        _userInvalid = true;
      } else {
        _userInvalid = false;
      }
      if (password.isEmpty || password.length < 6) {
        _passInvalid = true;
      } else {
        _passInvalid = false;
      }

      if (!_userInvalid && !_passInvalid) {
        loginUser(username, password);
      }
    });
  }
}
