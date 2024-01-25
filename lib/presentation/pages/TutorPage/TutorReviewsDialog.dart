import 'package:flutter/material.dart';
import 'package:lettutor/models/Review.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/presentation/widgets/AvatarWidget/AvatarWidget.dart';
import 'package:lettutor/presentation/widgets/TutorProfile/Rating.dart';
import 'package:lettutor/service/TutorService.dart';
import 'package:timeago/timeago.dart' as timeago;

class TutorReviewsDialog extends StatefulWidget {
  const TutorReviewsDialog({super.key, required this.tutor});

  final Tutor tutor;

  @override
  State<TutorReviewsDialog> createState() => _TutorReviewsDialogState();
}

class _TutorReviewsDialogState extends State<TutorReviewsDialog> {
  final _tutorService = const TutorService();
  bool isLoading = true;
  final List<Review> reviewList = [];

  @override
  void initState() {
    super.initState();
    _tutorService.getReviewList(widget.tutor).then((value) {
      setState(() {
        reviewList.addAll(value);
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar(
            backgroundColor: Colors.grey.shade300,
            automaticallyImplyLeading: false,
            actions: [
              CloseButton(
                onPressed: () => Navigator.pop(context),
              )
            ],
            shape: const Border(bottom: BorderSide(color: Colors.grey)),
            title: const Text("Reviews"),
          ),
          isLoading
              ? const Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Expanded(
                  child: reviewList.isNotEmpty
                      ? SingleChildScrollView(
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ReviewTile(
                                review: reviewList[index],
                              ),
                            ),
                            separatorBuilder: (context, index) =>
                                const Divider(color: Colors.grey),
                            itemCount: reviewList.length,
                          ),
                        )
                      : Text(
                          "No review yet",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey.shade500),
                        )),
        ],
      ),
    );
  }
}

class ReviewTile extends StatelessWidget {
  const ReviewTile({super.key, required this.review});

  final Review review;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AvatarWidget(
          name: review.author.name ?? review.author.email,
          avatarUrl: review.author.avatar,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: review.author.name ?? review.author.email,
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: Colors.grey.shade700),
                ),
                const TextSpan(text: "  ", style: TextStyle(fontSize: 12)),
                TextSpan(
                    text: "(${timeago.format(review.createdAt)})",
                    style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey, fontStyle: FontStyle.italic)),
              ])),
              Rating(
                rating: review.rating,
              ),
              if (review.comment != null)
                Text(
                  review.comment!,
                  style: theme.textTheme.bodySmall,
                )
            ],
          ),
        )
      ],
    );
  }
}
