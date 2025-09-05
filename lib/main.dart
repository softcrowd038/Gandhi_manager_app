import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/provider/allocate_chassis_number_provider.dart';
import 'package:gandhi_tvs/provider/downpayment_provider.dart';
import 'package:gandhi_tvs/provider/get_all_users_provider.dart';
import 'package:gandhi_tvs/provider/get_chassis_numbers_provider.dart';
import 'package:gandhi_tvs/provider/get_finance_letter.dart';
import 'package:gandhi_tvs/provider/get_pending_request_provider.dart';
import 'package:gandhi_tvs/provider/update_booking_provider.dart';
import 'package:gandhi_tvs/provider/update_booking_status.dart';
import 'package:gandhi_tvs/provider/verify_finance_letter_provider.dart';
import 'package:gandhi_tvs/provider/verify_kyc_document_provider.dart';
import 'package:gandhi_tvs/provider/verify_kyc_provider.dart';
import 'package:gandhi_tvs/provider/verify_updated_request.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserLoginProvider()),
        ChangeNotifierProvider(create: (_) => OtpVerificationProvider()),
        ChangeNotifierProvider(create: (_) => UserDetailsProvider()),
        ChangeNotifierProvider(create: (_) => BikeModelProvider()),
        ChangeNotifierProvider(create: (_) => SelectedModelsProvider()),
        ChangeNotifierProvider(create: (_) => DocumentDetailsProvider()),
        ChangeNotifierProvider(create: (_) => GenerateQuotationProvider()),
        ChangeNotifierProvider(create: (_) => QuotationProvider()),
        ChangeNotifierProvider(create: (_) => TermsAndConditionProvider()),
        ChangeNotifierProvider(create: (_) => AllQuotationProvider()),
        ChangeNotifierProvider(create: (_) => GetMonthQuotations()),
        ChangeNotifierProvider(create: (_) => GetTodayQuotations()),
        ChangeNotifierProvider(create: (_) => ColorsProvider()),
        ChangeNotifierProvider(create: (_) => ExchangeBrokerProvider()),
        ChangeNotifierProvider(create: (_) => FinancerProvider()),
        ChangeNotifierProvider(create: (_) => AccessoriesProvider()),
        ChangeNotifierProvider(create: (_) => ModelHeadersProvider()),
        ChangeNotifierProvider(create: (_) => SelectedAccessoriesProvider()),
        ChangeNotifierProvider(create: (_) => SelectedModelHeadersProvider()),
        ChangeNotifierProvider(create: (_) => BookingFormProvider()),
        ChangeNotifierProvider(create: (_) => AllBookingsProvider()),
        ChangeNotifierProvider(create: (_) => InwardedModelsProvider()),
        ChangeNotifierProvider(create: (_) => GetBikeDetailsByIdProvider()),
        ChangeNotifierProvider(create: (_) => KYCProvider()),
        ChangeNotifierProvider(create: (_) => FinanceLetterProvider()),
        ChangeNotifierProvider(create: (_) => BookingBikeModelProvider()),
        ChangeNotifierProvider(create: (_) => GetInwardModelDetailsQr()),
        ChangeNotifierProvider(create: (_) => GetBookingsByIdProvider()),
        ChangeNotifierProvider(create: (_) => DashStatsProvider()),
        ChangeNotifierProvider(create: (_) => BrokerOtpVerifyProvider()),
        ChangeNotifierProvider(create: (_) => BrokerOtpVerificationProvider()),
        ChangeNotifierProvider(create: (_) => GetAllUsersProvider()),
        ChangeNotifierProvider(create: (_) => UpdateBookingStatusProvider()),
        ChangeNotifierProvider(create: (_) => UpdateBookingProvider()),
        ChangeNotifierProvider(create: (_) => DownpaymentProvider()),
        ChangeNotifierProvider(create: (_) => VerifyKycProvider()),
        ChangeNotifierProvider(create: (_) => GetFinanceLetterProvider()),
        ChangeNotifierProvider(create: (_) => VerifyKycDocumentProvider()),
        ChangeNotifierProvider(create: (_) => VerifyFinanceLetterProvider()),
        ChangeNotifierProvider(create: (_) => AllocateChassisProvider()),
        ChangeNotifierProvider(create: (_) => GetChassisNumbersProvider()),
        ChangeNotifierProvider(create: (_) => GetPendingRequestsProvider()),
        ChangeNotifierProvider(create: (_) => VerifyUpdatedRequestProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
