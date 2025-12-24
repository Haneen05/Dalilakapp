import 'package:daleelakappx/models.dart';
import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:flutter/material.dart';
import 'package:daleelakappx/api.dart' as api;

class CreateAdminForm extends StatefulWidget {
  const CreateAdminForm({
    super.key,
  });

  @override
  State<CreateAdminForm> createState() => _CreateAdminFormState();
}

class _CreateAdminFormState extends State<CreateAdminForm> {
  final input = CreateUserInput();
  final errors = CreateUserErrors();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(DBox.xlSpace),
        child: DColumn(
          mainAxisSpacing: 29.0,
          children: [
            DRow(
              mainAxisSpacing: 14.0,
              children: [
                const Icon(Icons.person_outline),
                Text(
                  'Admin Info',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            DColumn(
              mainAxisSpacing: 10.0,
              children: [
                LabelField(
                  label: const Text('AdminName'),
                  input: TextField(
                    controller: input.name,
                    decoration: const InputDecoration(
                      hintText: 'EnterAdminName',
                    ),
                  ),
                ),
                LabelField(
                  label: const Text('PhoneNumber'),
                  input: TextField(
                    controller: input.phoneNumber,
                    decoration: const InputDecoration(hintText: '+961'),
                  ),
                ),
              ],
            ),
            DRow(
              mainAxisSpacing: 15.0,
              children: [
                DButton.outlined(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  foregroundColor: const Color(0xff94a3b8),
                  borderColor: const Color(0xffd4dae1),
                  child: const Text('Cancel'),
                ),
                Expanded(
                  child: DButton.primaryFilled(
                    onPressed: createAdmin,
                    label: const Text('CreateAdmin'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void createAdmin() async {
    if (!validate()) {
      return;
    }

    var userInput = DUserInput(
      uid: null,
      name: input.name.text.trim(),
      phoneNumber: input.phoneNumber.text.trim(),
      gender: null,
      role: Role.admin,
    );

    await api.users.add(userInput);

    if (mounted) {
      Navigator.pop(context);
    }
  }

  bool validate() {
    bool valid = true;
    if (input.name.text.trim().isEmpty) {
      setState(() => errors.name = 'Required');
      valid = false;
    }

    final RegExp phoneRegExp = RegExp(r'^\+\d{1,3}\d{4,14}$');
    if (input.phoneNumber.text.trim().isEmpty) {
      setState(() => errors.phoneNumber = 'Required');
      valid = false;
    } else if (!phoneRegExp.hasMatch(input.phoneNumber.text.trim())) {
      setState(() => errors.phoneNumber = 'Please enter a valid phone number');
      valid = false;
    }

    return valid;
  }
}

class CreateUserErrors {
  String? name;
  String? phoneNumber;
}

class CreateUserInput {
  var name = TextEditingController();
  var phoneNumber = TextEditingController();
}
