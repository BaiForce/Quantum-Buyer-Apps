import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quantum_buyer_app/bloc/banners/banners_bloc.dart';
import 'package:quantum_buyer_app/bloc/categories/categories_bloc.dart';
import 'package:quantum_buyer_app/bloc/checkout/checkout_bloc.dart';
import 'package:quantum_buyer_app/bloc/logout/logout_bloc.dart';
import 'package:quantum_buyer_app/bloc/order/order_bloc.dart';
import 'package:quantum_buyer_app/bloc/products/products_bloc.dart';
import 'package:quantum_buyer_app/data/datasources/auth_local_datasource.dart';
import 'package:quantum_buyer_app/pages/auth/auth_page.dart';
import 'package:quantum_buyer_app/pages/dashboard/dashboard_page.dart';
import 'package:quantum_buyer_app/utils/light_themes.dart';
import 'bloc/login/login_bloc.dart';
import 'bloc/register/register_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(),
        ),
        BlocProvider(
          create: (context) => ProductsBloc(),
        ),
        BlocProvider(
          create: (context) => CategoriesBloc(),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(),
        ),
        BlocProvider(
          create: (context) => OrderBloc(),
        ),
        BlocProvider(
          create: (context) => BannersBloc(),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: light,
          home: FutureBuilder<bool>(
            future: AuthLocalDatasource().isLogin(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasData && snapshot.data!) {
                return const DashboardPage();
              } else {
                return const AuthPage();
              }
            },
          )),
    );
  }
}
