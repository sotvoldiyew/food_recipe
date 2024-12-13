import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/src/common/utils/context_extension.dart';
import 'package:food_recipe/src/feature/profile/bloc/profile_bloc.dart';

class MyViewMore extends StatefulWidget {
  const MyViewMore({
    super.key,
    required this.text,
  });

  final String text;

  @override
  State<MyViewMore> createState() => _MyViewMoreState();
}

class _MyViewMoreState extends State<MyViewMore> {
  @override
  void initState() {
    super.initState();
    truncatedText = widget.text;
  }

  String truncatedText = "";

  @override
  Widget build(BuildContext context) {
    final textStyle = context.textTheme.bodyLarge!;

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) => LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;

          if (!state.isExpanded) {
            context.read<ProfileBloc>().add(ViewMore$ProfileEvent(
                text: state.text, maxWidth: maxWidth, style: textStyle));
            truncatedText = state.text;
          }

          return RichText(
            text: TextSpan(
              style: context.textTheme.labelSmall,
              children: [
                TextSpan(
                  text: state.isExpanded ? widget.text : truncatedText,
                ),
                 TextSpan(text: widget.text),
                TextSpan(
                  text: state.isExpanded
                      ? context.lang.viewLess
                      : context.lang.viewMore,
                  style: context.textTheme.labelSmall
                      ?.copyWith(color: context.colors.primary),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context
                          .read<ProfileBloc>()
                          .add(const UpdateText$ProfileEvent());
                    },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
