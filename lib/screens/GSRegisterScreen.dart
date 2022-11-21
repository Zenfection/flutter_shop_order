// ignore_for_file: file_names

import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_order/utils/AppConstants.dart';

// Source
import 'package:shop_order/utils/GSColors.dart';
import 'package:shop_order/main.dart';
import 'package:shop_order/main/utils/AppColors.dart';
import 'package:shop_order/utils/widget/register.dart';
// import 'package:shop_order/utils/GSImages.dart';

// Redicrect
import 'GSLoginScreen.dart';

class GSRegisterScreen extends StatefulWidget {
  static String tag = '/GSRegisterScreen';

  const GSRegisterScreen({super.key});

  @override
  GSRegisterScreenState createState() => GSRegisterScreenState();
}

class GSRegisterScreenState extends State<GSRegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode emailNode = FocusNode();
  FocusNode fullnameNode = FocusNode();
  FocusNode usernameNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();

  bool showPassword = false;

  //Add list error
  final String _emailErr = 'Email không hợp lệ';
  late String _fullnameErr = 'Họ tên không hợp lệ';
  late String _usernameErr = 'Tài khoản không hợp lệ';
  late String _phoneErr = 'Số điện thoại không hợp lệ';
  late String _passwordErr = 'Mật khẩu không hợp lệ';
  late final String _confirmPasswordErr = 'Mật khẩu không khớp';

  final bool _emailInvalid = false;
  bool _fullnameInvalid = false;
  bool _usernameInvalid = false;
  bool _phoneInvalid = false;
  bool _passwordInvalid = false;
  final bool _confirmPasswordInvalid = false;

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
    setStatusBarColor(appStore.isDarkModeOn ? scaffoldColorDark : primaryColor,
        statusBarIconBrightness: Brightness.dark);
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBarWidget('',
          color: appStore.isDarkModeOn ? scaffoldColorDark : Colors.white),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Đăng ký",
              style: boldTextStyle(size: 25),
            ),
            16.height,
            // Row(
            //   children: [
            //     Container(
            //       width: context.width(),
            //       height: 50,
            //       decoration: boxDecorationWithRoundedCorners(
            //         borderRadius: radius(4),
            //         backgroundColor: appStore.isDarkModeOn ? scaffoldSecondaryDark : Colors.black,
            //       ),
            //       child: commonCacheImageWidget(gs_apple_icon, 24, width: 24),
            //     ).expand(),
            //     8.width,
            //     Container(
            //       width: context.width(),
            //       height: 50,
            //       decoration: boxDecorationWithRoundedCorners(
            //         borderRadius: radius(4),
            //         border: Border.all(color: Colors.grey[300]!),
            //       ),
            //       child: Image.asset(gs_google_icon, height: 24, width: 24),
            //     ).expand()
            //   ],
            // ),
            16.height,
            Form(
              key: formKey,
              child: Column(
                children: [
                  AppTextField(
                    controller: emailController,
                    textFieldType: TextFieldType.EMAIL,
                    decoration: inputDecoration(
                      label: 'Email',
                      error: _emailInvalid ? _emailErr : null,
                    ),
                    focus: emailNode,
                    nextFocus: fullnameNode,
                    keyboardType: TextInputType.text,
                    errorThisFieldRequired: 'Email không được để trống',
                    errorInvalidEmail: "Không đúng định dạng email",
                  ),
                  16.height,
                  AppTextField(
                    autoFocus: false,
                    controller: fullnameController,
                    textFieldType: TextFieldType.NAME,
                    decoration: inputDecoration(
                      label: 'Họ và tên',
                      error: _fullnameInvalid ? _fullnameErr : null,
                    ),
                    focus: fullnameNode,
                    nextFocus: usernameNode,
                    keyboardType: TextInputType.text,
                    errorThisFieldRequired: 'Họ Tên không được để trống',
                  ),
                  16.height,
                  AppTextField(
                    autoFocus: false,
                    controller: usernameController,
                    textFieldType: TextFieldType.USERNAME,
                    decoration: inputDecoration(
                      label: 'Tên tài khoản',
                      error: _usernameInvalid ? _usernameErr : null,
                    ),
                    focus: usernameNode,
                    nextFocus: phoneNode,
                    keyboardType: TextInputType.text,
                    errorThisFieldRequired: 'Tên tài khoản không được để trống',
                  ),
                  20.height,
                  Row(
                    children: [
                      CountryCodePicker(
                        enabled: false,
                        onChanged: print,
                        initialSelection: 'VN',
                        favorite: const ['+84', 'Vietnam'],
                        showCountryOnly: true,
                        showOnlyCountryWhenClosed: true,
                        alignLeft: false,
                      ),
                      AppTextField(
                        autoFocus: false,
                        controller: phoneController,
                        textFieldType: TextFieldType.PHONE,
                        focus: phoneNode,
                        nextFocus: passwordNode,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.phone,
                        decoration: inputDecoration(
                          label: 'Số điện thoại',
                          error: _phoneInvalid ? _phoneErr : null,
                        ),
                        errorThisFieldRequired:
                            "Số điện thoại không được để trống",
                      ).expand()
                    ],
                  ),
                  16.height,
                  TextFormField(
                    controller: passwordController,
                    focusNode: passwordNode,
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
                        child: FaIcon(
                            size: 20,
                            showPassword
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            color: primaryColor),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: grey)),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: primaryColor)),
                      labelStyle: secondaryTextStyle(size: 14),
                      labelText: "Mật Khẩu",
                      errorText: _passwordInvalid ? _passwordErr : null,
                    ),
                    validator: (val) {
                      if (val.isEmptyOrNull) {
                        return "Vui Lòng Nhập Mật Khẩu";
                      }
                      return null;
                    },
                  ),
                  16.height,
                  TextFormField(
                    controller: confirmPasswordController,
                    focusNode: confirmPasswordNode,
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
                        child: FaIcon(
                            size: 20,
                            showPassword
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            color: primaryColor),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: grey)),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: primaryColor)),
                      labelStyle: secondaryTextStyle(size: 14),
                      labelText: "Xác nhận mật khẩu",
                      errorText:
                          _confirmPasswordInvalid ? _confirmPasswordErr : null,
                    ),
                    validator: (val) {
                      if (val.isEmptyOrNull) {
                        return "Vui lòng nhập mật khẩu";
                      }
                      if (passwordController.text !=
                          confirmPasswordController.text) {
                        return "Mật khẩu không khớp";
                      }
                      return null;
                    },
                  ),
                  50.height,
                  gsAppButton(
                    context,
                    'Tạo Tài Khoản',
                    () {
                      String email = emailController.text;
                      String fullname = fullnameController.text;
                      String username = usernameController.text;
                      String phone = phoneController.text;
                      String password = passwordController.text;
                      validate(email, fullname, username, phone, password);
                    },
                  ),
                ],
              ),
            ),
            16.height,
          ],
        ).paddingAll(16),
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

  Future registerUser(String email, String fullname, String username,
      String phone, String password) async {
    // show dialog đang đăng ký..
    showDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: "Đang đăng ký...",
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    //* http post
    String md5password = md5.convert(utf8.encode(password)).toString();
    // String baseUrl = 'http://localhost:7316/api';
    var uri = Uri.parse('$baseUrl/register');
    var response = await http.post(uri,
        body: (<String, String>{
          'email': email,
          'fullname': fullname,
          'username': username,
          'phone': phone,
          'password': md5password,
        }));
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes));
      if (data['status'] == 'success') {
        loadFlutterToast(data['message']);
        goLoginScreen();
      } else {
        _usernameInvalid = true;
        _usernameErr = data['message'];
        loadFlutterToast(data['message']);
      }
    } else {
      loadFlutterToast("Lỗi API Server");
    }
  }

  void goLoginScreen() => {
        finish(context),
        const GSLoginScreen().launch(context),
      };

  void validate(String email, String fullname, String username, String phone,
      String password) {
    setState(() {
      if (fullname.length < 6) {
        _fullnameInvalid = true;
        _fullnameErr = "Họ tên phải lớn hơn 6 ký tự";
      } else if (fullname.length > 50) {
        _fullnameInvalid = true;
        _fullnameErr = "Họ tên phải nhỏ hơn 50 ký tự";
      } else {
        _fullnameInvalid = false;
      }

      if (username.length < 4) {
        _usernameInvalid = true;
        _usernameErr = 'Tên tài khoản phải lớn hơn 6 ký tự';
      } else if (username.length > 50) {
        _usernameInvalid = true;
        _usernameErr = 'Tên tài khoản phải nhỏ hơn 50 ký tự';
      } else {
        _usernameInvalid = false;
      }

      if (phone.length != 10) {
        _phoneInvalid = true;
        _phoneErr = 'Số điện phải có 11 số';
      } else {
        _phoneInvalid = false;
      }

      if (password.length < 6) {
        _passwordInvalid = true;
        _passwordErr = 'Mật khẩu phải lớn hơn 6 ký tự';
      } else {
        _passwordInvalid = false;
      }

      if (!_usernameInvalid &&
          !_fullnameInvalid &&
          !_phoneInvalid &&
          !_passwordInvalid &&
          formKey.currentState!.validate()) {
        registerUser(email, fullname, username, phone, password);
      }
    });
  }
}
