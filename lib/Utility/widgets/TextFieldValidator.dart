import 'package:flutter/material.dart';

class CustomTextFieldValidate extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String hintText;
  final Function(String) onChanged;
  final EdgeInsets margin;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final List? inputFormatter;
  final bool? enable;


  const CustomTextFieldValidate({
    super.key,
    required this.labelText,
    required this.controller,
    required this.hintText,
    this.enable,
    required this.onChanged,
    this.margin = const EdgeInsets.only(left: 5, right: 0, top: 0),
    required this.keyboardType,
    this.validator, this.inputFormatter, // Add validator parameter
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: margin,
          child: Text(
            labelText,
            style: const TextStyle(
              color: Colors.white, // Replace with your 'text' color variable
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 5,),
        Theme(

          data: ThemeData.dark(),
          child: SizedBox(
            width: double.infinity,
            child: TextFormField(

              enabled: enable,
              controller: controller,
              onChanged: onChanged,
              keyboardType: keyboardType,
              validator: validator,

              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder( borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(10), ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.redAccent),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: hintText,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: const OutlineInputBorder(),
              ),
              cursorColor: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
