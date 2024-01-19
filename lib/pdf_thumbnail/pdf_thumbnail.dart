import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';

class PdfViewPage extends StatefulWidget {
  const PdfViewPage({super.key});

  @override
  State<PdfViewPage> createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  int pages = 0;
  int? totalPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Thumbnail
          Container(
            width: 100,
            color: Colors.orange,
          ),
          // PDF viewer
          Expanded(
            child: Container(
              child: PDF(
                autoSpacing: Platform.isAndroid ? false : true,
                pageFling: false,
                pageSnap: false,
                onPageChanged: (int? current, int? total) {
                  setState(() {
                    pages = current! + 1;
                    totalPage = total!;
                  });
                },
                onViewCreated: (PDFViewController pdfViewController) async {
                  pages = await pdfViewController.getCurrentPage() ?? 0;
                  totalPage = await pdfViewController.getPageCount();
                  setState(() {});
                },
              ).cachedFromUrl(
                "https://ia600709.us.archive.org/19/items/inzonix_gmail_MGTT/master_guide_tips___tricks_issuu.pdf",
                placeholder: (progress) => Center(
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          width: 75,
                          height: 75,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.orange,
                            strokeWidth: 4,
                            value: progress / 100,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.orange,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text('$progress %'),
                      ),
                    ],
                  ),
                ),
                errorWidget: (error) => Center(
                  child: Text(
                    error.toString(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
