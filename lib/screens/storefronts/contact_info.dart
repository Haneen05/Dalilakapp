import 'package:daleelakappx/models/storefront.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:flutter/material.dart';

class ContactInformationCard extends StatefulWidget {
  const ContactInformationCard({
    super.key,
  });

  @override
  State<ContactInformationCard> createState() => ContactInformationCardState();
}

class ContactInformationCardState extends State<ContactInformationCard> {
  var input = ContactInfoInput();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: DColumn(
          mainAxisSpacing: 25.0,
          children: [
            DRow(
              mainAxisSpacing: 12.0,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Icon(Icons.person_outline),
                Text(
                  'Contact Information',
                  overflow: TextOverflow.fade,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            DColumn(
              mainAxisSpacing: 13.0,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LabelField(
                  label: const Text('PhoneNumber'),
                  input: TextField(
                    decoration: const InputDecoration(
                      hintText: '+961',
                    ),
                    controller: input.phoneNumber,
                  ),
                ),
                LabelField(
                  label: const Text('EmailAddress'),
                  input: TextField(
                    decoration: const InputDecoration(
                      hintText: 'info@example.com',
                    ),
                    controller: input.email,
                  ),
                ),
                LabelField(
                  label: const Text('Address'),
                  input: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Address Details',
                    ),
                    controller: input.address,
                  ),
                ),
                LabelField(
                  label: const Text('GoogleMapLink'),
                  input: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Enter Google Map Link',
                    ),
                    controller: input.googleMapsLink,
                  ),
                ),
                LabelField(
                  label: const Text('Website'),
                  input: TextField(
                    decoration: const InputDecoration(
                      hintText: 'www.domain.com',
                    ),
                    controller: input.website,
                  ),
                ),
                LabelField(
                  label: const Text('Facebook'),
                  input: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Facebook URL',
                    ),
                    controller: input.facebookUrl,
                  ),
                ),
                LabelField(
                  label: const Text('Instagram'),
                  input: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Instagram URL',
                    ),
                    controller: input.instagramUrl,
                  ),
                ),
                LabelField(
                  label: const Text('Twitter(X)'),
                  input: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Twitter URL',
                    ),
                    controller: input.twitterUrl,
                  ),
                ),
                LabelField(
                  label: const Text('LinkedIn'),
                  input: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Linked in URL',
                    ),
                    controller: input.linkedinUrl,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void mapFrom(Storefront value) {
    setState(() {
      input.phoneNumber.text = value.phoneNumber;
      input.email.text = value.email;
      input.address.text = value.address;
      input.googleMapsLink.text = value.googleMapsLink;
      input.website.text = value.website;
      input.facebookUrl.text = value.facebookUrl;
      input.instagramUrl.text = value.instagramUrl;
      input.twitterUrl.text = value.twitterUrl;
      input.linkedinUrl.text = value.linkedinUrl;
    });
  }
}

class ContactInfoInput {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController googleMapsLink = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController facebookUrl = TextEditingController();
  TextEditingController instagramUrl = TextEditingController();
  TextEditingController twitterUrl = TextEditingController();
  TextEditingController linkedinUrl = TextEditingController();
}
