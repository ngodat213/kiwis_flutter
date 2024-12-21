import 'package:flutter/material.dart';
import 'package:kiwis_flutter/core/constants/app_export.dart';
import 'package:kiwis_flutter/models/plan_location.model.dart';
import 'package:kiwis_flutter/views/plan/plan_controller.dart';
import 'package:kiwis_flutter/widgets/custom_icon_button.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:vietmap_flutter_gl/vietmap_flutter_gl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LocationCard extends GetView<PlanController> {
  const LocationCard(
      {super.key,
      required this.planLocation,
      this.isLast = false,
      required this.index});
  final PlanLocationModel planLocation;
  final bool? isLast;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: Get.width,
          height: 200,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: VietmapGL(
                  styleString:
                      'https://maps.vietmap.vn/api/maps/dark/styles.json?apikey=' +
                          dotenv.env['VIETMAP_API_KEY']!,
                  myLocationRenderMode: MyLocationRenderMode.COMPASS,
                  initialCameraPosition: CameraPosition(
                    target:
                        LatLng(planLocation.latitude!, planLocation.longitude!),
                    zoom: 15,
                  ),
                  onMapCreated: (controller) {
                    controller.addSymbol(
                      SymbolOptions(
                        geometry: LatLng(
                            planLocation.latitude!, planLocation.longitude!),
                        iconImage: "marker-15",
                        iconSize: 2.0,
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      '📌 ' + planLocation.name!,
                      style: theme.textTheme.titleLarge!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      planLocation.address!,
                      style: theme.textTheme.titleSmall!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Visibility(
          visible: isLast == false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: DottedLine(
                  direction: Axis.horizontal,
                  lineThickness: 1,
                  dashLength: 4,
                  dashGapLength: 2,
                  dashColor: Colors.white,
                ),
              ),
              CustomIconButton(
                height: 36.h,
                width: 36.h,
                padding: EdgeInsets.all(10.h),
                onTap: () {
                  // controller.onTapSwapLocation(index);
                },
                child: Center(
                  child: Icon(
                    size: 16,
                    Icons.swap_vert,
                    color: Colors.white,
                  ),
                ),
              ).marginSymmetric(horizontal: 10),
              Expanded(
                child: DottedLine(
                  direction: Axis.horizontal,
                  lineThickness: 1,
                  dashLength: 4,
                  dashGapLength: 2,
                  dashColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
