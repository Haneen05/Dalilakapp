import 'package:daleelakappx/models.dart';
import 'package:daleelakappx/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:daleelakappx/api.dart' as api;

class AppProvider extends StatefulWidget {
  final Widget child;

  const AppProvider({super.key, required this.child});

  @override
  State<AppProvider> createState() => _AppProviderState();
}

class _AppProviderState extends State<AppProvider> {
  int pageIndex = 0;
  DUser? user;

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? firebaseUser) async {
      DUser? resolvedUser = await resolveOrCreateUser(firebaseUser);
      setState(() => user = resolvedUser);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DProvider(
      pageIndex: pageIndex,
      user: user,
      setPageIndex: (page) {
        setState(() => pageIndex = page);
      },
      refetchUser: () async {
        DUser? resolvedUser =
            await resolveOrCreateUser(FirebaseAuth.instance.currentUser);
        if (mounted) {
          setState(() => user = resolvedUser);
        }
      },
      child: widget.child,
    );
  }

  /// creates a user with a default user role and saves it to firestore
  Future<DUser?> resolveOrCreateUser(User? firebaseUser) async {
    DUser? resolvedUser;
    if (firebaseUser != null) {
      final phoneNumber = firebaseUser.phoneNumber;
      DUser? existing;
      if (phoneNumber != null) {
        existing = await api.users.findByPhoneNumber(phoneNumber);
        if (existing != null) {
          // add user uid
          await api.users.update(
            existing.id,
            DUserInput(
              uid: firebaseUser.uid,
              name: existing.name,
              phoneNumber: existing.phoneNumber,
              gender: existing.gender,
              role: existing.role,
            ),
          );
        }
      } else {
        existing = await api.users.findByUid(firebaseUser.uid);
      }

      if (existing == null) {
        resolvedUser = await api.users.add(
          DUserInput(
            uid: firebaseUser.uid,
            name: "",
            phoneNumber: firebaseUser.phoneNumber,
            gender: null,
            role: Role.user,
          ),
        );
      } else {
        resolvedUser = existing;
      }
    }
    return resolvedUser;
  }
}
