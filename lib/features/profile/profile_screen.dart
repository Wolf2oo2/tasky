import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/features/profile/user_details_screen.dart';
import 'package:tasky/features/welcome/welcome_screen.dart';
import 'package:tasky/core/widgets/custom_svg_picture_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userName;
  String? motivation;
  String? userImage;
  bool isLoad = true;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  _loadUserName() async {
    setState(() {
      userName = PreferencesManager().getString("username") ?? "";
      userImage = PreferencesManager().getString("userImage") ;
      motivation =
          PreferencesManager().getString("motivation") ??
          "One task at a time. One step closer.";
      isLoad = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoad
        ? Center(child: CircularProgressIndicator())
        : Padding(
          padding: EdgeInsetsDirectional.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.all(4),
                child: Text(
                  "My Profile",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              userImage == null
                                  ? AssetImage('assets/images/person.png')
                                  : FileImage(File(userImage!)),
                          radius: 60,
                        ),
                        GestureDetector(
                          onTap: () async {
                            _showImageSourceDialog(context,(XFile file){
                              _saveImage(file);
                              setState(() {
                                userImage=file.path;

                              });
                            });

                          },
                          child: Container(
                            height: 34,
                            width: 34,
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Icon(Icons.camera_alt_outlined, size: 22),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      userName!,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Text(
                      motivation!,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
              Text(
                "Profile Info",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              ListTile(
                onTap: () async {
                  final bool? res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => UserDetailsScreen(
                            userName: userName!,
                            motivation: motivation!,
                          ),
                    ),
                  );
                  if (res != null && res) {
                    _loadUserName();
                  }
                },
                title: Text("User Details"),
                iconColor: Color(0xffFFFCFC),
                leading: CustomSvgPictureWidget(
                  path: "assets/images/profile.svg",
                ),
                trailing: CustomSvgPictureWidget(
                  path: "assets/images/arrow.svg",
                ),

                contentPadding: EdgeInsetsDirectional.zero,
              ),
              Divider(),
              ListTile(
                title: Text("Dark Mode"),
                iconColor: Color(0xffFFFCFC),
                leading: CustomSvgPictureWidget(path: "assets/images/moon.svg"),

                trailing: ValueListenableBuilder(
                  valueListenable: ThemeController.themeNotifier,
                  builder: (BuildContext context, value, Widget? child) {
                    return Switch(
                      value: value == ThemeMode.dark,
                      onChanged: (bool val) async {
                        ThemeController.toggleTheme();
                      },
                    );
                  },
                ),
                contentPadding: EdgeInsetsDirectional.zero,
              ),
              Divider(),

              ListTile(
                onTap: () async {
                  PreferencesManager().remove("tasks");
                  PreferencesManager().remove("username");
                  PreferencesManager().remove("motivation");
                  PreferencesManager().remove("userImage");
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => WelcomeScreen(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                title: Text("Log Out"),
                iconColor: Color(0xffFFFCFC),
                leading: CustomSvgPictureWidget(
                  path: "assets/images/logout.svg",
                ),

                trailing: CustomSvgPictureWidget(
                  path: "assets/images/arrow.svg",
                ),
                contentPadding: EdgeInsetsDirectional.zero,
              ),
            ],
          ),
        );
  }

  _showImageSourceDialog(BuildContext context,Function(XFile) selectedFile) {
    showDialog(
      context: context,
      builder:
          (context) => SimpleDialog(
            title: Text("Chose Image Source",style: Theme.of(context).textTheme.titleMedium,),
            children: [
              SimpleDialogOption(

                padding: EdgeInsets.all(16),
                onPressed: () async{
                  Navigator.pop(context);

                  XFile? image = await ImagePicker().pickImage(
                    source: ImageSource.camera,
                  );
                  if (image != null) {
                    selectedFile(image);
                    // setState(() {
                    //   _selectedImge = File(image.path);
                    // });
                  }
                },
                child: Row(
                  children: [Icon(Icons.camera_alt_outlined), Text("camera")],
                ),
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(16),
                onPressed: () async{
                  Navigator.pop(context);
                  XFile? image = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                  );
                  if (image != null) {
                    selectedFile(image);

                    // setState(() {
                    //   _selectedImge = File(image.path);
                    // });
                  }
                },

                child: Row(children: [Icon(Icons.image), Text("Gallery")]),
              ),
            ],
          ),
    );
  }

   _saveImage(XFile file) async{
    final appDir=await getApplicationDocumentsDirectory();
    final newFile=await File(file.path).copy("${appDir.path}/${file.name}");
    PreferencesManager().setString('userImage', newFile.path);
   }
}
