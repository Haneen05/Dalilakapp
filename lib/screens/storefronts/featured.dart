import 'package:daleelakappx/models/storefront.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FeaturedCard extends StatefulWidget {
  const FeaturedCard({
    super.key,
  });

  @override
  State<FeaturedCard> createState() => FeaturedCardState();
}

class FeaturedCardState extends State<FeaturedCard> {
  var input = FeaturedInput();

  @override
  Widget build(BuildContext context) {
    final expiryDate = input.expiryDate;
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          children: [
            DRow(
              mainAxisSpacing: 12.0,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Icon(Icons.star_outline),
                Expanded(
                  child: Text(
                    'Featured',
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                CupertinoSwitch(
                  value: input.featured,
                  onChanged: (checked) {
                    setState(() => input.featured = checked);
                  },
                ),
              ],
            ),
            if (input.featured)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                child: LabelField(
                  label: Row(
                    children: [
                      CupertinoCheckbox(
                        value: input.expiryDate != null,
                        onChanged: (checked) {
                          setState(() {
                            input.expiryDate = checked != null && checked
                                ? DateTime.now().add(const Duration(days: 1))
                                : null;
                          });
                        },
                      ),
                      const Text(
                        'Add Expiry Date',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  input: TextField(
                    readOnly: true,
                    onTap: () async {
                      var selectedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (selectedDate != null) {
                        setState(() => input.expiryDate = selectedDate);
                      }
                    },
                    controller: TextEditingController(
                      text: expiryDate != null
                          ? DateFormat('dd/MM/yyyy').format(expiryDate)
                          : '',
                    ),
                    decoration: const InputDecoration(hintText: 'DD/MM/YYYY'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void mapFrom(Storefront value) {
    setState(() {
      input.featured = value.featured;
      input.expiryDate = value.featuredExpiryDate;
    });
  }
}

class FeaturedInput {
  bool featured = false;
  DateTime? expiryDate;
}
