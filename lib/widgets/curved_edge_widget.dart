import 'package:flutter/material.dart';
import 'package:message_reminder/widgets/custom_curved_edge.dart';

class TCurvedEdgesWidget extends StatelessWidget {
  const TCurvedEdgesWidget({
    super.key, this.child
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: TCustomCurvedEdges(),
        child:  child
    );
  }
}
