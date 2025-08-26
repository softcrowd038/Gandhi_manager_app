import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({super.key});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime? birthDayDate;

  @override
  Widget build(BuildContext context) {
    BookingFormProvider bookingFormProvider = Provider.of<BookingFormProvider>(
      context,
      listen: false,
    );
    return Padding(
      padding: EdgeInsets.all(SizeConfig.screenHeight * 0.01),
      child: InkWell(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1930),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null) {
            setState(() {
              birthDayDate = pickedDate;
              final formattedDate = DateFormat(
                'yyyy-MM-dd',
              ).format(birthDayDate ?? DateTime.now());
              bookingFormProvider.setBirthDate(formattedDate);
            });
          }
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black45),
            borderRadius: AppBorderRadius.r4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                birthDayDate == null
                    ? 'Select Birth Date'
                    : DateFormat(
                        'yyyy-MM-dd',
                      ).format(birthDayDate ?? DateTime.now()),
                style: TextStyle(
                  fontSize: SizeConfig.screenHeight * 0.017,
                  color: birthDayDate == null ? Colors.black38 : Colors.black,
                ),
              ),
              Icon(Icons.calendar_month, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
