import 'package:auto_route/auto_route.dart';
import 'package:blood_donor_admin/core/components/constants/strings.dart';
import 'package:blood_donor_admin/core/components/widgets/custom_button.dart';
import 'package:blood_donor_admin/core/components/widgets/custom_input.dart';
import 'package:blood_donor_admin/generated/assets.dart';
import 'package:blood_donor_admin/styles/colors.dart';
import 'package:blood_donor_admin/styles/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/routes/routes.dart';
import '../../state/auth_state.dart';

@RoutePage()
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isInvisible = true;
  final emailController = TextEditingController(text: 'admin@bloodbank.com');
  final passwordController=TextEditingController(text: 'Admin@2023');

  @override
  void initState() {
   //check if user is logged in go to home page
    super.initState();
  }

 Future<bool> getLoginStatus()async{
    final user=FirebaseAuth.instance.currentUser;
    if(user!=null){
      if(mounted) {
        AutoRouter.of(context).replace(const HomeRoute());
      }
    }
    return user!=null;
  }
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, size) {
        return FutureBuilder<bool>(
          future: getLoginStatus(),
          builder: (context, snapshot) {
            if(snapshot.hasData && snapshot.data==true){
              return const Center(child: CircularProgressIndicator(),);
            }else if(!snapshot.hasData){
               return const Center(child: CircularProgressIndicator(),);
            }else {
              return Center(
                child: Card(
              elevation: 10,
              color: Colors.white,
              child: Container(
                  color: Colors.white,
                  width: size.maxWidth > 800 && size.maxWidth <= 1100
                      ? size.maxWidth * 0.7
                      : size.maxWidth > 1000
                          ? size.maxWidth * .5
                          : size.maxWidth * .8,
                  child: size.maxWidth > 800
                      ? SizedBox(
                        height: size.maxWidth > 800 && size.maxWidth <= 1100? size.maxHeight * .7:size.maxHeight * .6,
                        child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                color: primaryColor,
                                alignment: Alignment.center,
                                child: Image.asset(
                                  Assets.logosIconWhite,
                                  height: size.maxWidth * .15,
                                ),
                              )),
                              Expanded(child: _buildForm(context, ref, size.maxWidth))
                            ],
                          ),
                      )
                      : _buildForm(context, ref, size.maxWidth)),
            ));
            }
          }
        );
      }),
    );
  }

  Widget _buildForm(BuildContext context, WidgetRef ref, double width) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (width <= 800)
                Image.asset(
                  Assets.logosLogoNormal,
                  height: width * .2,
                ),
              Text(
                'ADMIN LOGIN',
                style:
                    GoogleFonts.poppins(fontSize: width < 800 ? width * .05 : 40),
              ),
              const Divider(
                color: primaryColor,
                thickness: 4,
                indent: 20,
                endIndent: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFields(
                label: 'Admin Email',
                prefixIcon: Icons.email,
                controller: emailController,
                validator: (email) {
                  if (email!.isEmpty || RegExp(emailReg).hasMatch(email) == false) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (email) {
                  ref.read(authStateProvider.notifier).setEmail(email);
                },
              ),
              const SizedBox(
                height: 24,
              ),
              CustomTextFields(
                  label: 'Admin Password',
                  prefixIcon: Icons.password,
                  obscureText: isInvisible,
                  controller: passwordController,
                  validator: (password){
                    if(password!.isEmpty || password.length < 6){
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  onSaved: (password){
                    ref.read(authStateProvider.notifier).setPassword(password);            
                  },
                  suffixIcon: IconButton(
                    icon: Icon(isInvisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined),
                    onPressed: () {
                      setState(() {
                        isInvisible = !isInvisible;
                      });
                    },
                  )),
              const SizedBox(
                height: 24,
              ),
              CustomButton(text: 'Login', onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  ref.read(authStateProvider.notifier).login(context);
                }
              }),
              const SizedBox(
                height: 10,
              ),
              //forgot password
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: normalText(
                        color: primaryColor,
                        fontSize: width < 800 ? width * .03 : 18),
                  )),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
