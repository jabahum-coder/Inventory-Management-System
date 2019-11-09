
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'customer.dart';
import 'medicalsignup.dart';

class MedicalLogin extends StatefulWidget {
  @override
  _MedicalLoginState createState() => _MedicalLoginState();
}

class _MedicalLoginState extends State<MedicalLogin> {

  final _formkey = GlobalKey<FormState>();

  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
   bool loading= false;
  bool isLogedin = false;
  
  @override
  Widget build(BuildContext context) {
  return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.blue,
         centerTitle: true,
         title: Text("Login",style: TextStyle(color: Colors.red.shade900),),
         elevation: 0.1,
       ),
      body: Stack(
        children: <Widget>[
          // Image.asset('images/login.jpg',
          //   fit: BoxFit.cover,
          //   width: double.infinity,
          //   height: double.infinity,  
          // ),
          // Container(
          //   color: Colors.black.withOpacity(0.2),
          //   width: double.infinity,
          //   height: double.infinity,  
          // ),
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 1.0),
              child: Center(
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      //=====================EMAIL FIELD===================
                     Padding(padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                       child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.8),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                            controller: _emailTextController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
                              icon: Icon(Icons.email),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                Pattern pattern =
                                 r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = new RegExp(pattern);
                                if (!regex.hasMatch(value))
                                  return 'Please make sure your email address is valid';
                                else
                                  return null;
                               }
                             },
                           ),
                          ),
                        ), 
                      ),

                      // ==============PASSWORD FIELD ==============================
                    Padding(padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.8),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                             obscureText: true,
                            controller: _passwordTextController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              icon: Icon(Icons.lock_outline),
                            ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "The password field cannot be empty";
                            } 
                            else if (value.length < 6) {
                                return "the password has to be at least 6 characters long";
                              }
                         return null;
                         },
                        ),
                      ),
                    ),
                   ),

                   // =================== LOG IN BUTTON=============================
                   Padding(
                     padding:const EdgeInsets.all(8.0),
                     child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.blue,
                      elevation: 0.0,
                      child: MaterialButton( onPressed: (){},
                                 // onPressed: () async{
                                    //   if(_formKey.currentState.validate()){
                                    //     if(!await user.signIn(_email.text, _password.text))
                                    //   _key.currentState.showSnackBar(SnackBar(content: Text("Sign in failed")));
                                    //    }
                                    
                      minWidth: MediaQuery.of(context).size.width,
                      child: Text("Login",textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),
                        ),
                      )
                    ),
                  ),
                  // =========================================
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Container(
                     color: Colors.white.withOpacity(0.6),
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                        // ===================FORGOT PASSWORD======================
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Forgot password",textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 15.0),
                                ),
                        ),

                          // ===================SIGN UP======================
                       Padding(padding: const EdgeInsets.all(8.0),          
                        child: InkWell(
                         onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MedicalSignup()));
                         },                
                        child: Text("Create an account",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 15.0)),
                        ) 
                       ) 
                      ],
                    ),
                   ),
                 ),                   
                                              
                                
                Expanded(child: Container(),),                    
                  //===============================SIGN IN WITH GOOGLE======================
                  Divider(color: Colors.white,),
                  Text("Other Sign In Options", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),),
                  Padding(
                     padding:const EdgeInsets.all(8.0),
                     child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.red,
                      elevation: 0.0,
                      child: MaterialButton( onPressed: (){
                        //handleSignTn();
                        },
             
                      minWidth: MediaQuery.of(context).size.width,
                      child: Text("Sign In with Google ",textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),
                        ),
                      )
                    ),
                  ),          
                   ],
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: loading ?? true,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.9),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                 )
              ),
            ),
          )
        ],
      )
    );
  }
}