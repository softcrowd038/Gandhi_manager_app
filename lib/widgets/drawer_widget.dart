import 'package:gandhi_tvs/common/app_imports.dart';

class DrawerWidget extends HookWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              "Menu",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),

          // Section 1
          ExpansionTile(
            leading: Icon(Icons.dashboard),
            title: Text("Dashboard"),
            children: [
              ListTile(
                leading: Icon(Icons.arrow_right),
                title: Text("Analytics"),
                onTap: () {
                  Navigator.pop(context); // Close drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.arrow_right),
                title: Text("Reports"),
                onTap: () {},
              ),
            ],
          ),

          // Section 2
          ExpansionTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            children: [
              ListTile(
                leading: Icon(Icons.arrow_right),
                title: Text("Profile"),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.arrow_right),
                title: Text("Security"),
                onTap: () {},
              ),
            ],
          ),

          // Section 3
          ExpansionTile(
            leading: Icon(Icons.help),
            title: Text("Help"),
            children: [
              ListTile(
                leading: Icon(Icons.arrow_right),
                title: Text("FAQ"),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.arrow_right),
                title: Text("Contact Us"),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
