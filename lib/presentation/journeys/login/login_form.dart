import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/common/constants/route_constants.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/constants/translation_constants.dart';
import 'package:movieapp/common/extensions/size_extensions.dart';
import 'package:movieapp/common/extensions/string_extensions.dart';
import 'package:movieapp/presentation/blocs/login/login_cubit.dart';
import 'package:movieapp/presentation/widgets/button.dart';
import 'package:movieapp/presentation/themes/theme_text.dart';
import 'label_field_widget.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _userNameController, _passwordController;
  bool enableSignIn = false;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();

    _userNameController.addListener(() {
      setState(() {
        enableSignIn = _userNameController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty;
      });
    });
    _passwordController.addListener(() {
      setState(() {
        enableSignIn = _userNameController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _userNameController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Sizes.dimen_32.w, vertical: Sizes.dimen_24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: Sizes.dimen_8.h),
              child: Text(
                  TranslationConstants.loginToMovieApp.translate(context),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5),
            ),
            LabelFieldWidget(
              label: TranslationConstants.username.translate(context),
              hintText:
                  TranslationConstants.enterTMDbUsername.translate(context),
              controller: _userNameController,
              key: const ValueKey('username_text_field_key'),
            ),
            LabelFieldWidget(
                label: TranslationConstants.password.translate(context),
                hintText: TranslationConstants.enterPassword.translate(context),
                controller: _passwordController,
                key: const ValueKey('password_text_field_key'),
                isPassword: true),
            BlocConsumer<LoginCubit, LoginState>(
                buildWhen: (previous, current) => current is LoginError,
                builder: (context, state) {
                  if (state is LoginError)
                    return Text(state.message.translate(context),
                        style: Theme.of(context).textTheme.orangeSubtitle1);
                  return const SizedBox.shrink();
                },
                listenWhen: (previous, current) => current is LoginSuccess,
                listener: (context, state) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      RouteList.home, (route) => false);
                }),
            Button(
                text: TranslationConstants.signIn,
                onPressed: enableSignIn
                    ? () {
                        BlocProvider.of<LoginCubit>(context).initiateLogin(
                            _userNameController.text, _passwordController.text);
                      }
                    : null,
                isEnabled: enableSignIn),
          ],
        ),
      ),
    );
  }
}
