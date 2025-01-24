// import 'package:aqsa_key_game/features/player/games/models/input_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:aqsa_key_game/core/utils/colors/app_colors.dart';

// class QRCodeInput extends StatefulWidget {
//   final InputModel inputModel;
//   final void Function(String)? onValidated;

//   const QRCodeInput({
//     super.key,
//     required this.inputModel,
//     this.onValidated,
//   });

//   @override
//   QRCodeInputState createState() => QRCodeInputState();
// }

// class QRCodeInputState extends State<QRCodeInput> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   Barcode? scannedData;
//   QRViewController? controller;
//   String? validationMessage;
//   bool isValid = false;

//   @override
//   void reassemble() {
//     super.reassemble();
//     if (controller != null) {
//       controller!.pauseCamera();
//       controller!.resumeCamera();
//     }
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }

//   void _onQRViewCreated(QRViewController qrController) {
//     this.controller = qrController;
//     qrController.scannedDataStream.listen((scanData) {
//       if (mounted) {
//         setState(() {
//           scannedData = scanData;
//         });
//         _validateScannedData(scanData.code);
//         // Optionally pause the camera after successful scan
//         qrController.pauseCamera();
//       }
//     });
//   }

//   void _validateScannedData(String? code) {
//     if (code == null) return;

//     if (widget.inputModel.possibleAnswers != null &&
//         widget.inputModel.possibleAnswers!.isNotEmpty) {
//       if (widget.inputModel.possibleAnswers!.contains(code.trim())) {
//         setState(() {
//           isValid = true;
//           validationMessage = 'رمز QR صالح!';
//         });
//         if (widget.onValidated != null) {
//           widget.onValidated!(code.trim());
//         }
//       } else {
//         setState(() {
//           isValid = false;
//           validationMessage = 'رمز QR غير صالح. يرجى المحاولة مرة أخرى.';
//         });
//         // Resume camera for another scan attempt
//         controller?.resumeCamera();
//       }
//     } else {
//       // If no possibleAnswers provided, consider any scan as valid
//       setState(() {
//         isValid = true;
//         validationMessage = 'تم مسح QR السريعة بنجاح!';
//       });
//       if (widget.onValidated != null) {
//         widget.onValidated!(code.trim());
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Display Instructions if available
//         if (widget.inputModel.instructions != null)
//           Padding(
//             padding: EdgeInsets.only(bottom: 16.h),
//             child: Text(
//               widget.inputModel.instructions.toString(),
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 fontWeight: FontWeight.w500,
//                 color: AppColors.kDarkGreyColor,
//               ),
//             ),
//           ),

//         // QR Code Scanner Container
//         Container(
//           height: 250.h,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16.r),
//             border: Border.all(
//               color: AppColors.kPrimary1Color,
//               width: 2.w,
//             ),
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(16.r),
//             child: QRView(
//               key: qrKey,
//               onQRViewCreated: _onQRViewCreated,
//               overlay: QrScannerOverlayShape(
//                 borderColor: AppColors.kPrimary1Color,
//                 borderRadius: 10.r,
//                 borderLength: 30.w,
//                 borderWidth: 10.w,
//                 cutOutSize: 200.w,
//               ),
//               onPermissionSet: (ctrl, p) {
//                 if (!p) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                         content: Text('لا توجد صلاحية للوصول إلى الكاميرا.')),
//                   );
//                 }
//               },
//             ),
//           ),
//         ),

//         SizedBox(height: 16.h),

//         // Validation Message
//         if (validationMessage != null)
//           Text(
//             validationMessage!,
//             style: TextStyle(
//               fontSize: 14.sp,
//               color: isValid ? Colors.green : Colors.red,
//               fontWeight: FontWeight.w600,
//             ),
//           ),

//         // Optional: Retry Button if invalid
//         if (validationMessage != null && !isValid)
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 validationMessage = null;
//                 isValid = false;
//               });
//               controller?.resumeCamera();
//             },
//             child: Text(
//               'حاول مرة أخرى.',
//               style: TextStyle(
//                 color: AppColors.kPrimary1Color,
//                 fontSize: 14.sp,
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }
