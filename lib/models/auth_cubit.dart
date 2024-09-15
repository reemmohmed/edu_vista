import 'package:edu_vista/MainScreenStatepages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(super.initialState);

  Future<void> login({
    required BuildContext context,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    try {
      var credentials = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (credentials.user != null) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login Successful')),
        );
        Navigator.pushReplacementNamed(context, HomePage.id);
      }
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      _handleFirebaseAuthError(context, e);
    }
  }

  void _handleFirebaseAuthError(BuildContext context, FirebaseAuthException e) {
    if (e.code == 'user-not-found') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No user found for that email.')),
      );
    } else if (e.code == 'wrong-password') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Wrong password provided for that user.')),
      );
    }
  }
}
