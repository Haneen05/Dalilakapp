import 'package:daleelakappx/models/user.dart';
import 'package:daleelakappx/provider.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:flutter/material.dart';
import 'package:daleelakappx/api.dart' as api;

class AdminCard extends StatefulWidget {
  final DUser user;
  final VoidCallback onDeleted;

  const AdminCard({
    super.key,
    required this.user,
    required this.onDeleted,
  });

  @override
  State<AdminCard> createState() => _AdminCardState();
}

class _AdminCardState extends State<AdminCard> {
  @override
  Widget build(BuildContext context) {
    DUser? loggedInUser = DProvider.of(context).user;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: DColumn(
          mainAxisSpacing: 12.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DRow(
              mainAxisSpacing: 14.0,
              children: [
                const Icon(Icons.person_outline),
                Expanded(
                  child: Text(
                    'Admin Info',
                    style: textTheme.titleMedium,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed:
                      widget.user.uid != loggedInUser?.uid ? deleteUser : null,
                ),
              ],
            ),
            Text(
              widget.user.name,
              style: const TextStyle(color: Color(0xff64748b)),
            ),
            const Divider(
              color: Color(0xffe2e8f0),
            ),
            Text(
              widget.user.phoneNumber ?? '',
              style: const TextStyle(color: Color(0xff64748b)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> deleteUser() async {
    bool confirmed = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('DeleteAdmin'),
          content: const Text('AreYouSureYouWantToDeleteThisAdmin?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context, true);
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xffe16060),
              ),
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );

    if (confirmed) {
      await api.users.delete(widget.user.id);
      widget.onDeleted();
    }
  }
}
