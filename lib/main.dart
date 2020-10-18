import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saludsingapore/providers/app_provider.dart';
import 'package:saludsingapore/screens/join.dart';
import 'package:saludsingapore/screens/login.dart';
import 'package:saludsingapore/screens/main_screen.dart';
import 'package:saludsingapore/screens/splash.dart';
import 'package:saludsingapore/util/const.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stripe_sdk/stripe_sdk.dart';
import 'package:stripe_sdk/stripe_sdk_ui.dart';

import 'helpers/export_helper.dart';
import 'models/export_models.dart';
import 'payment/exportPayment.dart';
import 'util/const.dart';

const _stripePublishableKey =
    'pk_test_51H6mH9ID8MNBX0WyY9ez3h9SRhRmzbkgvvouePSwRt2iA711XXD2HyWA4hSuXJMRLJ68XGcbM5LbepWklDrCq0y200IAnkBIAT';
const _returnUrl = "stripesdk://com.saludsingapore";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Provider.debugCheckInvalidValueType = null;
  runApp(
    MultiProvider(
      providers: [
        StreamProvider<User>(
          // ignore: deprecated_member_use
          create: (_) => FirebaseAuth.instance.onAuthStateChanged,
        ),
        ProxyProvider<User, Stream<AppUser>>(update: (_, user, __) {
          return userData(user?.uid);
        }),
        ProxyProvider<User, CollectionReference>(
          update: (_, user, __) => cartCollection(user.uid),
        ),
        StreamProvider<List<Products>>(
          create: (_) => products(),
          initialData: [],
        ),
        Provider<ProductCollection>(create: (_) => ProductCollection()),
        StreamProvider<List<Categories>>(
          create: (_) => categories(),
          initialData: [],
        ),
        Provider<OrderCollection>(create: (_) => OrderCollection()),
        StreamProvider<List<Orders>>(
          create: (_) => order(),
          initialData: [],
        ),
        Provider<CategoriesCollection>(create: (_) => CategoriesCollection()),
        ChangeNotifierProvider(
          create: (_) => PaymentMethodStore(),
        ),
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: RestartWidget(
        child: MyApp(
          model: AppUser(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppUser model;

  const MyApp({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Stripe.init(_stripePublishableKey, returnUrlForSca: _returnUrl);

    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider appProvider, Widget child) {
        return ScopedModel<AppUser>(
          model: model,
          child: MaterialApp(
            key: appProvider.key,
            debugShowCheckedModeBanner: false,
            navigatorKey: appProvider.navigatorKey,
            title: Constants.appName,
            theme: appProvider.theme,
            darkTheme: Constants.darkTheme,
            home: AuthWidgets(),
          ),
        );
      },
    );
  }
}

class AuthWidgets extends StatelessWidget {
  const AuthWidgets({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isUserLoggedIn = Provider.of<User>(context) != null;

    if (isUserLoggedIn) {



      return MainScreen();
    } else {
      return LoginScreen();
    }
  }
}