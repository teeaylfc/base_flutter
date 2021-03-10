import 'package:connectivity/connectivity.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oev_timesheet/src/blocs/application_bloc.dart';
import 'package:oev_timesheet/src/blocs/bloc_provider.dart';
import 'package:oev_timesheet/src/common/constants/constants.dart';
import 'package:oev_timesheet/src/common/flutter_screenutil.dart';
import 'package:oev_timesheet/src/common/http_client.dart';
import 'package:oev_timesheet/src/models/bloc_delegate.dart';
import 'package:oev_timesheet/src/models/user_modal.dart';
import 'package:oev_timesheet/src/service/auth_service.dart';
import 'package:oev_timesheet/src/service/data_service.dart';
import 'package:oev_timesheet/src/style/color.dart';
import 'package:oev_timesheet/src/widgets/button_base.dart';
import 'package:oev_timesheet/src/widgets/reusable.dart';

class SignInPage extends StatefulWidget {
  SignInPage() {}

  @override
  State<StatefulWidget> createState() {
    return _SignInPageState();
  }
}

class _SignInPageState extends State<SignInPage> implements BlocDelegate<User> {
  ApplicationBloc applicationBloc;
  AuthService authService = AuthService();
  DataService dataService = DataService();
  bool keepLogin = false;
  bool loading = false;
  bool enableShowPass = true;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _merchantIdController = TextEditingController(text: "");

  bool _obscureText = true;
  TextEditingController _passwordController = TextEditingController(text: "");

  bool _autoValidate = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _storage = new FlutterSecureStorage();

  @override
  error(HttpError error) {
    setState(() {
      loading = false;
    });
    Reusable.showTotastError(error.message);
  }

  @override
  void initState() {
    applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    checkKeepUser();
    super.initState();
  }

  @override
  success(user) async {
    setState(() {
      loading = false;
    });
    BlocProvider.of<ApplicationBloc>(context).changeCurrentUser(user);
    BlocProvider.of<ApplicationBloc>(context).changeAuthenticationStatus(true);

    return null;
  }

  checkKeepUser() async {
    String keepUserID = await _storage.read(key: Config.KEEP_USERID);
    String keepPass = await _storage.read(key: Config.KEEP_PASSWORD);
    if (keepUserID != null && keepPass != null) {
      _merchantIdController = TextEditingController(text: keepUserID);
      _passwordController = TextEditingController(text: keepPass);
      setState(() {
        keepLogin = true;
        enableShowPass = false;
      });
    } else {
      setState(() {
        enableShowPass = true;
      });
    }
  }

  _changeStatusKeepLogin() {
    setState(() {
      keepLogin = !keepLogin;
    });
  }

