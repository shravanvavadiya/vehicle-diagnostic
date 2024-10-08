import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/utils/app_colors.dart';
import 'package:flutter_template/widget/info_text_widget.dart';
import 'package:get/get.dart';
import 'package:story/story.dart';

import '../models/story_model.dart';

class StoryViewScreen extends StatefulWidget {
  const StoryViewScreen({super.key});

  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> {
  late ValueNotifier<IndicatorAnimationCommand> indicatorAnimationController;
   final storyList = [
    StoryModel(
      [
        StoryData("assets/images/onboard1.png", "Diagnose Vehicle Faults",
            "Your personal AI Mechanic will learn about your vehicles"),
        StoryData("assets/images/onboard2.png", "Explain the Issues Clearly",
            "It will give a detailed explanation of the potential faults it finds"),
        StoryData(
            "assets/images/onboard3.png",
            "Resolve or Refer to a Specialist",
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
      body: StoryPageView(
        indicatorVisitedColor: AppColors.highlightedColor,
        backgroundColor: AppColors.backgroundColor,
        itemBuilder: (context, pageIndex, storyIndex) {
          final user = storyList[pageIndex];
          final story = user.stories[storyIndex];
          return _buildStoryContent(story);
        },
        indicatorAnimationController: indicatorAnimationController,
        initialStoryIndex: (pageIndex) {
          if (pageIndex == 2) {
            return 0;
          }
          return 0;
        },
        pageLength: storyList.length,
        storyLength: (int pageIndex) {
          return storyList[pageIndex].stories.length;
        },
        onPageLimitReached: () {},
        indicatorUnvisitedColor: AppColors.highlightedColor.withOpacity(0.17),
      ),
    );
  }

  Widget _buildStoryContent(StoryData story) {
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
