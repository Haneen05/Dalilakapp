import 'dart:async';

import 'package:daleelakappx/models.dart';
import 'package:daleelakappx/provider.dart';
import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:flutter/material.dart';
import 'package:daleelakappx/api.dart' as api;
import 'package:skeletonizer/skeletonizer.dart';

class Header extends StatefulWidget {
  final Storefront storefront;

  const Header({
    super.key,
    required this.storefront,
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  var bookmarked = Completer<bool>().future;
  DUser? user;

  @override
  void didChangeDependencies() {
    final user = this.user = DProvider.of(context).user;
    if (user != null) {
      bookmarked = api.users.isSaved(user.id, widget.storefront.id);
    } else {
      bookmarked = Future.value(false);
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final image = widget.storefront.image;
    final user = this.user;

    return Card(
      color: const Color(0xfff9da42),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: DBox.mdSpace),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            Container(
              width: 75.0,
              height: 75.0,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceDim,
                borderRadius: const BorderRadius.all(
                  Radius.circular(DBox.borderRadiusMd),
                ),
              ),
              child: image != null
                  ? Image.network(
                      image.url,
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: DBox.lgSpace),
                child: DColumn(
                  mainAxisSpacing: DBox.smSpace,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.storefront.name,
                      style: const TextStyle(
                        fontSize: DBox.fontLg,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    FutureBuilder(
                      future: widget.storefront.subcategory,
                      initialData: null,
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.data?.name ?? '',
                          style: const TextStyle(
                            fontSize: DBox.fontSm,
                          ),
                        );
                      },
                    ),
                    const DBox.verticalSpaceLg(),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                // IconButton(
                //   onPressed: () {},
                //   icon: const Icon(Icons.share_outlined),
                // ),
                if (user != null)
                  FutureBuilder(
                    future: bookmarked,
                    initialData: false,
                    builder: (context, snapshot) {
                      final checked = snapshot.data!;
                      return Skeletonizer(
                        enabled:
                            snapshot.connectionState != ConnectionState.done,
                        child: IconButton(
                          onPressed: () async {
                            setState(() {
                              bookmarked = Completer<bool>().future;
                            });
                            if (checked) {
                              await api.users.removeSavedStorefront(
                                  user.id, widget.storefront.id);
                              setState(() {
                                bookmarked = Future.value(false);
                              });
                            } else {
                              await api.users.saveStorefront(
                                  user.id, widget.storefront.id);
                              setState(() {
                                bookmarked = Future.value(true);
                              });
                            }
                          },
                          icon: checked
                              ? const Icon(Icons.bookmark)
                              : const Icon(Icons.bookmark_outline),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
