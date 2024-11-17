import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipe/src/common/utils/context_extention.dart';

import '../../../common/style/app_icons.dart';
import '../../../common/style/app_images.dart';

class FollowProfile extends StatefulWidget {
  const FollowProfile({super.key});

  @override
  State<FollowProfile> createState() => _FollowProfileState();
}

class _FollowProfileState extends State<FollowProfile> {
  bool isFollow = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          child: Image(
            image: AssetImage(AppImages.profileImage),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          children: [
            Text(
              "Laura wilson",
              style: context.textTheme.labelLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(AppIcons.location),
                Text(
                  " Lagos, Nigeria",
                  style: context.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            )
          ],
        ),
        const Spacer(),
        MaterialButton(
          splashColor: Colors.transparent,
          elevation: 0,
          height: 45,
          minWidth: 90,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: context.colors.primary, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          color: isFollow ? context.colors.onPrimary : context.colors.primary,
          child: Text(
            isFollow ? context.lang.following : context.lang.follow,
            style: context.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w500,
              color:
                  isFollow ? context.colors.primary : context.colors.onPrimary,
            ),
          ),
          onPressed: () {
            setState(() {
              isFollow = !isFollow;
            });
          },
        )
      ],
    );
  }
}
