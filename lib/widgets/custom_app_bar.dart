import 'package:gandhi_tvs/common/app_imports.dart';

class CustomAppBar extends HookWidget implements PreferredSizeWidget {
  final String? username;
  final void Function()? onTap;
  final void Function()? onTapLeading;

  const CustomAppBar({
    super.key,
    required this.username,
    required this.onTap,
    required this.onTapLeading,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      // leading: GestureDetector(onTap: onTapLeading, child: Icon(Icons.menu)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: height * 0.1,
                width: height * 0.1,
              ),
              SizedBox(width: height * 0.008),
              (username != 'User')
                  ? Text(
                      (username ?? 'USER').toUpperCase(),
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: height * 0.018,
                      ),
                    )
                  : Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: height * 0.12,
                        height: height * 0.018,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GetModelDetailsByScanning(),
                    ),
                  );
                },
                child: Image.network(
                  'https://cdn-icons-png.flaticon.com/128/15471/15471832.png',
                  height: height * 0.03,
                  width: height * 0.03,
                ),
              ),
              SizedBox(width: AppDimensions.width2),
              GestureDetector(
                onTap: onTap,
                child: Image.asset(
                  'assets/images/power.png',
                  height: height * 0.03,
                  width: height * 0.03,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
