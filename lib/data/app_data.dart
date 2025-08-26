import 'package:gandhi_tvs/common/app_imports.dart';

final String baseUrl = "http://192.168.1.2:5002/api/v1/";

final String baseImageUrl = "http://192.168.1.2:5002/api/v1";

final String whatsAppBaseUrl = 'https://waapi.happysms.in';

final String apikey = '550894e05e134b71a49ff8f9358fe3ee';

final gstinPattern =
    r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$';
final String aadhaarPattern = r'^\d{12}$';
final String panPattern = r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$';
final String mobilePattern = r'^[6-9]\d{9}$';
final String pincodePattern = r'^[1-9][0-9]{5}$';

final String message =
    'Thank you for preferring Us.\nIt is our pleasure to serve customers like you.\nYour bike Quotation is attached.\n\nRegards,\nGandhi TVS Nashik';

final List<String> bannerImages = [
  'https://www.tvsmotor.com/tvs-radeon/-/media/Brand-Pages/Radeon/Slider/05-04-2022/2.jpg',
  'https://www.tvsmotor.com/tvs-radeon/-/media/Brand-Pages/Radeon/Slider/05-04-2022/1.jpg',
  'https://vehiclebazaar.online/wp-content/uploads/2024/07/tvs-banner.png',
];

List<String> documents = [
  'Aadhar Front',
  'Aadhar Back',
  'Pan Card',
  'Vehicle Photo',
  'Chassis No Photo',
  'Address Proof 1',
  'Address Proof 2',
];

List<String> occupation = [
  "Business",
  "Farmer",
  "Private Job",
  "Government Job",
  "Students",
  "CSD",
];

final List<Map<String, dynamic>> drawerSections = [
  {"title": "Dashboard", "icon": Icons.dashboard, "subSections": []},
  {
    "title": "Purchase",
    "icon": FontAwesomeIcons.cartPlus,
    "subSections": [
      {
        "title": "Dashboard",
        "icon": Icons.directions_bike,
        "page": BikeModelsDetails(),
      },
      {
        "title": "Inward",
        "icon": FontAwesomeIcons.motorcycle,
        "page": AllBookingsPage(),
      },
      {
        "title": "Manage Stock",
        "icon": Icons.manage_accounts,
        "page": AllBookingsPage(),
      },
      {
        "title": "Stock Transfer",
        "icon": Icons.change_circle,
        "page": AllBookingsPage(),
      },
      {
        "title": "Transfer Report",
        "icon": Icons.report,
        "page": AllBookingsPage(),
      },
    ],
  },
  {
    "title": "Quotation",
    "icon": FontAwesomeIcons.fileWaveform,
    "subSections": [
      {"title": "Generate Quotation", "icon": Icons.add, "page": MyHomePage()},
      {
        "title": "View Quotation",
        "icon": Icons.file_copy,
        "page": ActivityPage(isActivePage: false),
      },
      {
        "title": "Report",
        "icon": Icons.report,
        "page": ActivityPage(isActivePage: false),
      },
    ],
  },
  {
    "title": "Sales",
    "icon": FontAwesomeIcons.sackDollar,
    "subSections": [
      {"title": "DashBoard", "icon": Icons.dashboard, "page": MyHomePage()},
      {
        "title": "New Booking",
        "icon": Icons.book_online,
        "page": ActivityPage(isActivePage: false),
      },
      {
        "title": "Report",
        "icon": Icons.report,
        "page": ActivityPage(isActivePage: false),
      },
    ],
  },
  {
    "title": "Quotation",
    "icon": FontAwesomeIcons.fileWaveform,
    "subSections": [
      {"title": "Generate Quotation", "icon": Icons.add, "page": MyHomePage()},
      {
        "title": "View Quotation",
        "icon": Icons.file_copy,
        "page": ActivityPage(isActivePage: false),
      },
      {
        "title": "Report",
        "icon": Icons.report,
        "page": ActivityPage(isActivePage: false),
      },
    ],
  },
  {
    "title": "Quotation",
    "icon": FontAwesomeIcons.fileWaveform,
    "subSections": [
      {"title": "Generate Quotation", "icon": Icons.add, "page": MyHomePage()},
      {
        "title": "View Quotation",
        "icon": Icons.file_copy,
        "page": ActivityPage(isActivePage: false),
      },
      {
        "title": "Report",
        "icon": Icons.report,
        "page": ActivityPage(isActivePage: false),
      },
    ],
  },
];
