import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_management_mobile/blocs/app.dart';
import 'package:laundry_management_mobile/theme/theme.dart';
import 'package:laundry_management_mobile/widgets/custom_scaffold.dart';
import 'package:laundry_management_mobile/screens/authentication/signup_screen.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static const routeName = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}


class _SignInScreenState extends State<SignInScreen> {

  bool rememberPassword = false;
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _formSignInKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocListener<AppBloc, AppState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            bool isLoading = state is LoginLoadingState;
            return CustomScaffold (
              child: Column(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: SizedBox(height: 10),
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formSignInKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Se connecter',
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w900,
                                    color: lightColorScheme.primary,
                                  ),
                                ),
                                const SizedBox(height: 40.0),
                                TextFormField(
                                  controller: _username,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez entrer votre e-mail';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    label: const Text('E-mail'),
                                    hintText: 'Entrez votre e-mail',
                                    hintStyle: const TextStyle(color: Colors.black26),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.black12),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.black12),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 25.0),
                                TextFormField(
                                  controller: _password,
                                  obscureText: true,
                                  obscuringCharacter: '*',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez entrer le mot de passe';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    label: const Text('Mot de passe'),
                                    suffixIcon: const Icon(Icons.remove_red_eye),
                                    hintText: 'Entrer le mot de passe',
                                    hintStyle: const TextStyle(color: Colors.black26),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.black12),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.black12),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 25.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: rememberPassword,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              rememberPassword = value!;
                                            });
                                          },
                                          activeColor: lightColorScheme.primary,
                                        ),
                                        const Text(
                                          'Se souvenir de moi',
                                          style: TextStyle(color: Colors.black45),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      child: Text(
                                        'Mot de passe oublié?',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: lightColorScheme.primary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 25.0),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: isLoading
                                    ? null
                                    : () {
                                      if (_formSignInKey.currentState!.validate()) {
                                        if (rememberPassword) {
                                          BlocProvider.of<AppBloc>(context)
                                              .add(LoginRequested(username: _username.text , password: _password.text));
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Veuillez accepter le traitement des données personnelles',
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    child:  isLoading ? const CircularProgressIndicator( color: Colors.white) 
                                             : const Text('Se connecter'),
                                  ),
                                ),
                                const SizedBox(height: 25.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        thickness: 0.7,
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 0,
                                        horizontal: 10,
                                      ),
                                      child: Text(
                                        'Se connecter avec',
                                        style: TextStyle(color: Colors.black45),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        thickness: 0.7,
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 25.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Brand(Brands.facebook_f),
                                    Brand(Brands.google)
                                  ],
                                ),
                                const SizedBox(height: 25.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Je n\'ai pas de compte? ',
                                      style: TextStyle(color: Colors.black45),
                                    ),
                                    const SizedBox(width: 5),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (e) => const SignUpScreen(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'S\'inscrire',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: lightColorScheme.primary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
              )
            );
          },
        ),
      ),
    );
  }
}