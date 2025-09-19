import 'package:gandhi_tvs/common/app_imports.dart';


Color? getStatusColor(String? status1) {
  if (status1 == 'Status.NOT_APPROVED') {
    return Colors.red[100];
  } else if (status1 == 'Status.IN_STOCK') {
    return Colors.yellow[50];
  } else if (status1 == 'Status.IN_TRANSIT') {
    return Colors.blue[100];
  } else if (status1 == 'Status.SOLD') {
    return Colors.green[100];
  } else if (status1 == 'Status.SERVICE') {
    return Colors.purple[100];
  } else if (status1 == 'Status.DAMAGED') {
    return Colors.deepOrange[100];
  } else {
    return Colors.grey;
  }
}

Color? getStatusLableColor(String? status1) {
  if (status1 == 'Status.NOT_APPROVED') {
    return Colors.red;
  } else if (status1 == 'Status.IN_STOCK') {
    return Colors.amber;
  } else if (status1 == 'Status.IN_TRANSIT') {
    return Colors.blue;
  } else if (status1 == 'Status.SOLD') {
    return Colors.green;
  } else if (status1 == 'Status.SERVICE') {
    return Colors.purple;
  } else if (status1 == 'Status.DAMAGED') {
    return Colors.deepOrange;
  } else {
    return Colors.grey;
  }
}

String? getStatusLable(String? status1) {
  if (status1 == 'Status.NOT_APPROVED') {
    return "Not Approved";
  } else if (status1 == 'Status.IN_STOCK') {
    return "in Stock";
  } else if (status1 == 'Status.IN_TRANSIT') {
    return "in Transit";
  } else if (status1 == 'Status.SOLD') {
    return "Sold";
  } else if (status1 == 'Status.SERVICE') {
    return "Service";
  } else if (status1 == 'Status.DAMAGED') {
    return "Damage";
  } else {
    return "N / A";
  }
}

Color getStatusBackgroundColor(String? status) {
  switch (status) {
    case 'DRAFT':
      return Colors.grey.shade300;
    case 'PENDING_APPROVAL':
    case 'PENDING':
    case 'PENDING_APPROVAL (Discount_Exceeded)':
      return Colors.orange.shade100;
    case 'APPROVED':
      return Colors.green.shade200;
    case 'REJECTED':
      return Colors.red.shade400;
    case 'COMPLETED':
      return Colors.blue.shade400;
    case 'CANCELLED':
      return Colors.black45;
    default:
      return Colors.grey.shade200;
  }
}

Color getStatusLabelColor(String? status) {
  switch (status) {
    case 'DRAFT':
      return Colors.grey;
    case 'PENDING_APPROVAL':
    case 'PENDING':
    case 'PENDING_APPROVAL (Discount_Exceeded)':
      return Colors.orange;
    case 'APPROVED':
      return Colors.green;
    case 'COMPLETED':
      return Colors.blue;
    case 'REJECTED':
      return Colors.red;
    case 'CANCELLED':
      return Colors.white;
    default:
      return Colors.black;
  }
}

String getButtonLabel(String? status, UpdateBookingStatusProvider provider) {
  if (provider.isLoading) {
    return 'Approving...';
  }

  switch (status) {
    case 'PENDING_APPROVAL':
      return 'APPROVE BOOKING';
    case 'ALLOCATED':
      return 'ALLOCATED';
    case 'APPROVED':
      return 'APPROVED';
    case 'REJECTED':
      return 'REJECTED';
    case 'COMPLETED':
      return 'COMPLETED';
    case 'CANCELLED':
      return 'CANCELLED';
    case 'KYC_PENDING':
      return 'KYC PENDING';
    case 'KYC_VERIFIED':
      return 'KYC VERIFIED';
    case 'PENDING_APPROVAL (Discount_Exceeded)':
      return 'APPROVE BOOKING';
    default:
      return status ?? 'UNKNOWN STATUS';
  }
}

Color getButtonColor(String? status, UpdateBookingStatusProvider provider) {
  if (provider.isLoading) {
    return Colors.grey;
  }

  switch (status) {
    case 'PENDING_APPROVAL':
      return const Color.fromARGB(255, 13, 71, 161);
    case 'ALLOCATED':
      return Colors.orange;
    case 'APPROVED':
      return Colors.green;
    case 'REJECTED':
      return Colors.red;
    case 'COMPLETED':
      return Colors.purple;
    case 'CANCELLED':
      return Colors.redAccent;
    case 'KYC_PENDING':
      return Colors.amber;
    case 'KYC_VERIFIED':
      return Colors.lightGreen;
    case 'PENDING_APPROVAL (Discount_Exceeded)':
      return AppColors.primary;
    default:
      return Colors.grey;
  }
}

Color getContainerLabel(String? status) {
  switch (status) {
    case 'PENDING_APPROVAL':
      return Colors.amber;
    case 'ALLOCATED':
      return Colors.orange;
    case 'APPROVED':
      return Colors.green;
    case 'REJECTED':
      return Colors.red;
    case 'COMPLETED':
      return Colors.purple;
    case 'CANCELLED':
      return Colors.redAccent;
    case 'KYC_PENDING':
      return Colors.amber;
    case 'KYC_VERIFIED':
      return Colors.lightGreen;
    case 'PENDING_APPROVAL (Discount_Exceeded)':
      return Colors.deepOrange;
    default:
      return Colors.black;
  }
}

Color getContainerColor(String? status) {
  switch (status) {
    case 'PENDING_APPROVAL':
      return Colors.amber.shade100;
    case 'ALLOCATED':
      return Colors.orange.shade100;
    case 'APPROVED':
      return Colors.green.shade100;
    case 'REJECTED':
      return Colors.red.shade100;
    case 'COMPLETED':
      return Colors.purple.shade100;
    case 'CANCELLED':
      return Colors.redAccent.shade100;
    case 'KYC_PENDING':
      return Colors.amber.shade100;
    case 'KYC_VERIFIED':
      return Colors.lightGreen.shade100;
    case 'PENDING_APPROVAL (Discount_Exceeded)':
      return Colors.deepOrange.shade100;
    default:
      return Colors.grey;
  }
}

String getContainerLabelText(String? status) {
  // print(status);
  switch (status) {
    case 'PENDING_APPROVAL':
      return 'PENDING_APPROVAL';
    case 'ALLOCATED':
      return 'ALLOCATED';
    case 'APPROVED':
      return 'APPROVED';
    case 'REJECTED':
      return 'REJECTED';
    case 'COMPLETED':
      return 'COMPLETED';
    case 'CANCELLED':
      return 'CANCELLED';
    case 'KYC_PENDING':
      return 'KYC PENDING';
    case 'KYC_VERIFIED':
      return 'KYC VERIFIED';
    case 'PENDING_APPROVAL (Discount_Exceeded)':
      return 'Discount Exceeded';
    default:
      return status ?? 'UNKNOWN STATUS';
  }
}
