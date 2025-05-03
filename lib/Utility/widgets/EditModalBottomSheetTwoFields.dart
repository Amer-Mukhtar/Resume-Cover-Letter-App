import 'package:flutter/material.dart';

class EditItemSheet extends StatelessWidget {
  final String title;
  final String initialValue1;
  final String initialValue2;
  final void Function(String value1, String value2) onSave;

  const EditItemSheet({
    super.key,
    required this.title,
    required this.initialValue1,
    required this.initialValue2,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context)
  {
    final textControllerValue1 = TextEditingController(text: initialValue1);
    final textControllerValue2 = TextEditingController(text: initialValue2);
    final formKey = GlobalKey<FormState>();

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          color: Color(0xFF454545),
        ),
        width: double.infinity,
        child: FractionallySizedBox(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF454545),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        title,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Theme(
                      data: ThemeData.dark(),
                      child: TextFormField(
                        controller: textControllerValue1,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field cannot be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Enter Level',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Theme(
                      data: ThemeData.dark(),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: textControllerValue2,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Level field cannot be empty';
                          }
                          final int? level = int.tryParse(value);
                          if (level == null || level < 0 || level > 100) {
                            return 'Please enter a value between 0 and 100';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            if (int.parse(value) > 100) {
                              textControllerValue2.text = "100";
                            } else if (int.parse(value) < 0) {
                              textControllerValue2.text = "0";
                            }
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false)
                          {
                            onSave(textControllerValue1.text, textControllerValue2.text);
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
