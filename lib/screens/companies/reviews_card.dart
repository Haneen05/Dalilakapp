import 'dart:async';

import 'package:daleelakappx/models.dart';
import 'package:daleelakappx/provider.dart';
import 'package:daleelakappx/screens/companies/widgets/add_review.dart';
import 'package:daleelakappx/screens/companies/widgets/review_widget.dart';
import 'package:daleelakappx/screens/companies/widgets/reviews_by_rating_summary.dart';
import 'package:daleelakappx/screens/companies/widgets/reviews_summary.dart';
import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:daleelakappx/api.dart' as api;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReviewsCard extends StatefulWidget {
  final Storefront storefront;

  const ReviewsCard({super.key, required this.storefront});

  @override
  State<ReviewsCard> createState() => _ReviewsCardState();
}

class _ReviewsCardState extends State<ReviewsCard> {
  bool writingReview = false;
  Future<List<Review>> reviews = Completer<List<Review>>().future;
  Future<bool> canAddReviews = Completer<bool>().future;
  late Storefront _storefront;

  @override
  void initState() {
    reviews = _fetchReviews();
    _storefront = widget.storefront;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final user = DProvider.of(context).user;

    if (user != null) {
      canAddReviews = api.reviews
          .findMany(storefrontId: widget.storefront.id, userId: user.id)
          .then((docs) => docs.isEmpty);
    } else {
      canAddReviews = Future.value(false);
    }

    super.didChangeDependencies();
  }

  Future<List<Review>> _fetchReviews() {
    return api.reviews.findMany(storefrontId: widget.storefront.id);
  }

  @override
  Widget build(BuildContext context) {
    final l18n = AppLocalizations.of(context)!;
    final user = DProvider.of(context).user;

    var addReviewButton = SizedBox(
      width: double.infinity,
      child: DButton.outlined(
        onPressed: () {
          setState(() => writingReview = true);
        },
        foregroundColor: const Color(0xff64748b),
        borderColor: const Color(0xffe0e0e0),
        child: DRow(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add),
            Text(l18n.writeReview),
          ],
        ),
      ),
    );

    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(DBox.xlSpace),
        child: DColumn(
          mainAxisSpacing: DBox.xlSpace,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l18n.ratingAndReviews,
              style: const TextStyle(
                fontSize: DBox.fontLg,
                fontWeight: FontWeight.bold,
              ),
            ),
            DRow(
              mainAxisSpacing: DBox.xlSpace,
              children: [
                Expanded(
                    child: ReviewsByRatingSummary(
                  reviewStats: _storefront.reviewStats,
                )),
                Center(
                  child: ReviewsSummary(
                    reviewStats: _storefront.reviewStats,
                  ),
                ),
              ],
            ),
            if (user != null)
              FutureBuilder(
                future: canAddReviews,
                initialData: false,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return SelectableText(snapshot.error.toString());
                  }

                  if (!snapshot.data!) {
                    return const SizedBox();
                  }

                  return AnimatedSize(
                    duration: const Duration(milliseconds: 500),
                    child: writingReview
                        ? AddReviewWidget(
                            onAddReview: (title, description, rating) async {
                              setState(() => writingReview = false);

                              await api.reviews.add(
                                widget.storefront.id,
                                ReviewCreateInput(
                                  title: title,
                                  description: description,
                                  score: rating,
                                  createdAt: DateTime.now(),
                                  userId: user.id,
                                ),
                              );
                           _storefront =   await api.storefronts.findOne(widget.storefront.id);

                              setState((){
                                reviews = _fetchReviews();
                                canAddReviews = Future.value(false);
                              });
                            },
                            onCancel: () {
                              setState(() => writingReview = false);
                            },
                          )
                        : addReviewButton,
                  );
                },
              ),
            FutureBuilder(
              future: reviews,
              initialData: Review.dummyData(),
              builder: (context, snapshot) {
                return Skeletonizer(
                  enabled: snapshot.connectionState != ConnectionState.done,
                  child: Column(
                    children: ListTile.divideTiles(
                      context: context,
                      color: const Color(0xffe2e8f0),
                      tiles: snapshot.data!.map((review) {
                        return ReviewWidget(
                          author: FutureBuilder(
                            future: review.user,
                            initialData: DUser.dummyData()[0],
                            builder: (context, snapshot) {
                              // var name = 'Unknown User';
                              // final user = snapshot.data;
                              // if (user != null && user.name.isNotEmpty) {
                              //   name = user.name;
                              // }

                              return Skeletonizer(
                                enabled: snapshot.connectionState !=
                                    ConnectionState.done,
                                child: Text("Anonymous"),
                              );
                            },
                          ),
                          title: review.title,
                          rating: review.score,
                          details: review.description,
                        );
                      }),
                    ).toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
