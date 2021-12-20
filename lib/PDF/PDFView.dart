import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:maana_main_project_2/components/loading_widget.dart';

class PDFPage extends StatefulWidget {
  final String path;

  const PDFPage({Key key, this.path}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PDFPageState(path);
  }
}

class _PDFPageState extends State<PDFPage> {
  final String path;
  bool _isLoading = true;
  PDFDocument document;

  _PDFPageState(this.path);

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromURL(path != null
        ? path.length > 0
            ? path
            : 'https://mana.domvp.xyz/wp-content/uploads/2020/11/En-quête-d’Afrique_220_P_LowQuality.pdf'
        : 'https://mana.domvp.xyz/wp-content/uploads/2020/11/En-quête-d’Afrique_220_P_LowQuality.pdf');
    document.preloadPages();

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: LoadingWidget(
            isImage: true,
          ))
        : PDFViewer(
            document: document,
            scrollDirection: Axis.horizontal,
            showIndicator: true,
            lazyLoad: false,
            enableSwipeNavigation: true,
            showNavigation: true,
            showPicker: true,
            navigationBuilder:
                (context, page, totalPages, jumpToPage, animateToPage) {
              return ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.first_page),
                    onPressed: () {
                      jumpToPage(page: 0);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      animateToPage(page: page - 2);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {
                      animateToPage(page: page);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.last_page),
                    onPressed: () {
                      jumpToPage(page: totalPages - 1);
                    },
                  ),
                ],
              );
            },
          );
  }
}
