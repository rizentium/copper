import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../const/size.dart';

class LoadingIndicator extends StatelessWidget {
  final void Function(VisibilityInfo value)? info;

  const LoadingIndicator({super.key, this.info});

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('LoadingWidget'),
      onVisibilityChanged: info,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: UISize.basic,
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
