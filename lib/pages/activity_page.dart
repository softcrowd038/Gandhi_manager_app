// ignore_for_file: unnecessary_null_comparison

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/all_quotations_model.dart';
import 'package:provider/provider.dart';

class ActivityPage extends StatefulWidget {
  final bool isActivePage;
  const ActivityPage({super.key, required this.isActivePage});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final TextEditingController searchController = TextEditingController();
  List<Quotation> filteredQuotations = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AllQuotationProvider>(
        context,
        listen: false,
      ).fetchQuotations(context);
    });
  }

  void filterQuotations(String query) {
    final allQuotationProvider = Provider.of<AllQuotationProvider>(
      context,
      listen: false,
    );
    final allQuotations = allQuotationProvider.quotation?.data.quotations ?? [];

    setState(() {
      if (query.isEmpty) {
        filteredQuotations = allQuotations;
      } else {
        filteredQuotations = allQuotations
            .where(
              (quotation) => quotation.customer.name!.toLowerCase().contains(
                query.toLowerCase(),
              ),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    UsefulFunctions usefulFunctions = UsefulFunctions();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isActivePage
            ? SearchField(
                controller: searchController,
                onChanged: filterQuotations,
                labelText: "search customer by name",
              )
            : SectionTitle(title: "Recent Quotations"),
        Expanded(
          child: Consumer<AllQuotationProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              } else {
                final quotationsToDisplay = searchController.text.isEmpty
                    ? provider.quotation?.data.quotations ?? []
                    : filteredQuotations;

                if (quotationsToDisplay.isEmpty) {
                  return Center(
                    child: Text(
                      searchController.text.isEmpty
                          ? 'No data available.'
                          : 'No customers found for "${searchController.text}"',
                      style: TextStyle(
                        fontSize: AppFontSize.s18,
                        fontWeight: AppFontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: widget.isActivePage
                      ? quotationsToDisplay.length
                      : quotationsToDisplay.length < 5
                      ? quotationsToDisplay.length
                      : 5,
                  itemBuilder: (context, index) {
                    final quotation = quotationsToDisplay[index];
                    final customer = quotation.customer;
                    final models = quotation.models;

                    final customerName = customer.name;
                    final customerAddress = quotation.customer.mobile1;
                    final modelName =
                        (models.isNotEmpty && models.first.modelName != null)
                        ? models.first.modelName
                        : 'No Model';

                    final quotationId = quotation.id;

                    return ActivityCard(
                      customerName: customerName ?? "",
                      customerAddress: customerAddress ?? "",
                      modelName: modelName.toString(),
                      phoneNumber: customer.mobile1 ?? "",
                      quotationId: quotationId ?? "",
                      customerExpectedDate: usefulFunctions
                          .formatDateToYyyyMmDd(
                            quotation.expectedDeliveryDate ?? DateTime.now(),
                          ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
