import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_management_mobile/blocs/app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_management_mobile/controllers/api_controller.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isLoading = false;
  late ApiController apiController;
  
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  @override
  void initState() {
    super.initState();
    apiController = ApiController();
  }

  void updateProfil(obj) {
    setState(() => isLoading = true);
    apiController.postData('change/password', obj).then((data) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content:  Text("Account successfully updated")),
      );
      BlocProvider.of<AppBloc>(context).add(LoggedOut());
    }).catchError((error) {
      setState(() => isLoading = false);
      debugPrint("Erreur lors de la récupération des données : ${error.toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Profil',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(
                labelText: 'First name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10.h),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10.h),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10.h),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 8.w, right: 8.w),
                  child: const CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.green,
                  ),
                ),
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            SizedBox(height: 10.h),
            TextField(
              controller: dobController,
              decoration: const InputDecoration(
                labelText: 'Date of Birth',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  dobController.text = "${pickedDate.toLocal()}".split(' ')[0];
                }
              },
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading
                  ? null
                  : () {
                    if (firstNameController.text.isEmpty || 
                        lastNameController.text.isEmpty ||
                        emailController.text.isEmpty || 
                        phoneController.text.isEmpty || 
                        dobController.text.isEmpty ) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Veuillez remplir tous les champs")),
                      );
                      return; // Exit if any field is empty
                    }

                    updateProfil({
                      'email': emailController.text,
                      'first_name': firstNameController.text,
                      'last_name': lastNameController.text,
                      'phone': phoneController.text,
                      'date_of_birth': dobController.text,
                    });
                  },
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Mettre a jour'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
