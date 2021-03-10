import 'package:oev_timesheet/src/blocs/application_bloc.dart';
import 'package:oev_timesheet/src/blocs/bloc_provider.dart';
import 'package:oev_timesheet/src/common/constants/constants.dart';
import 'package:oev_timesheet/src/common/flutter_screenutil.dart';
import 'package:oev_timesheet/src/page/sign_in.dart';
import 'package:oev_timesheet/src/style/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oev_timesheet/src/blocs/bloc_provider.dart';
import 'package:oev_timesheet/src/common/constants/constants.dart';
import 'package:oev_timesheet/src/style/color.dart';
import 'package:splashscreen/splashscreen.dart';

// final OneSignal oneSignal = OneSignal.shared.init("dd14834c-6eff-48fd-a77c-2914f5168a82",
//     iOSSettings: {OSiOSSettings.autoPrompt: false, OSiOSSettings.promptBeforeOpeningPushUrl: true}) as prefix0.OneSignal;

void main() async {
  runApp(
    BlocProvider(
      child: MaterialApp(
        localizationsDelegates: [
          FlutterI18nDelegate(
              useCountryCode: false,
              fallbackFile: 'en',
              path: LanguageSetting.LANGUAGE_PATH),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],

        theme: ThemeData(primaryColor: Colors.orange, fontFamily: "Roboto"),
        // home: DistributorPage(),
        home: SplashPage(),
        navigatorKey: globals,
      ),
      bloc: ApplicationBloc(),
    ),
  );
}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with WidgetsBindingObserver {
  bool pushScreen = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    ApplicationBloc applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    applicationBloc.getCurrentUser();
    applicationBloc.getCurrentLanguage();
    ScreenUtil.instance =
        ScreenUtil(width: 375, height: 667, allowFontScaling: true)
          ..init(context);
    var currentLanguage = applicationBloc.currentLanguageValue.value;
    if (currentLanguage == null) {
      currentLanguage = LanguageSetting.LANGUAGE_EN;
    }
    FlutterI18n.refresh(context, Locale(currentLanguage));
    return SplashScreen(
        seconds: 1,
        navigateAfterSeconds: SignInPage(),
        image: Image(
            fit: BoxFit.cover, image: AssetImage('assets/images/logo.png')),
        imageBackground: AssetImage("assets/images/redeem_success_bg.png"),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.red);
  }
}
