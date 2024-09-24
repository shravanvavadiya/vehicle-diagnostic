import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/widget/info_text_widget.dart';
import 'package:get/get.dart';
import 'package:story/story.dart';

class StoryViewScreen extends StatefulWidget {
  StoryViewScreen({super.key});

  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> {
  late ValueNotifier<IndicatorAnimationCommand> indicatorAnimationController;
  static final sampleUsers = [
    UserModel(
      [
        StoryModel("assets/images/onboard1.png", "Diagnose Vehicle Faults",
            "Your personal AI Mechanic will learn about your vehicles"),
        StoryModel(
            "assets/images/onboard2.png", "Explain the Issues Clearly",
            "It will give a detailed explanation of the potential faults it finds"),
        StoryModel(
            "assets/images/onboard3.png", "Resolve or Refer to a Specialist",
            "Your AI Mechanic will give you guidance on self repair, or provide an explanation that you can relay to your real mechanic")
      ],
    )
  ];

  @override
  void initState() {
    super.initState();
    indicatorAnimationController = ValueNotifier<IndicatorAnimationCommand>(
        IndicatorAnimationCommand.resume);
  }

  @override
  void dispose() {
    indicatorAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      StoryPageView(
        indicatorVisitedColor: AppColors.highlightedColor,
        backgroundColor: AppColors.backgroundColor,
        itemBuilder: (context, pageIndex, storyIndex) {
          final user = sampleUsers[pageIndex];
          final story = user.stories[storyIndex];
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: AppColors.backgroundColor,
                height: 350.h,
                width: double.infinity,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: StoryImage(
                    key: ValueKey(story.imageUrl),
                    imageProvider: AssetImage(
                      story.imageUrl,
                    ),
                  ),
                ),
              ).paddingOnly(top: 50.h),
              InfoTextWidget(
                title: story.title,
                titleFontSize: 40.sp,
                titleFontWeight: FontWeight.w600,
                description: story.subTitle,
                fontSize: 15.3.sp,
                fontWeight: FontWeight.w400,
              ).paddingSymmetric(horizontal: 16.w),
            ],
          );
        },
        indicatorAnimationController: indicatorAnimationController,
        initialStoryIndex: (pageIndex) {
          if (pageIndex == 2) {
            return 0;
          }
          return 0;
        },

        pageLength: sampleUsers.length,
        storyLength: (int pageIndex) {
          return sampleUsers[pageIndex].stories.length;
        },
        onPageLimitReached: () {},
        indicatorUnvisitedColor: AppColors.highlightedColor.withOpacity(0.17),
      ),
    );
  }

  Widget _buildStoryContent(StoryModel story) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: AppColors.backgroundColor,
          height: 350.h,
          width: double.infinity,
          child: Align(
            alignment: Alignment.centerRight,
            child: Image.asset(
              story.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ).paddingOnly(top: 50.h),
        InfoTextWidget(
          title: story.title,
          titleFontSize: 40.sp,
          titleFontWeight: FontWeight.w600,
          description: story.subTitle,
          fontSize: 15.3.sp,
          fontWeight: FontWeight.w400,
        ).paddingSymmetric(horizontal: 16.w),
      ],
    );
  }
}

class UserModel {
  UserModel(this.stories);

  final List<StoryModel> stories;
}

class StoryModel {
  StoryModel(this.imageUrl, this.title, this.subTitle);

  final String imageUrl;
  final String title;
  final String subTitle;
}