  Widget _showUserIdInput() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        ScreenUtil().setSp(27),
        ScreenUtil().setSp(25),
        ScreenUtil().setSp(40),
        ScreenUtil().setSp(0),
      ),
      child: Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: <Widget>[
          TextFormField(
            controller: _merchantIdController,
            maxLines: 1,
            keyboardType: TextInputType.text,
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
            ],
            autofocus: false,
            style: new TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(16),
            ),
            decoration: InputDecoration(
              labelText: FlutterI18n.translate(context, 'loginPage.id'),
              labelStyle: TextStyle(
                fontSize: ScreenUtil().setSp(14),
                color: Color(0xffe7e7e7),
                fontWeight: FontWeight.w500,
              ),
              contentPadding: EdgeInsets.fromLTRB(0, 15, 0, 5),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffa9a9a9)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
            validator: (value) => value.isEmpty
                ? FlutterI18n.translate(context, 'loginPage.phoneEmpty')
                : null,
            onSaved: (value) => {},
          ),
          Padding(
            padding: EdgeInsets.only(right: ScreenUtil().setSp(14)),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _merchantIdController.text = '';
                });
              },
              child: Container(),
            ),
          )
        ],
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        ScreenUtil().setSp(27),
        ScreenUtil().setSp(27),
        ScreenUtil().setSp(40),
        ScreenUtil().setSp(0),
      ),
      child: TextFormField(
        controller: _passwordController,
        maxLines: 1,
        obscureText: _obscureText,
        autofocus: false,
        style: new TextStyle(
          color: Colors.white,
          fontSize: ScreenUtil().setSp(16),
        ),
        decoration: InputDecoration(
          suffixIcon: enableShowPass
              ? GestureDetector(
                  dragStartBehavior: DragStartBehavior.down,
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    semanticLabel:
                        _obscureText ? 'show password' : 'hide password',
                    color: Colors.white,
                    size: 15,
                  ),
                )
              : null,
          labelText: "PIN",
          labelStyle: TextStyle(
            fontSize: ScreenUtil().setSp(14),
            color: Color(0xffe7e7e7),
            fontWeight: FontWeight.w500,
          ),
          contentPadding: EdgeInsets.fromLTRB(0, 15, 0, 5),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffa9a9a9),
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        validator: (value) => value.isEmpty
            ? FlutterI18n.translate(context, 'loginPage.passEmpty')
            : null,
        onSaved: (value) => {},
        onChanged: (value) => onChangePass(value),
      ),
    );
  }

  onChangePass(String value) {
    if (value.length == 0) {
      setState(() {
        enableShowPass = true;
      });
    }
  }

  _buildSignupButton(context) {
    return ButtonBase(
      title: FlutterI18n.translate(context, 'loginPage.login'),
      onTap: _validateInputs,
      loading: loading,
      height: ScreenUtil().setSp(40),
      borderRadius: ScreenUtil().setSp(100),
      gradient: CommonColor.commonButtonColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Container(
                width: width,
                height: height,
                decoration:
                    BoxDecoration(gradient: CommonColor.commonButtonColor),
              ),
              Positioned(
                bottom: 0,
                child: Image.asset(
                  "assets/images/merchant/back_sign_in.png",
                  width: width,
                  fit: BoxFit.contain,
                ),
              ),
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  autovalidate: _autoValidate,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: ScreenUtil().setHeight(80)),
                      Container(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          "assets/images/merchant/logo_merchant.svg",
                          width: ScreenUtil().setSp(100),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: ScreenUtil().setSp(26),
                          top: ScreenUtil().setSp(25),
                        ),
                        child: Text(
                          FlutterI18n.translate(context, 'loginPage.please'),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(24),
                          ),
                        ),
                      ),
                      _showUserIdInput(),
                      _showPasswordInput(),
                      GestureDetector(
                        onTap: _changeStatusKeepLogin,
                        child: Container(
                          padding: EdgeInsets.only(
                              left: ScreenUtil().setSp(21),
                              right: ScreenUtil().setSp(26),
                              top: ScreenUtil().setSp(35)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                color: Colors.transparent,
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setSp(5)),
                                child: Icon(
                                    keepLogin == false
                                        ? Icons.check_box_outline_blank
                                        : Icons.check_box,
                                    color: Colors.white,
                                    size: ScreenUtil().setSp(18)),
                              ),
                              Text(
                                FlutterI18n.translate(
                                    context, 'loginPage.keep'),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenUtil().setSp(13)),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(
                            ScreenUtil().setSp(27),
                            ScreenUtil().setSp(30),
                            ScreenUtil().setSp(40),
                            ScreenUtil().setSp(15),
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: _buildSignupButton(context),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String validateUserId(String value) {
    if (value.length == 0)
      return 'User ID can not empty';
    else
      return null;
  }

  void _validateInputs() async {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      // _formKey.currentState.save();
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      if (!loading) {
        setState(() {
          loading = true;
        });
        if (keepLogin == false) {
          _storage.delete(key: Config.KEEP_USERID);
          _storage.delete(key: Config.KEEP_PASSWORD);
        }
        await authService
            .login(_merchantIdController.text, _passwordController.text)
            .then((data) async {
          setState(() {
            loading = false;
          });
          if (keepLogin == true) {
            await _storage.write(
                key: Config.KEEP_USERID, value: _merchantIdController.text);
            await _storage.write(
                key: Config.KEEP_PASSWORD, value: _passwordController.text);
          }
        }).catchError((error) {
          setState(() {
            loading = false;
          });
          Reusable.showMessageDialog(false, error.message, context);
        });
      }
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
