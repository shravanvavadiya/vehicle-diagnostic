import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/utils/navigation_utils/navigation.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.automaticallyImplyLeading,
    this.actions,
    this.centerTitle,
    this.appBarSize,
    this.bottom,
    this.leading,
    this.color,
  });
  final String title;
  final bool? automaticallyImplyLeading;
  final bool? centerTitle;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final double? appBarSize;
  final Widget? leading;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      leading: (automaticallyImplyLeading ?? true) && leading == null
          ?
          // GestureDetector(
          //         onTap: () {
          //           Navigation.pop();
          //         },
          //         child: Container(
          //           width: 15.w,
          //           child: Icon(
          //             Icons.arrow_back_ios_rounded,
          //             color: AppColors.blackColor,
          //             size: 2.5.h,
          //           ),
          //         ),
          //       )
          IconButton(
              onPressed: () {
                Navigation.pop();
              },
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
                size: 2.5.h,
              ),
            )
          : leading,
      elevation: 0,
      backgroundColor: color,
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 12.sp),
      ),
      centerTitle: centerTitle ?? true,
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarSize ?? 50);
}
