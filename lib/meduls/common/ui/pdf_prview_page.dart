import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatlli/core/utils/app_model.dart';
import 'package:hatlli/meduls/common/bloc/home_cubit/home_cubit.dart';
import 'package:hatlli/meduls/common/models/provider.dart';
import 'package:hatlli/meduls/provider/models/review_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatefulWidget {
  final ReviewModel reviewModel;
  final String startDat, endDate;
  PdfPreviewPage(
      {required this.reviewModel,
      required this.startDat,
      required this.endDate});

  @override
  State<PdfPreviewPage> createState() => _PdfPreviewPageState();
}

class _PdfPreviewPageState extends State<PdfPreviewPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(""),
          ),
          body: PdfPreview(
            build: (context) => makePdf(state.homeResponseProvider!.provider!),
          ),
        );
      },
    );
  }

  Future<Uint8List> makePdf(Provider provider) async {
    final font = await rootBundle.load("assets/fonts/cairo-bold.ttf");
    final ttf = pw.Font.ttf(font);
    final pdf = pw.Document();
    final ByteData bytes =
        await rootBundle.load('assets/images/logo_black.png');
    final Uint8List byteList = bytes.buffer.asUint8List();
    pdf.addPage(pw.Page(
        textDirection: pw.TextDirection.rtl,
        theme: pw.ThemeData.withFont(
          base: ttf,
        ),
        // margin: const pw.EdgeInsets.all(10),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Image(pw.MemoryImage(byteList), fit: pw.BoxFit.cover),
                      pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text("from ${widget.startDat}",
                                style: pw.TextStyle(
                                  color: PdfColor.fromHex("#000000"),
                                  fontSize: 15,
                                  // fontWeight: pw.FontWeight.bold,
                                )),
                            pw.Text("to ${widget.endDate}",
                                textDirection: pw.TextDirection.rtl,
                                style: pw.TextStyle(
                                    color: PdfColor.fromHex("#000000"),
                                    fontSize: 15,
                                    fontWeight: pw.FontWeight.bold,
                                    font: ttf)),
                          ])
                    ]),
                pw.Divider(borderStyle: pw.BorderStyle.dashed),
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Full Name : ${provider.title}",
                          style: pw.TextStyle(
                            color: PdfColor.fromHex("#000000"),
                            fontSize: 16,
                            fontWeight: pw.FontWeight.normal,
                          )),
                      pw.Text("E-email : ${provider.email}",
                          style: pw.TextStyle(
                            color: PdfColor.fromHex("#000000"),
                            fontSize: 16,
                            fontWeight: pw.FontWeight.normal,
                          )),
                      pw.Text("Phone : ${currentUser.userName}",
                          style: pw.TextStyle(
                            color: PdfColor.fromHex("#000000"),
                            fontSize: 16,
                            fontWeight: pw.FontWeight.normal,
                          ))
                    ]),
                pw.SizedBox(height: 55),
                pw.Column(children: [
                  containerPdf(
                      title: "Orders",
                      value: widget.reviewModel.ordersCanceled.toString()),
                  containerPdf(
                      title: "Accepted",
                      value: widget.reviewModel.ordersAccepted.toString()),
                  containerPdf(
                      title: "Cancelled",
                      value: (widget.reviewModel.ordersCanceled -
                              widget.reviewModel.ordersAccepted)
                          .toString()),
                  containerPdf(
                      title: "Products Created",
                      value: widget.reviewModel.products.toString()),
                  containerPdf(
                      title: "Your Wallet",
                      value: widget.reviewModel.wallet.toString())
                ])
              ]);
        }));
    return pdf.save();
  }

  containerPdf({title, value}) {
    return pw.Container(
        decoration: pw.BoxDecoration(
            border: pw.Border(
                bottom: pw.BorderSide(
                    color: PdfColor.fromHex("#000000"), width: 1))),
        child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.all(4),
                child: pw.Text(title,
                    style: pw.TextStyle(
                      color: PdfColor.fromHex("#000000"),
                      fontSize: 30,
                      // fontWeight: pw.FontWeight.bold,
                    )),
              ),
              pw.Padding(
                padding: pw.EdgeInsets.all(4),
                child: pw.Text(value,
                    style: pw.TextStyle(
                      color: PdfColor.fromHex("#000000"),
                      fontSize: 30,
                      // fontWeight: pw.FontWeight.bold,
                    )),
              ),
            ]));
  }
}
