import 'dart:async';

import 'package:daleelakappx/models.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:daleelakappx/api.dart' as api;

import 'admin_card.dart';

class AdminSettingsScreen extends StatefulWidget {
  const AdminSettingsScreen({super.key});

  @override
  State<AdminSettingsScreen> createState() => _AdminSettingsScreenState();
}

class _AdminSettingsScreenState extends State<AdminSettingsScreen> {
  late Stream<List<DUser>> admins;

  @override
  void initState() {
    super.initState();
    admins = _streamAdmins();
  }

  Stream<List<DUser>> _streamAdmins() {
    return api.users.streamMany(role: 'admin');
  }

  Future<void> refresh() async {
    setState(() {
      admins = _streamAdmins();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: const Color(0xffe9e9e9),
        ),
        RefreshIndicator(
          onRefresh: refresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: DColumn(
              mainAxisSpacing: 29.0,
              children: [
                Material(
                  color: Colors.white,
                  elevation: 1.0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(12.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 62.0, 20.0, 30.0),
                    child: DRow(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dalilak\nAccount',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        DButton.text(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                          },
                          child: DRow(
                            mainAxisSpacing: 11.0,
                            children: [
                              Text(
                                'Logout',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const Icon(Icons.logout,
                                  color: Color(0xff292929)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                StreamBuilder<List<DUser>>(
                  stream: admins,
                  initialData: DUser.dummyData(),
                  builder: (context, snapshot) {
                    return Skeletonizer(
                      enabled:
                          snapshot.connectionState != ConnectionState.active,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: snapshot.data!.map((user) {
                            return AdminCard(
                              user: user,
                              onDeleted: () => setState(() {
                                admins = _streamAdmins();
                              }),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
                DButton.outlined(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/dashboard/admin/create');
                  },
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  child: const Text(
                    'Add another Admin',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
