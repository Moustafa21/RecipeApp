import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _auth = FirebaseAuth.instance;
  late String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff174354),
        title: Text(
          "اعادة تعيين كلمة المرور",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: [
            SizedBox(
              height: 40,
            ),
            Form(
              child: Padding(
                padding: EdgeInsets.all(25),
                child: TextFormField(
                  validator: MultiValidator([
                    EmailValidator(errorText: 'البريد الالكتروني غير صالح'),
                    RequiredValidator(errorText: 'البريد الالكتروني مطلوب'),
                  ]),
                  onChanged: (val) {
                    email = val;
                  },
                  decoration: const InputDecoration(
                    hintText: "البريد الالكتروني",
                    labelText: "البريد الالكتروني",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonTheme(
                  height: 50,
                  minWidth: 80,
                  child: FlatButton(
                      color: Colors.teal[600],
                      padding: EdgeInsets.symmetric(horizontal: 90),
                      onPressed: () {
                        _auth.sendPasswordResetEmail(email: email).then((value) => Scaffold.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'تم تحديث البريد الالكتروني بنجاح'))));
                        Navigator.of(context).pop();
                      },
                      child: Text('ارسل الطلب',
                          style: TextStyle(color: Colors.white, fontSize: 20))),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}