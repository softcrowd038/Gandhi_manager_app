import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DateSelector extends StatefulWidget {
  final String? birthDayDate;

  const DateSelector({super.key, this.birthDayDate});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime? _selectedDate;
  bool _hasInitialDate = false;

  @override
  void initState() {
    super.initState();
    if (widget.birthDayDate != null && widget.birthDayDate!.isNotEmpty) {
      try {
        _selectedDate = DateFormat('yyyy-MM-dd').parse(widget.birthDayDate!);
        _hasInitialDate = true;
      } catch (e) {
        print('Error parsing initial date: $e');
        _hasInitialDate = false;
      }
    }
  }

  @override
  void didUpdateWidget(covariant DateSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.birthDayDate != oldWidget.birthDayDate &&
        widget.birthDayDate != null &&
        widget.birthDayDate!.isNotEmpty) {
      try {
        setState(() {
          _selectedDate = DateFormat('yyyy-MM-dd').parse(widget.birthDayDate!);
          _hasInitialDate = true;
        });
      } catch (e) {
        print('Error parsing updated date: $e');
      }
    }
  }

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
            initialDate: _selectedDate ?? DateTime.now(),
            firstDate: DateTime(1930),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null) {
            setState(() {
              _selectedDate = pickedDate;
              _hasInitialDate = true;
              final formattedDate = DateFormat(
                'yyyy-MM-dd',
              ).format(_selectedDate!);
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
                _hasInitialDate
                    ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                    : 'Select Birth Date',
                style: TextStyle(
                  fontSize: SizeConfig.screenHeight * 0.017,
                  color: _hasInitialDate ? Colors.black : Colors.black38,
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
