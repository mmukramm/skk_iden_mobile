import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skk_iden_mobile/core/theme/colors.dart';

class Loading extends StatelessWidget {
  final bool withScaffold;
  final Color color;
  const Loading({
    super.key,
    this.withScaffold = false,
    this.color = scaffoldColor,
  });

  @override
  Widget build(BuildContext context) {
    return withScaffold
        ? Scaffold(
            body: _buildLoading(),
          )
        : _buildLoading();
  }

  Widget _buildLoading() => Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
            color: color, size: 60),
      );
}
