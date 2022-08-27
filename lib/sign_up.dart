// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery/auth.dart';
import 'package:grocery/home.dart';
import 'package:grocery/profile.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);
  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController emailController = TextEditingController();

  TextEditingController userNameController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool obserText = true;

  bool obscurText = true;

  Auth creator = Auth();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(13),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Text(
                    "GROCERY",
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize: 40,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "MART",
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize: 40,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Text(
                    "Create Account",
                    style: TextStyle(
                        color: Colors.indigo[900],
                        fontSize: 30,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Username",
                              style: TextStyle(
                                  color: Colors.indigo[900],
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              controller: userNameController,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return "Username is required";

                                return null;
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none),
                                  fillColor: Colors.grey[200],
                                  filled: true),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Email",
                              style: TextStyle(
                                  color: Colors.indigo[900],
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              controller: emailController,
                              validator: (value) {
                                if (value!.isEmpty) return "Email is required";
                                String pattern = r'\w+@\w+\.\w+';
                                RegExp regex = RegExp(pattern);
                                if (!regex.hasMatch(value))
                                  return "Please enter a valid email";
                                return null;
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none),
                                  fillColor: Colors.grey[200],
                                  filled: true),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Phone Number",
                              style: TextStyle(
                                  color: Colors.indigo[900],
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              controller: phoneNumberController,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none),
                                  fillColor: Colors.grey[200],
                                  filled: true),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Password',
                              style: TextStyle(
                                  color: Colors.indigo[900],
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty)
                                  return "Password is required";
                                return null;
                              },
                              controller: passwordController,
                              obscureText: obserText,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                fillColor: Colors.grey[200],
                                filled: true,
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        obserText = !obserText;
                                      });
                                    },
                                    child: Icon(
                                      obserText == true
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.teal,
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: isLoading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ElevatedButton(
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        print('Sign up successful');
                                        setState(() {
                                          isLoading = true;
                                        });

                                        await creator
                                            .createUserWithEmailAndPassword(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text)
                                            .then((value) {
                                          creator.addUser(
                                              userName: userNameController.text,
                                              email: emailController.text,
                                              phone: int.parse(
                                                  phoneNumberController.text));

                                          setState(() {
                                            isLoading = false;
                                          });
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return HomeView();
                                            ;
                                          }));
                                        });
                                        print("User created successfully");
                                      }
                                    },
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.teal),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10)))),
                                  ),
                          ),
                          Row(
                            children: [
                              Text(
                                "By clicking Sign up you agree to the",
                                style: TextStyle(color: Colors.indigo[900]),
                              ),
                              Text(
                                "Terms ",
                                style: TextStyle(color: Colors.teal),
                              ),
                              Text(
                                "& ",
                                style: TextStyle(color: Colors.indigo[900]),
                              ),
                              Text(
                                "Privacy Policy",
                                style: TextStyle(color: Colors.teal),
                              )
                            ],
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
