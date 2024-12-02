import 'package:flutter/material.dart';
import 'package:kiwis_flutter/views/next_point/models/chip_view_4_item.model.dart';
import '../../../core/constants/app_export.dart';

// ignore_for_file: must_be_immutable
class Chipview4ItemWidget extends StatelessWidget {
  Chipview4ItemWidget(this.chipview4ItemModelObj, {Key? key})
      : super(
          key: key,
        );

  ChipView4ItemModel chipview4ItemModelObj;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RawChip(
        padding: EdgeInsets.symmetric(
          horizontal: 18.h,
          vertical: 10.h,
        ),
        showCheckmark: false,
        labelPadding: EdgeInsets.zero,
        label: Text(
          chipview4ItemModelObj.buttontinyFour1!.value,
          style: TextStyle(
            color: (chipview4ItemModelObj.isSelected?.value ?? false)
                ? appTheme.gray5002
                : theme.colorScheme.onPrimary.withOpacity(1),
            fontSize: 12.fSize,
            fontFamily: 'Google Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
        selected: (chipview4ItemModelObj.isSelected?.value ?? false),
        backgroundColor: theme.colorScheme.onPrimary,
        selectedColor: theme.colorScheme.onPrimary.withOpacity(0.21),
        side: BorderSide.none,
        shape: (chipview4ItemModelObj.isSelected?.value ?? false)
            ? RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(
                  18.h,
                ))
            : RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(
                  18.h,
                ),
              ),
        onSelected: (value) {
          chipview4ItemModelObj.isSelected!.value = value;
        },
      ),
    );
  }
}
