import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
class ReusableField extends StatelessWidget {
   ReusableField({required this.text,required this.onchanged,required this.max}) ;
   final String text;
   late final String onchanged;
   final int max;
  var userVaildator =MultiValidator(
      [
        RequiredValidator(errorText: 'this field is required')
      ]
  );

  @override
  Widget build(BuildContext context) {
    return Form(child: TextFormField(
      validator: RequiredValidator(errorText: 'this field is required'),
      decoration: InputDecoration(
        labelText: text,
        labelStyle:TextStyle(fontSize: 20),
      ),
      maxLines: max,
      onChanged: (val){
        onchanged =val;
      },
    )
    );
  }
}
