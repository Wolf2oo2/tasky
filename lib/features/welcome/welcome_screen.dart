import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/constonts/storage_key.dart';
import 'package:tasky/core/widgets/custom_svg_picture_widget.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/features/navigation/main_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomSvgPictureWidget(path:"assets/images/logo.svg" ,withOutFilter: false,)
                    ,
                    SizedBox(width: 16),
                    Text(
                      "Tasky",

                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                SizedBox(height: 118),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome To Tasky ",
                      style: Theme.of(context).textTheme.displaySmall,

                    ),
                    CustomSvgPictureWidget(path: "assets/images/waving-hand.svg",withOutFilter: false,)
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  "Your productivity journey starts here.",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 16),
                ),
                SizedBox(height: 24),
                SvgPicture.asset(
                  "assets/images/welcome.svg",
                  width: 216,
                  height: 200,
                ),
                SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 16,
                  ),
                  child: Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          controller: controller,
                          title: "Full Name",
                          hintText: "e.g. Wolf Saeed",
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Enter your Name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () async {
                            if (_key.currentState?.validate() ?? false) {
                              await PreferencesManager().setString(
                                StorageKey.username,
                                controller.value.text,
                              );

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainScreen(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Enter your Name"),
                                  backgroundColor: Colors.redAccent,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                              MediaQuery.of(context).size.width,
                              40,
                            ),
                          ),
                          child: Text(
                            "Let’s Get Started",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
