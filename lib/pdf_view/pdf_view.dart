import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewPage extends StatefulWidget {
  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  String remotePDFpath = "";
  int downloadProgress = 0;

  @override
  void initState() {
    super.initState();

    downloadPDF();
  }

  void downloadPDF() async {
    createFileOfPdfUrl(
      "https://ia600709.us.archive.org/19/items/inzonix_gmail_MGTT/master_guide_tips___tricks_issuu.pdf",
      (progress) {
        print('Download progress: $progress%');
        setState(() {
          downloadProgress = progress;
        });
      },
    ).then((f) {
      setState(() {
        remotePDFpath = f.path;
      });
    }).catchError((error) {
      print('Error during PDF download: $error');
    });
  }

  Future<File> createFileOfPdfUrl(String url, Function(int)? onProgress) async {
    Completer<File> completer = Completer();
    print("Start download file from the internet!");
    try {
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var contentLength = response.contentLength;
      var bytes = <int>[];
      var receivedBytes = 0;

      response.listen(
        (List<int> newBytes) {
          bytes.addAll(newBytes);
          receivedBytes += newBytes.length;
          if (contentLength != -1) {
            double progress = receivedBytes / contentLength;
            onProgress?.call((progress * 100).toInt());
          }
        },
        onDone: () async {
          var dir = await getApplicationDocumentsDirectory();
          print("Download complete");
          print("${dir.path}/$filename");
          File file = File("${dir.path}/$filename");
          await file.writeAsBytes(bytes, flush: true);
          completer.complete(file);
        },
        onError: (e) {
          completer.completeError(e);
        },
        cancelOnError: true,
      );
    } catch (e) {
      completer.completeError(Exception('Error parsing asset file!'));
    }

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('PDF Viewer')),
      body: Center(
        child: Builder(
          builder: (BuildContext context) {
            if (remotePDFpath.isEmpty) {
              return Stack(
                children: [
                  Center(
                    child: Container(
                      width: 75,
                      height: 75,
                      child: CircularProgressIndicator(
                        // backgroundColor: Colors.green,
                        strokeWidth: 4,
                        value: downloadProgress / 100,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    ),
                  ),
                  Center(
                    child: Text('$downloadProgress %'),
                  ),
                ],
              );

              // return Text(
              //   'Download Progress: $downloadProgress%',
              //   style: TextStyle(fontSize: 18),
              // );
            } else {
              return Material(
                child: PDFScreen(path: remotePDFpath),
              );
            }
          },
        ),
      ),
    );
  }
}

class PDFScreen extends StatefulWidget {
  final String? path;

  PDFScreen({Key? key, this.path}) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            enableSwipe: true,
            autoSpacing: true,
            pageFling: false,
            defaultPage: currentPage!,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation: false,
            onRender: (_pages) {
              setState(() {
                pages = _pages;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
              print(error.toString());
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
              print('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
            onLinkHandler: (String? uri) {
              print('goto uri: $uri');
            },
            onPageChanged: (int? page, int? total) {
              print('page change: $page/$total');
              setState(() {
                currentPage = page;
              });
            },
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Center(
                  child: Text(errorMessage),
                ),
          Positioned(
            right: 10,
            top: 20,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.amber,
              ),
              child: Text('${currentPage! + 1} / $pages'),
            ),
          )
        ],
      ),
    );
  }
}
