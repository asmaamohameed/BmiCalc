import 'package:flutter/material.dart';

Widget defaultFormField ({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  required Function validate,
  required String label,
  required IconData prefix,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  onFieldSubmitted: (value){
    onSubmit!();
  },
  onChanged:(value) {
    onChange!();
  },
  validator: (value){
    validate(value);
  },
  decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(
        prefix,
      ),
      border: OutlineInputBorder()
  ),
);

