// ignore_for_file: deprecated_member_use

import 'package:gandhi_tvs/pages/edit_select_booking_model_page.dart';
import 'package:gandhi_tvs/provider/update_booking_status.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:gandhi_tvs/common/app_imports.dart';

class GetBookingByIdPage extends HookWidget {
  const GetBookingByIdPage({super.key, required this.bookingId});

  final String? bookingId;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final getBookingByIdProvider = Provider.of<GetBookingsByIdProvider>(
          context,
          listen: false,
        );
        getBookingByIdProvider.fetchBookingsById(context, bookingId ?? "");
      });
      return null;
    }, []);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Consumer2<GetBookingsByIdProvider, UserDetailsProvider>(
            builder: (context, bookingProvider, userDetails, _) {
              final booking = bookingProvider.bookings?.data;
              final formPath = booking?.formPath ?? "";
              final htmlUrl = '$baseImageUrl$formPath';
              print("boooking :${booking?.status}");

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  userDetails.userDetails?.data?.roles.any(
                            (role) => role.name == "MANAGER",
                          ) ??
                          true
                      ? (booking?.status == "PENDING_APPROVAL"
                            ? IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EditSelectBookingModelPage(
                                            bookingId: bookingProvider
                                                .bookings
                                                ?.data
                                                ?.id,
                                          ),
                                    ),
                                  );
                                },
                              )
                            : IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: AppColors.disabled,
                                ),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "NO Edit Available for this booking",
                                      ),
                                      backgroundColor: AppColors.error,
                                    ),
                                  );
                                },
                              ))
                      : SizedBox.shrink(),
                  booking?.status != "'PENDING_APPROVAL (Discount_Exceeded)'" &&
                          formPath.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.download),
                          onPressed: () {
                            downloadHtmlAsPdf(
                              context,
                              htmlUrl,
                              'booking-form-${booking?.bookingNumber ?? "file"}',
                            );
                          },
                        )
                      : const SizedBox.shrink(),
                  booking?.status != "'PENDING_APPROVAL (Discount_Exceeded)'" &&
                          formPath.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.print),
                          onPressed: () {
                            printHtmlAsPdf(context, htmlUrl);
                          },
                        )
                      : const SizedBox.shrink(),
                ],
              );
            },
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Consumer<GetBookingsByIdProvider>(
        builder: (context, bookingProvider, _) {
          final booking = bookingProvider.bookings?.data;

          if (booking == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return bookingProvider.isLoading
              ? Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                )
              : Stack(
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomerHeader(
                            customerName:
                                "${booking.customerDetails?.salutation} ${booking.customerDetails?.name}",
                            address: booking.model?.modelName ?? "",
                            bookingId: booking.bookingNumber ?? "",
                          ),
                          Divider(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              StatusChangingContainer(
                                label: booking.kycStatus,
                                status1: booking.kycStatus,
                                value: 'KYC',
                              ),
                              booking.payment?.type == 'FINANCE'
                                  ? SizedBox(height: AppDimensions.height1)
                                  : SizedBox.shrink(),
                              booking.payment?.type == 'FINANCE'
                                  ? StatusChangingContainer(
                                      label: booking.financeLetterStatus,
                                      status1: booking.financeLetterStatus,
                                      value: 'FL',
                                    )
                                  : SizedBox.shrink(),
                              SizedBox(height: AppDimensions.height1),
                              SizeChangingStatusContainer(
                                label: booking.status,
                                status1: booking.status,
                                value: "Booking",
                              ),
                            ],
                          ),
                          SizedBox(height: AppDimensions.height1),
                          Card(
                            color: Colors.white,
                            child: ListTile(
                              title: Text(
                                "Customer Details",
                                style: TextStyle(
                                  fontWeight: AppFontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LableWithIcon(
                                    lable:
                                        "${booking.customerDetails?.address}, ${booking.customerDetails?.taluka}, ${booking.customerDetails?.district}, ${booking.customerDetails?.pincode}",
                                    colors: AppColors.error,
                                    textColors: AppColors.textPrimary,
                                    size: AppDimensions.height3,
                                    circle: Icons.place,
                                    fontWeight: AppFontWeight.w500,
                                  ),
                                  SizedBox(height: AppDimensions.height1),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      LableWithIcon(
                                        lable: booking.customerDetails?.mobile1,
                                        colors: AppColors.secondary,
                                        textColors: AppColors.textPrimary,
                                        size: AppDimensions.height3,
                                        circle: Icons.phone,
                                        fontWeight: AppFontWeight.w500,
                                      ),
                                      LableWithIcon(
                                        lable:
                                            booking.customerDetails?.occupation,
                                        colors: AppColors.textSecondary,
                                        textColors: AppColors.textPrimary,
                                        size: AppDimensions.height3,
                                        circle: Icons.home_repair_service,
                                        fontWeight: AppFontWeight.w500,
                                      ),
                                    ],
                                  ),
                                  LableWithIcon(
                                    lable: booking.customerDetails?.dob,
                                    colors: AppColors.textSecondary,
                                    textColors: AppColors.textPrimary,
                                    size: AppDimensions.height3,
                                    circle: Icons.calendar_month,
                                    fontWeight: AppFontWeight.w500,
                                  ),
                                  SizedBox(height: AppDimensions.height1),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Addhaar:",
                                        style: TextStyle(
                                          fontWeight: AppFontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        booking.customerDetails?.aadharNumber !=
                                                ""
                                            ? booking
                                                      .customerDetails
                                                      ?.aadharNumber ??
                                                  ""
                                            : 'N/A',
                                        style: TextStyle(
                                          fontWeight: AppFontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "PAN No:",
                                        style: TextStyle(
                                          fontWeight: AppFontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        booking.customerDetails?.aadharNumber !=
                                                ""
                                            ? booking.customerDetails?.panNo ??
                                                  'N/A'
                                            : 'N/A',
                                        style: TextStyle(
                                          fontWeight: AppFontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: AppDimensions.height1),
                                  booking.customerDetails?.nomineeName != null
                                      ? Text(
                                          "${booking.customerDetails?.nomineeName?.toUpperCase()} is my ${booking.customerDetails?.nomineeRelation} of age ${booking.customerDetails?.nomineeAge} is my nominee",
                                          style: TextStyle(
                                            fontWeight: AppFontWeight.w500,
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.white,
                            child: ListTile(
                              title: Text(
                                "Model Details",
                                style: TextStyle(
                                  fontWeight: AppFontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LableWithIcon(
                                    lable: "${booking.model?.modelName}",
                                    colors: AppColors.primary,
                                    textColors: AppColors.textPrimary,
                                    size: AppDimensions.height3,
                                    circle: Icons.motorcycle,
                                    fontWeight: AppFontWeight.w500,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      LableWithIcon(
                                        lable: booking.model?.type,
                                        colors: AppColors.secondary,
                                        textColors: AppColors.textPrimary,
                                        size: AppDimensions.height3,
                                        circle: booking.model?.type == "EV"
                                            ? Icons.electric_bike
                                            : Icons.motorcycle_outlined,
                                        fontWeight: AppFontWeight.w500,
                                      ),
                                      LableWithIcon(
                                        lable: booking.color?.name,
                                        colors: AppColors.textSecondary,
                                        textColors: AppColors.textPrimary,
                                        size: AppDimensions.height3,
                                        circle: Icons.color_lens,
                                        fontWeight: AppFontWeight.w500,
                                      ),
                                    ],
                                  ),
                                  LableWithIcon(
                                    lable: DateFormat('yyyy-MM-dd').format(
                                      booking.createdAt ?? DateTime.now(),
                                    ),
                                    colors: AppColors.textSecondary,
                                    textColors: AppColors.textPrimary,
                                    size: AppDimensions.height3,
                                    circle: Icons.calendar_month,
                                    fontWeight: AppFontWeight.w500,
                                  ),
                                  SizedBox(height: AppDimensions.height1),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Chassis Number:",
                                        style: TextStyle(
                                          fontWeight: AppFontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        booking.chassisNumber ?? 'N/A',
                                        style: TextStyle(
                                          fontWeight: AppFontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Battery Number:",
                                        style: TextStyle(
                                          fontWeight: AppFontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        booking.batteryNumber ?? 'N/A',
                                        style: TextStyle(
                                          fontWeight: AppFontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Key Number:",
                                        style: TextStyle(
                                          fontWeight: AppFontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        booking.keyNumber ?? 'N/A',
                                        style: TextStyle(
                                          fontWeight: AppFontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Motor Number:",
                                        style: TextStyle(
                                          fontWeight: AppFontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        booking.motorNumber ?? 'N/A',
                                        style: TextStyle(
                                          fontWeight: AppFontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Engine Number:",
                                        style: TextStyle(
                                          fontWeight: AppFontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        booking.engineNumber ?? 'N/A',
                                        style: TextStyle(
                                          fontWeight: AppFontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Charger Number:",
                                        style: TextStyle(
                                          fontWeight: AppFontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        booking.chargerNumber ?? 'N/A',
                                        style: TextStyle(
                                          fontWeight: AppFontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.white,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Accessories Details",
                                        style: TextStyle(
                                          fontWeight: AppFontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${booking.accessoriesTotal} ₹',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.error,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                booking.accessories.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: booking.accessories.length,
                                        itemBuilder: (context, index) {
                                          final accessory =
                                              booking.accessories[index];
                                          return ListTile(
                                            minTileHeight:
                                                AppDimensions.height1,
                                            title: Text(
                                              accessory.accessory?.name ?? "",
                                            ),
                                            trailing: Text(
                                              "${accessory.price} ₹",
                                              style: TextStyle(
                                                fontSize: AppFontSize.s18,
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : Padding(
                                        padding: EdgeInsets.all(16),
                                        child: Text("No accessories added"),
                                      ),
                              ],
                            ),
                          ),
                          Card(
                            color: Colors.white,
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Payment Details",
                                    style: TextStyle(
                                      fontWeight: AppFontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${booking.totalAmount.toString()} ₹",
                                    style: TextStyle(
                                      fontWeight: AppFontWeight.w500,
                                      color: AppColors.error,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LableWithIcon(
                                    lable: "${booking.payment?.type}",
                                    colors: booking.payment?.type == "CASH"
                                        ? AppColors.success
                                        : AppColors.secondary,
                                    textColors: AppColors.textPrimary,
                                    size: AppDimensions.height3,
                                    circle: booking.payment?.type == "CASH"
                                        ? Icons.currency_rupee
                                        : Icons.credit_card,
                                    fontWeight: AppFontWeight.w500,
                                  ),
                                  booking.payment?.type != "CASH"
                                      ? LableWithIcon(
                                          lable:
                                              booking.payment?.financer?.name,
                                          colors: AppColors.secondary,
                                          textColors: AppColors.textPrimary,
                                          size: AppDimensions.height3,
                                          circle: FontAwesomeIcons.bank,
                                          fontWeight: AppFontWeight.w500,
                                        )
                                      : SizedBox.shrink(),
                                  booking.payment?.type != "CASH"
                                      ? LableWithIcon(
                                          lable: booking.payment?.scheme,
                                          colors: AppColors.textSecondary,
                                          textColors: AppColors.textPrimary,
                                          size: AppDimensions.height3,
                                          circle: Icons.calendar_month,
                                          fontWeight: AppFontWeight.w500,
                                        )
                                      : SizedBox.shrink(),
                                  SizedBox(height: AppDimensions.height1),
                                  booking.payment?.type != "CASH"
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Scheme Number:",
                                              style: TextStyle(
                                                fontWeight: AppFontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              booking.payment?.scheme ?? 'N/A',
                                              style: TextStyle(
                                                fontWeight: AppFontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        )
                                      : SizedBox.shrink(),
                                  booking.payment?.type != "CASH"
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Emi plan:",
                                              style: TextStyle(
                                                fontWeight: AppFontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              booking.payment?.emiPlan ?? 'N/A',
                                              style: TextStyle(
                                                fontWeight: AppFontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        )
                                      : SizedBox.shrink(),
                                  booking.payment?.type != "CASH"
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Gc Applicable",
                                              style: TextStyle(
                                                fontWeight: AppFontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              booking.payment?.gcApplicable ??
                                                      false
                                                  ? "Yes"
                                                  : 'No',
                                              style: TextStyle(
                                                fontWeight: AppFontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        )
                                      : SizedBox.shrink(),
                                  booking.payment?.type != "CASH"
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "GC amount:",
                                              style: TextStyle(
                                                fontWeight: AppFontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              "${booking.payment?.gcAmount.toString()} ₹",
                                              style: TextStyle(
                                                fontWeight: AppFontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        )
                                      : SizedBox.shrink(),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.white,
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Exchange Details",
                                    style: TextStyle(
                                      fontWeight: AppFontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    booking.exchange ?? false ? "Yes" : "No",
                                    style: TextStyle(
                                      fontWeight: AppFontWeight.w500,
                                      color: booking.exchange ?? false
                                          ? AppColors.success
                                          : AppColors.error,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: booking.exchange ?? false
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        LableWithIcon(
                                          lable: booking
                                              .exchangeDetails
                                              ?.broker
                                              ?.name,
                                          colors: AppColors.secondary,
                                          textColors: AppColors.textPrimary,
                                          size: AppDimensions.height3,
                                          circle: Icons.person,
                                          fontWeight: AppFontWeight.w500,
                                        ),
                                        SizedBox(height: AppDimensions.height1),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Price:",
                                              style: TextStyle(
                                                fontWeight: AppFontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              booking.exchangeDetails?.price
                                                      .toString() ??
                                                  'N/A',
                                              style: TextStyle(
                                                fontWeight: AppFontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Vehicle Number:",
                                              style: TextStyle(
                                                fontWeight: AppFontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              booking
                                                      .exchangeDetails
                                                      ?.vehicleNumber ??
                                                  'N/A',
                                              style: TextStyle(
                                                fontWeight: AppFontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Chassiss Number",
                                              style: TextStyle(
                                                fontWeight: AppFontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              booking
                                                      .exchangeDetails
                                                      ?.chassisNumber ??
                                                  "",
                                              style: TextStyle(
                                                fontWeight: AppFontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  : SizedBox.shrink(),
                            ),
                          ),
                          Card(
                            color: Colors.white,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Discount Details",
                                        style: TextStyle(
                                          fontWeight: AppFontWeight.bold,
                                        ),
                                      ),
                                      if (booking.discounts.isNotEmpty)
                                        Text(
                                          '${booking.discounts[0].amount.toString()} ₹', // Using first discount as primary
                                          style: TextStyle(
                                            fontWeight: AppFontWeight.w500,
                                            color: AppColors.error,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                ...booking.discounts.map(
                                  (discount) => Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text('${discount.amount} ₹'),
                                      subtitle: SizeChangingStatusContainer(
                                        status1: discount.approvalStatus,
                                        label: discount.approvalStatus,
                                        value: discount.type,
                                      ),
                                    ),
                                  ),
                                ),
                                if (booking.discounts.isEmpty)
                                  Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Text("No discounts applied"),
                                  ),
                              ],
                            ),
                          ),
                          Card(
                            color: Colors.white,
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Price Headers",
                                    style: TextStyle(
                                      fontWeight: AppFontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: SizedBox(
                                height: AppDimensions.height20,
                                child: booking.priceComponents.isNotEmpty
                                    ? ListView.builder(
                                        itemCount:
                                            booking.priceComponents.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            minTileHeight:
                                                AppDimensions.height1,
                                            title: Text(
                                              booking
                                                      .priceComponents[index]
                                                      .header
                                                      ?.headerKey ??
                                                  "",
                                            ),
                                            trailing: Text(
                                              '${booking.priceComponents[index].originalValue.toString()} ₹',
                                              style: TextStyle(
                                                fontSize: AppFontSize.s18,
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : Padding(
                                        padding: EdgeInsets.all(16),
                                        child: Text("No Price Headers added"),
                                      ),
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.white,
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "RTO Details",
                                    style: TextStyle(
                                      fontWeight: AppFontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: booking.rto == "MH"
                                          ? Colors.yellow[50]
                                          : booking.rto == "BH"
                                          ? Colors.green[100]
                                          : Colors.red[100],
                                      borderRadius: AppBorderRadius.r1,
                                    ),
                                    child: Padding(
                                      padding: AppPadding.p1,
                                      child: Center(
                                        child: Text(
                                          booking.rto ?? "",
                                          style: TextStyle(
                                            color: booking.rto == "MH"
                                                ? Colors.amber
                                                : booking.rto == "BH"
                                                ? Colors.green
                                                : Colors.red,
                                            fontWeight: FontWeight.w600,
                                            fontSize: AppFontSize.s14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: booking.rto != null
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "RTO Amount:",
                                          style: TextStyle(
                                            fontWeight: AppFontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          '${booking.rtoAmount.toString()} ₹',
                                          style: TextStyle(
                                            fontWeight: AppFontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox.shrink(),
                            ),
                          ),
                          SizedBox(height: AppDimensions.height5),
                        ],
                      ),
                    ),
                    booking.status == "PENDING_APPROVAL"
                        ? Consumer<UserDetailsProvider>(
                            builder: (context, user, _) {
                              return user.userDetails?.data?.roles.any(
                                        (role) => role.name == "MANAGER",
                                      ) ??
                                      true
                                  ? Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child:
                                          Consumer<UpdateBookingStatusProvider>(
                                            builder:
                                                (context, statusProvider, _) {
                                                  return GestureDetector(
                                                    onTap: () => statusProvider
                                                        .updateBookingStatus(
                                                          context,
                                                          booking.id ?? "",
                                                        ),
                                                    child: TheWidthFullButton(
                                                      lable: getButtonLabel(
                                                        booking.status,
                                                        statusProvider,
                                                      ),
                                                      color: getButtonColor(
                                                        booking.status,
                                                        statusProvider,
                                                      ),
                                                    ),
                                                  );
                                                },
                                          ),
                                    )
                                  : SizedBox.shrink();
                            },
                          )
                        : SizedBox.shrink(),
                  ],
                );
        },
      ),
    );
  }
}
