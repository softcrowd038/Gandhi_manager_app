import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/provider/get_finance_letter.dart';
import 'package:gandhi_tvs/provider/verify_finance_letter_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class VerifyFinanceLetter extends StatefulWidget {
  final String? bookingId;
  const VerifyFinanceLetter({super.key, required this.bookingId});

  @override
  State<VerifyFinanceLetter> createState() => _VerifyKycPageState();
}

class _VerifyKycPageState extends State<VerifyFinanceLetter> {
  late final GetFinanceLetterProvider _financeLetterProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _financeLetterProvider.fetchFinanceLetters(context, widget.bookingId);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _financeLetterProvider = context.read<GetFinanceLetterProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Consumer<GetFinanceLetterProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return CircularProgressIndicator(color: AppColors.primary);
          }

          if (provider.errorMessage != null) {
            return Center(child: Text('Error: ${provider.errorMessage}'));
          }

          return Padding(
            padding: AppPadding.p2,
            child: Column(
              children: [
                CustomerHeader(
                  customerName:
                      "${provider.getFinanceLetterModel?.data.customerName}",
                  address: DateFormat('yyyy-MM-dd').format(
                    provider.getFinanceLetterModel?.data.createdAt ??
                        DateTime.now(),
                  ),
                  bookingId: provider.getFinanceLetterModel?.data.status ?? "",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    provider.getFinanceLetterModel?.data.status != "APPROVED"
                        ? Padding(
                            padding: AppPadding.p2,
                            child: GestureDetector(
                              onTap: () {
                                final verifyKyc =
                                    Provider.of<VerifyFinanceLetterProvider>(
                                      context,
                                      listen: false,
                                    );

                                verifyKyc.verifyFinanceLetter(
                                  context,
                                  provider
                                      .getFinanceLetterModel
                                      ?.data
                                      .bookingId,
                                  "APPROVED",
                                );
                              },
                              child: Container(
                                height: AppDimensions.height5,
                                width: AppDimensions.width40,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                ),
                                child: Center(
                                  child: Text(
                                    "Approve",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: AppFontSize.s18,
                                      fontWeight: AppFontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: AppPadding.p2,
                            child: GestureDetector(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Finance Letter is already Approved",
                                    ),
                                    backgroundColor: AppColors.error,
                                  ),
                                );
                              },
                              child: Container(
                                height: AppDimensions.height5,
                                width: AppDimensions.width40,
                                decoration: const BoxDecoration(
                                  color: AppColors.disabled,
                                ),
                                child: Center(
                                  child: Text(
                                    "Approve",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: AppFontSize.s18,
                                      fontWeight: AppFontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    provider.getFinanceLetterModel?.data.status != "APPROVED" ||
                            provider.getFinanceLetterModel?.data.status ==
                                "REJECTED"
                        ? Padding(
                            padding: AppPadding.p2,
                            child: GestureDetector(
                              onTap: () {
                                final verifyKyc =
                                    Provider.of<VerifyFinanceLetterProvider>(
                                      context,
                                      listen: false,
                                    );

                                verifyKyc.verifyFinanceLetter(
                                  context,
                                  provider
                                      .getFinanceLetterModel
                                      ?.data
                                      .bookingId,
                                  "REJECTED",
                                );
                              },
                              child: Container(
                                height: AppDimensions.height5,
                                width: AppDimensions.width40,
                                decoration: const BoxDecoration(
                                  color: AppColors.error,
                                ),
                                child: Center(
                                  child: Text(
                                    "Reject",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: AppFontSize.s18,
                                      fontWeight: AppFontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: AppPadding.p2,
                            child: GestureDetector(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Finance Letter is already Rejected",
                                    ),
                                    backgroundColor: AppColors.error,
                                  ),
                                );
                              },
                              child: Container(
                                height: AppDimensions.height5,
                                width: AppDimensions.width40,
                                decoration: const BoxDecoration(
                                  color: AppColors.disabled,
                                ),
                                child: Center(
                                  child: Text(
                                    "Reject",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: AppFontSize.s18,
                                      fontWeight: AppFontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
                const Divider(),

                Expanded(
                  child: Padding(
                    padding: AppPadding.p2,
                    child: Image.network(
                      "$baseImageUrl${provider.getFinanceLetterModel?.data.financeLetter}",
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
