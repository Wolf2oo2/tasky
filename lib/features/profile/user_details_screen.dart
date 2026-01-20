import 'package:flutter/material.dart';
import 'package:tasky/core/constonts/storage_key.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/core/services/preferences_manager.dart';

class UserDetailsScreen extends StatefulWidget {
  UserDetailsScreen({
    required this.userName,
    required this.motivation,
    super.key});
final String userName;
final String motivation;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late final TextEditingController nameController ;

  late final TextEditingController motivationController ;

  final GlobalKey<FormState> _key = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController= TextEditingController(text: widget.userName);
    motivationController= TextEditingController(text: widget.motivation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Details")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _key,
          child: Column(
            children: [
              CustomTextFormField(
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return "Enter your new Name ";
                  }
                  return null;
                },
                controller: nameController,
                title: "User Name",
                hintText: "Usama Elgendy",
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return "Enter your Motivation Quotee ";
                  }
                  return null;
                },
                controller: motivationController,
                title: "Motivation Quote",
                hintText: "One task at a time. One step closer.",
                maxLines: 5,
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () async {
                  if (_key.currentState?.validate() ?? false) {
                    await PreferencesManager().setString(
                     StorageKey.motivation,
                      motivationController.text,
                    );
                    await PreferencesManager().setString(StorageKey.username, nameController.text);
                    Navigator.of(context).pop(true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                ),
                child: Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
