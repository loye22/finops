import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'dart:html' as html;


class staticVar {

  static double fullWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double fullhigth(BuildContext context) =>
      MediaQuery.of(context).size.height;




  static Widget loading(
          {double size = 100,
          Color colors = const Color(0xff10277C),
          bool disableCenter = true}) =>
      disableCenter
          ? Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: colors,
              size: size,
            ),
          )
          : Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: colors,
                size: size,
              ),
            );


  static Future<void> showSubscriptionSnackbar(
      {required BuildContext context,
      required String msg,
      Color color = const Color(0xFF1ABC9C)}) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(msg),
      ),
    );
  }





  // /// THis functions gonna export the data into files
  // static void downloadFile(String url) {
  //   html.AnchorElement anchorElement = new html.AnchorElement(href: url)
  //     ..setAttribute("download", "")
  //     ..click();
  //   //
  //   // html.AnchorElement anchorElement =  new html.AnchorElement(href: url);
  //   // anchorElement.download = url;
  //   // anchorElement.click();
  // }
  //
  // static void downloadFile2(String url) async {
  //   try {
  //     // Fetch the file content
  //     final response =
  //         await html.HttpRequest.request(url, responseType: 'blob');
  //     final blob = response.response as html.Blob;
  //
  //     // Create an object URL from the Blob
  //     final objectUrl = html.Url.createObjectUrlFromBlob(blob);
  //
  //     // Create a hidden anchor element
  //     final anchorElement = html.AnchorElement(href: objectUrl)
  //       ..setAttribute("download", "")
  //       ..style.display = 'none';
  //
  //     // Add the anchor to the DOM
  //     html.document.body?.append(anchorElement);
  //
  //     // Trigger the download
  //     anchorElement.click();
  //
  //     // Clean up by removing the anchor and revoking the object URL
  //     anchorElement.remove();
  //     html.Url.revokeObjectUrl(objectUrl);
  //   } catch (e) {}
  // }


  static String urlAPI = "https://api.appsheet.com/api/v2/apps/feca6ac3-46a6-4a65-8eb9-a638f09348ab/tables/";
  static Color themeColor =  const Color(0xff10277C);

  static DateTime convertStringToDate(String? dateStr) {
    if(dateStr == null ){
      return DateTime(1100);
    }
    try {
      // Define the date format matching your input
      final DateFormat dateFormat = DateFormat('MM/dd/yyyy');
      // Parse the string and return the DateTime object
      return dateFormat.parse(dateStr);
    }
    catch(e){
      return DateTime(0000-00-00);
    }
  }

}
