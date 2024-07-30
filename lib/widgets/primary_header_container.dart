import 'package:flutter/material.dart';
import 'package:message_reminder/res/consts/t_colors.dart';
import 'package:message_reminder/widgets/circular_container.dart';
import 'package:message_reminder/widgets/curved_edge_widget.dart';


class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key, required this.child
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgesWidget(
        child:  Container(
          color: TColors.primary,

          // -- if [size.isFinite' : is not true.in Stack] error occurred -> Readme.md file

          child: Stack(
            children: [
              // -- background custom shapes
              Positioned(top: -150, right: -250,child: TCircularContainer(backgroundColor: TColors.textWhite.withOpacity(0.1),)),
              Positioned(top: 100, right: -300,child: TCircularContainer(backgroundColor: TColors.textWhite.withOpacity(0.1),)),
              child,
            ],
          ),
        )
    );
  }
}


