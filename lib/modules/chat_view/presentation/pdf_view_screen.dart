import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_string.dart';
import '../../../utils/app_text.dart';
import '../../../widget/custom_backarrow_widget.dart';
import '../controller/pdf_view_controller.dart';
import 'download_pop_up.dart';

class PdfViewScreen extends StatefulWidget {
  final String pdfData;

  const PdfViewScreen({super.key, required this.pdfData});

  @override
  State<PdfViewScreen> createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  @override
  Widget build(BuildContext context) {
    return GetX<PdfViewController>(
      init: PdfViewController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          leading: const CustomBackArrowWidget().paddingAll(11.w),
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          title: Text(
            controller.screenName.value,
            style: TextStyle(color: Colors.black),
          ),
          // actions: [
          //   Center(
          //     child: GestureDetector(
          //       onTap: () {
          //         showDownloadDialog(controller, widget.pdfData);
          //       },
          //       child: Container(
          //         height: 28.h,
          //         decoration: BoxDecoration(
          //           color: AppColors.highlightedColor,
          //           borderRadius: BorderRadius.circular(30.r),
          //         ),
          //         child: Center(
          //           child: AppText(
          //             text: AppString.downloadPDF,
          //             color: AppColors.whiteColor,
          //           ).paddingOnly(right: 10.w, left: 10.w),
          //         ),
          //       ),
          //     ),
          //   ).paddingOnly(right: 16.w)
          // ],
        ),
        // body: SafeArea(
        //   child: SfPdfViewer.memory(
        //     widget.pdfData,
        //   ),
        // ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(child: HtmlWidget(widget.pdfData)),
        ),
      ),
    );
  }
}
