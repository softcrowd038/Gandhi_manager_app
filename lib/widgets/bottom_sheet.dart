import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:provider/provider.dart';

void showInwardDetailsBottomSheet(
  BuildContext context,
  bool isScrolledControlled,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: isScrolledControlled,
    showDragHandle: false,
    builder: (BuildContext context) {
      return Consumer<GetInwardModelDetailsQr>(
        builder: (context, getInward, index) {
          final vehicles = getInward.inwardModelDetails?.data;
          final modelName = vehicles?.vehicle.model?.modelName;

          return SafeArea(
            child: SizedBox(
              width: AppDimensions.fullWidth,
              child: Padding(
                padding: AppPadding.p2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ),
                    SizedBox(height: AppDimensions.height2),
                    Padding(
                      padding: AppPadding.p1,
                      child: Text(
                        modelName ?? "",
                        style: TextStyle(
                          fontSize: AppFontSize.s22,
                          fontWeight: AppFontWeight.w600,
                        ),
                      ),
                    ),
                    if (vehicles != null && modelName != null) ...[
                      Row(
                        children: vehicles.vehicle.colors.map((colorModel) {
                          final hex =
                              colorModel.hexCode?.replaceFirst('#', '0xff') ??
                              "0xff000000";
                          Color parsedColor;
                          try {
                            parsedColor = Color(int.parse(hex));
                          } catch (_) {
                            parsedColor = Colors.black;
                          }
                          return ColorLabelNoValueRow(
                            color: parsedColor,
                            label: colorModel.name ?? "Unknown",
                          );
                        }).toList(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppDimensions.width1,
                        ),
                        child: InwardModelStatusContainer(
                          label: vehicles.vehicle.status,
                          status1: vehicles.vehicle.status,
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ColorLabelRow(
                              color: AppColors.accent,
                              label: "Chassis Number",
                              value: vehicles.vehicle.chassisNumber,
                            ),
                            vehicles.vehicle.motorNumber != null
                                ? ColorLabelRow(
                                    color: AppColors.error,
                                    label: "Motor Number",
                                    value: vehicles.vehicle.motorNumber,
                                  )
                                : SizedBox.shrink(),
                            vehicles.vehicle.batteryNumber != null
                                ? ColorLabelRow(
                                    color: AppColors.primary,
                                    label: "Battery Number",
                                    value: vehicles.vehicle.batteryNumber,
                                  )
                                : SizedBox.shrink(),
                            ColorLabelRow(
                              color: AppColors.success,
                              label: "Key Number",
                              value: vehicles.vehicle.keyNumber,
                            ),
                            vehicles.vehicle.engineNumber != null
                                ? ColorLabelRow(
                                    color: AppColors.secondary,
                                    label: "Engine Number",
                                    value: vehicles.vehicle.engineNumber,
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),
                      SizedBox(height: AppDimensions.height2),
                    ] else ...[
                      Center(
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'No details available',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
