import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:provider/provider.dart';

class VerifyPendingRequest extends StatefulWidget {
  final String? bookingId;
  const VerifyPendingRequest({super.key, required this.bookingId});

  @override
  State<VerifyPendingRequest> createState() => _VerifyPendingRequestState();
}

class _VerifyPendingRequestState extends State<VerifyPendingRequest> {
  late final GetPendingRequestsProvider _pendingRequestsProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pendingRequestsProvider.fetchPendingRequests(
        context,
        widget.bookingId ?? "",
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pendingRequestsProvider = context.read<GetPendingRequestsProvider>();
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
      body: Consumer<GetPendingRequestsProvider>(
        builder: (context, provider, _) {
          return Padding(
            padding: AppPadding.p2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomerHeader(
                  customerName:
                      "${provider.pendingRequests?.data.customerName}",
                  address: provider.pendingRequests?.data.model ?? "",
                  bookingId: provider.pendingRequests?.data.bookingNumber ?? "",
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: AppPadding.p2,
                      child: GestureDetector(
                        onTap: () {
                          final verifyKyc =
                              Provider.of<VerifyUpdatedRequestProvider>(
                                context,
                                listen: false,
                              );

                          verifyKyc.verifyUpdateRequest(
                            context,
                            provider.pendingRequests?.data.id,
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
                    ),
                    Padding(
                      padding: AppPadding.p2,
                      child: GestureDetector(
                        onTap: () {
                          final verifyKyc =
                              Provider.of<VerifyUpdatedRequestProvider>(
                                context,
                                listen: false,
                              );

                          verifyKyc.verifyUpdateRequest(
                            context,
                            provider.pendingRequests?.data.id,
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
                    ),
                  ],
                ),
                const Divider(),

                SectionTitle(title: "Resolve Pending Request"),

                _buildDetailRow(
                  icon: Icons.person,
                  label: "Updated Name",
                  value:
                      provider
                          .pendingRequests
                          ?.data
                          .pendingUpdates
                          .customerDetails
                          .name ??
                      "",
                ),

                _buildDetailRow(
                  icon: Icons.home,
                  label: "Address",
                  value:
                      provider
                          .pendingRequests
                          ?.data
                          .pendingUpdates
                          .customerDetails
                          .address ??
                      "",
                ),

                _buildDetailRow(
                  icon: Icons.smartphone_sharp,
                  label: "mobile1",
                  value:
                      provider
                          .pendingRequests
                          ?.data
                          .pendingUpdates
                          .customerDetails
                          .mobile1 ??
                      "",
                ),

                _buildDetailRow(
                  icon: Icons.smartphone_sharp,
                  label: "mobile2",
                  value:
                      provider
                          .pendingRequests
                          ?.data
                          .pendingUpdates
                          .customerDetails
                          .mobile2 ??
                      "",
                ),

                _buildDetailRow(
                  icon: Icons.circle,
                  label: "color",
                  value:
                      provider.pendingRequests?.data.pendingUpdates.color ?? "",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget _buildDetailRow({
  required IconData icon,
  required String label,
  required String value,
}) {
  return Padding(
    padding: EdgeInsets.only(bottom: AppDimensions.height2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: AppFontSize.s28, color: AppColors.primary),
        SizedBox(width: AppDimensions.width2),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: AppFontSize.s16,
                  fontWeight: AppFontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: AppDimensions.height5),
              Text(
                value,
                style: TextStyle(
                  fontSize: AppFontSize.s18,
                  fontWeight: AppFontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
