import 'package:aqsa_key_game/core/utils/colors/app_colors.dart';
import 'package:aqsa_key_game/features/player/games/models/output_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageDisplayWidget extends StatelessWidget {
  final OutputModel outputModel;

  const ImageDisplayWidget({
    super.key,
    required this.outputModel,
  });

  @override
  Widget build(BuildContext context) {
    // Determine if the OutputModel is of type 'image' and has valid data
    if (outputModel.type != 'image' || outputModel.data == null) {
      return _buildErrorWidget('Invalid image data.');
    }

    // Construct the image path
    String imagePath = 'assets/images/${outputModel.data}';

    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.kWhiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.kDarkGreyColor.withOpacity(0.1),
            blurRadius: 10.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: GestureDetector(
          onTap: () {
            // Optional: Implement full-screen image viewing
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FullScreenImageView(imagePath: imagePath),
              ),
            );
          },
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return _buildErrorWidget('Failed to load image.');
            },
          ),
        ),
      ),
    );
  }

  // Helper method to build error widgets
  Widget _buildErrorWidget(String message) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.kWhiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.kDarkGreyColor.withOpacity(0.1),
            blurRadius: 10.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: Center(
        child: Text(
          message,
          style: TextStyle(
            color: Colors.red,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}

// Optional: Full-Screen Image View Widget
class FullScreenImageView extends StatelessWidget {
  final String imagePath;

  const FullScreenImageView({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background color for full-screen
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // Close button
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white, size: 24.sp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return Center(
                child: Text(
                  'Failed to load image.',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16.sp,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
