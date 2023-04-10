import 'package:flutter/material.dart';

import 'admob_banner.dart';

class AdmobStack extends StatelessWidget {
  final List<Widget> children;
  final String adUnitId;

  const AdmobStack({
    super.key,
    this.children = const <Widget>[],
    required this.adUnitId,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ...children,
        Container(
          color: Colors.white,
          height: 62,
          width: MediaQuery.of(context).size.width,
          child: AdmobBanner(
            adUnitId: adUnitId,
          ),
        ),
      ],
    );
  }
}
