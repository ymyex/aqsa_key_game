class AssetsData {
  // images
  static const String noImage = 'assets/images/No_image_available.png';
  static const String loginBanner = "assets/images/Login_banner.png";
  static const String registerBanner = "assets/images/Register_banner.png";
  static const String placeholderImage = "assets/images/image_placeholder.png";
  static const String basmalaImage = "assets/images/Bismillah.png";
  static const String ayaNumberContainerImage =
      'assets/images/aya_number_container.svg';
  static const String welcomeBackground =
      'assets/images/welcome_background.png';

  // icons
  static const String facebookIcon = "assets/icons/facebook_icon.svg";
  static const String googleIcon = "assets/icons/google_icon.svg";
  static const String appleIcon = "assets/icons/apple_icon.svg";
  static const String quranIcon = 'assets/icons/quran_icon.svg'; // Fixed typo
  static const String progressIcon = 'assets/icons/progress_icon.svg';
  static const String learningIcon =
      'assets/icons/learning_icon.svg'; // Fixed typo
  static const String challengeIcon = 'assets/icons/challenge_icon.svg';
  static const String chatIcon = 'assets/icons/chat_icon.svg';
  static const String navBarSelectedHomeIcon =
      'assets/icons/nav_bar_home_selected_icon.svg';
  static const String navBarHomeIcon = 'assets/icons/nav_bar_home_icon.svg';
  static const String navBarSelectedProgressIcon =
      'assets/icons/nav_bar_selected_progress_icon.svg';
  static const String navBarProgressIcon =
      'assets/icons/nav_bar_progress_icon.svg';
  static const String navBarSelectedQuranIcon =
      'assets/icons/nav_bar_selected_quran_icon.svg';
  static const String navBarQuranIcon = 'assets/icons/nav_bar_quran_icon.svg';
  static const String navBarSelectedLearningIcon =
      'assets/icons/nav_bar_selected_learning_icon.svg';
  static const String navBarLearningIcon =
      'assets/icons/nav_bar_learning_icon.svg';
  static const String listIcon = 'assets/icons/list_icon.svg';
  static const String listRightIcon = 'assets/icons/list_right_icon.svg';
  static const String worldIcon = 'assets/icons/world_icon.svg';
  static const String saveIcon = 'assets/icons/save_icon.svg';
  static const String selectedSaveIcon = 'assets/icons/selected_save_icon.svg';
  static const String selectedLanguageToggleIcon =
      'assets/icons/selected_language_toggle_icon.svg';
  static const String unSelectedLanguageToggleIcon =
      'assets/icons/unselected_language_toggle_icon.svg';
  static const String knowledgeSeekerIcon =
      'assets/icons/knowledge_seeker_icon.svg';
  static const String faithExplorerIcon =
      'assets/icons/faith_explorer_icon.svg';
  static const String communityBuilderIcon =
      'assets/icons/community_builder_icon.svg';
  static const String prophetLoverIcon = 'assets/icons/prophet_lover_icon.svg';

  // Newly added icons
  static const String backIcon = 'assets/icons/back_icon.svg';
  static const String islamicGraphicWhite =
      'assets/icons/islamic_graphic_white.svg';
  static const String islamicGraphicGreen =
      'assets/icons/islamic_graphic_green.svg';
  static const String badgeIcon = 'assets/icons/badge_icon.svg';
  static const String enrolledIcon = 'assets/icons/enrolled_icon.svg';
  static const String unenrolledIcon = 'assets/icons/unenrolled_icon.svg';
  static const String unenrolledBlackIcon =
      'assets/icons/unenrolled_black_icon.svg';
  static const String audioTypeIcon = 'assets/icons/audio_type.svg';
  static const String collapseIcon = 'assets/icons/collapse_icon.svg';
  static const String completionTimeIcon =
      'assets/icons/completion_time_icon.svg';
  static const String completionTimeBlueIcon =
      'assets/icons/completion_time_blue_icon.svg';
  static const String expandIcon = 'assets/icons/expand_icon.svg';
  static const String galleryTypeIcon = 'assets/icons/gallery_type_icon.svg';
  static const String infographicTypeIcon =
      'assets/icons/infographic_type_icon.svg';
  static const String lessonsIcon = 'assets/icons/lessons_icon.svg';
  static const String pointsIcon = 'assets/icons/points_icon.svg';
  static const String questionTypeIcon = 'assets/icons/question_type_icon.svg';
  static const String readingTypeIcon = 'assets/icons/reading_type_icon.svg';
  static const String videoTypeIcon = 'assets/icons/video_type_icon.svg';
  static const String questionBack = 'assets/icons/question_back.svg';
  static const String questionForward = 'assets/icons/question_forward.svg';
  static const String pointsLargeIcon = 'assets/icons/points_large_icon.svg';
  static const String pointsPurpleIcon = 'assets/icons/points_purple_icon.svg';
  static const String badgeLargeIcon = 'assets/icons/badge_large_icon.svg';
  static const String badgePurpleIcon = 'assets/icons/badge_purple_icon.svg';
  static const String deleteIcon = 'assets/icons/delete_icon.svg';
  static const String shareIcon = 'assets/icons/share_icon.svg';
  static const String audioIcon = 'assets/icons/audio_icon.svg';
  static const String playIcon = 'assets/icons/play_icon.svg';
  static const String forwardIcon = 'assets/icons/forward_icon.svg';
  static const String backwardIcon = 'assets/icons/backward_icon.svg';
  static const String pauseIcon = 'assets/icons/pause_icon.svg';
  static const String maximizeIcon = 'assets/icons/maximize_screen_icon.svg';
  static const String minimizeIcon = 'assets/icons/minimize_screen_icon.svg';
  static const String dragUpIcon = 'assets/icons/drag_up_icon.svg';
  static const String dragDownIcon = 'assets/icons/drag_down_icon.svg';
  static const String collapseWhiteIcon =
      'assets/icons/collapse_icon_white.svg';
  static const String expandWhiteIcon = 'assets/icons/expand_icon_white.svg';
  static const String calenderIcon = 'assets/icons/calender_icon.svg';
  static const String captionsIcon = 'assets/icons/captions_icon.svg';

  // Icons mapping for content types
  static const Map<String, String> contentTypeIcons = {
    'standard_video': videoTypeIcon,
    'portrait_video': videoTypeIcon,
    'video': videoTypeIcon,
    'infographic': infographicTypeIcon,
    'gallery': galleryTypeIcon,
    'image': galleryTypeIcon, // Assuming Image uses placeholder image
    'qa': questionTypeIcon
  };

  // Function to get the icon path based on content type
  static String getIconForContentType(String contentType) {
    return contentTypeIcons[contentType] ?? audioTypeIcon;
  }

  static String getIconByTitle(String title, {bool isPNG = false}) {
    print(
        "assets/icons/${title.replaceAll(' ', '')}_icon.${isPNG ? 'png' : 'svg'}");
    return "assets/icons/${title.replaceAll(' ', '')}_icon.${isPNG ? 'png' : 'svg'}";
  }
}
