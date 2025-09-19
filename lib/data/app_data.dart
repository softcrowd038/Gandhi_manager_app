final String baseUrl = "https://dealership.gandhitvs.in/api/v1/";

final String baseImageUrl = "https://dealership.gandhitvs.in/api/v1";

final String whatsAppBaseUrl = 'https://dealership.gandhitvs.in/api/v1';

final String apikey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4OGIwNTdlZjZmNmI1N2EzNDkzMGIzYSIsImlhdCI6MTc1Mzk1MDY2MiwiZXhwIjoxNzU2NTQyNjYyfQ.xtM0NKNyDgBdm1ln0JQwbOlvei85pvrgqm3jnkX5d00';

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
