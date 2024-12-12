import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';

class SelectionRowWidget extends StatelessWidget {
  const SelectionRowWidget(
      {super.key,
      required this.inboxOne,
      required this.aboutOne,
      required this.applicationvers,
      required this.onTap});
  final String inboxOne;
  final String aboutOne;
  final String applicationvers;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.onPrimary.withOpacity(0.05),
            width: 1.h,
          ),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        onTap: onTap,
        title: Text(
          aboutOne,
          style: theme.textTheme.titleSmall!
              .copyWith(color: theme.colorScheme.onPrimary.withOpacity(1)),
        ),
        subtitle: Text(
          applicationvers,
          style: theme.textTheme.bodySmall!
              .copyWith(color: theme.colorScheme.onPrimary.withOpacity(0.5)),
        ),
        leading: Container(
          height: 48.h,
          width: 48.h,
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimary,
            borderRadius: BorderRadiusStyle.roundedBorder24,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomImageView(
                imagePath: inboxOne,
                height: 24.h,
                width: 26.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
