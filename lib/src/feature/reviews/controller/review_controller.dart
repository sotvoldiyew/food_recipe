import 'package:flutter/material.dart';

import '../screen/review.dart';

mixin ReviewController on State<ReviewsPage> {
  late final TextEditingController commentController;

  @override
  void initState() {
    commentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }
}