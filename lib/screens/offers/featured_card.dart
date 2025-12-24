import 'package:daleelakappx/models/offer.dart';
import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FeaturedCard extends StatefulWidget {
  const FeaturedCard({super.key});

  @override
  State<FeaturedCard> createState() => FeaturedCardState();
}

class FeaturedCardState extends State<FeaturedCard> {
  var input = OfferFeaturedInput();

  @override
  Widget build(BuildContext context) {
    final expiryDate = input.expiryDate;
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(DBox.xlSpace),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.star_outline),
                const DBox.horizontalSpaceMd(),
                const Expanded(
                  child: Text(
                    'Featured',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: DBox.fontLg,
                    ),
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
                        style: TextStyle(
                          color: Colors.black,
                        ),
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

  void mapFrom(Offer value) {
    setState(() {
      input.featured = value.featured;
      input.expiryDate = value.featuredExpiryDate;
    });
  }
}

class OfferFeaturedInput {
  bool featured = false;
  DateTime? expiryDate;
}
