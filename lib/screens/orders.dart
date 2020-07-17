import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/account/auth-bloc.dart';
import 'package:storeFlutter/components/app-button.dart';
import 'package:storeFlutter/models/auth/login-body.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test login"),
      ),
      body: Center(
        child: BlocBuilder<AuthBloc, AuthState>(
            bloc: GetIt.I<AuthBloc>(),
            builder: (context, state) {
              if (state is LoginInProgress) {
                return Text("Login In Progress");
              } else if (state is LoginFailure) {
                return Column(
                  children: <Widget>[
                    Text("Login Failure ${state.error}"),
                    buildSuccessLogin(context),
                    buildFailLogin(context),
                  ],
                );
              } else if (state is LoginSuccess) {
                return Text("Login Success");
              } else if (state is AuthInitial) {
                return Column(
                  children: <Widget>[
                    buildSuccessLogin(context),
                    buildFailLogin(context),
                  ],
                );
              }
              return Container();
            }),
      ),
    );
  }

  AppButton buildFailLogin(BuildContext context) {
    return AppButton("Login (Wrong Password)", () {
      AuthBloc bloc = GetIt.I<AuthBloc>();
      bloc.add(LoginEvent(LoginBody('abc', 'def'), context));
    }, type: AppButtonType.white);
  }

  AppButton buildSuccessLogin(BuildContext context) {
    return AppButton(
      "Login (Correct Password)",
      () {
        AuthBloc bloc = GetIt.I<AuthBloc>();
        bloc.add(LoginEvent(
            LoginBody('smarttradzt.petronas@acceval-intl.com', 'Password@123'),
            context));
      },
      type: AppButtonType.orange,
    );
  }
}
