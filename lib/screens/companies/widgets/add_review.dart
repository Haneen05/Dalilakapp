import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:flutter/material.dart';

typedef AddReviewCallback = void Function(
  String title,
  String descrpition,
  int rating,
);

class AddReviewWidget extends StatefulWidget {
  final VoidCallback? onCancel;
  final AddReviewCallback? onAddReview;

  const AddReviewWidget({
    super.key,
    this.onCancel,
    this.onAddReview,
  });

  @override
  State<AddReviewWidget> createState() => _AddReviewWidgetState();
}

class _AddReviewWidgetState extends State<AddReviewWidget> {
  int rating = 0;
  var title = TextEditingController(text: '');
  var description = TextEditingController(text: '');
  String? titleError;
  String? descriptionError;
  String? ratingError;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final ratingError = this.ratingError;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DBox.xlSpace),
      child: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              'Score:',
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const DBox.verticalSpaceXl(),
          Row(
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    rating = index + 1;
                    this.ratingError = null;
                  });
                },
                child: Icon(
                  size: 32.0,
                  index >= rating ? Icons.star_border : Icons.star,
                  color: index >= rating
                      ? const Color(0xffc4c4c4)
                      : colorScheme.primaryFixedDim,
                ),
              );
            }),
          ),
          if (ratingError != null)
            Text(
              ratingError,
              style: const TextStyle(
                color: Color(0xffe16060),
              ),
            ),
          const DBox.verticalSpaceXl(),
          TextField(
            controller: title,
            onChanged: (_) {
              setState(() => titleError = null);
            },
            decoration: InputDecoration(
              hintText: 'Title',
              errorText: titleError,
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffcbd5e1)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffcbd5e1)),
              ),
            ),
          ),
          const DBox.verticalSpaceLg(),
          TextField(
            controller: description,
            onChanged: (_) {
              setState(() => descriptionError = null);
            },
            maxLines: 6,
            decoration: InputDecoration(
              hintText: 'Write Your Description',
              errorText: descriptionError,
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffcbd5e1)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffcbd5e1)),
              ),
            ),
          ),
          const DBox.verticalSpaceLg(),
          Row(
            children: [
              DButton.elevated(
                onPressed: widget.onCancel,
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const DBox.horizontalSpaceMd(),
              Expanded(
                child: DButton.elevatedPrimary(
                  label: const Text('PostReview'),
                  onPressed: () {
                    if (!validate()) {
                      return;
                    }

                    widget.onAddReview?.call(
                      title.text,
                      description.text,
                      rating,
                    );
                  },
                  backgroundColor: const Color(0xff0b0b0b),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  bool validate() {
    bool valid = true;

    if (title.text.trim().isEmpty) {
      setState(() => titleError = 'Required');
      valid = false;
    }

    if (title.text.trim().length < 3) {
      setState(() => titleError = 'Input at least 3 characters');
      valid = false;
    }

    if (rating == 0) {
      setState(() => ratingError = 'Please select rating');
      valid = false;
    }

    return valid;
  }
}
