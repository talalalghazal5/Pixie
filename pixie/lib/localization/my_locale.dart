import 'package:get/get.dart';

class MyLocale implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar": {
          //Loading Page
          "waitingMessage": "لحظة من فضلك",

          //Navigation Bar
          "homePageNavBarTab": "الرئيسية",
          "searchPageNavBarTab": "البحث",
          "favoritesPageNavBarTab": "المفضلات",
          "settingsPageNavBarTab": "الإعدادات",

          //home page

          //error message
          "errorMessage": "حدث خطأ في الشبكة",

          //retry button
          "retryCTA": "إعادة المحاولة",

          //load more button
          "loadMoreCTA": "تحميل المزيد",

          //Search Page
          "inputFieldHint": "ابحث عن أي شيء",

          //Category Cards
          //categories
          "youMightLikeHeading": "أشياء قد تعجبك",
          "Animals": "حيوانات",
          "Nature": "طبيعة",
          "Food": "طعام",
          "Architecture": "أبنية وعمارة",
          "Minimal": "بسيط",
          "Space": "الفضاء",
          //colors
          "searchByColorsHeading": "ابحث بالألوان",
          "Blue": "أزرق",
          "Red": "أحمر",
          "Green": "أخضر",
          "Brown": "بني",
          "Black": "أسود",
          "White": "أبيض",

          //Results Page
          "noResultsFound": " لم يتم العثور على نتائج لـ",
          "resultHeaderTitle": " يتم عرض النتائج لـ",

          //Favorites Page
          "emptyPageLabel": "لاشيء هنا",

          //Settings Page
          "settingsHeading": "الإعدادات",
          //dark mode switch
          "darkModeSwitchTitle": "الوضع الداكن",
          //languages list
          "languageListLabel": "اللغة",
          //languages
          "arabic": "العربية",
          //my credits
          "myName": "تم إنشاؤه بواسطة طلال الغزال",
          "copyrights": "الحقوق محفوظة",
          //pexels credits
          "poweredBy": "تم تشغيله بواسطة"
          //Preview Page
          ,
          //error fetching photo
          "errorFetchingPhotoMessage": "لم يتم تحميل الصورة",
          "takenBy": "تم التقاطها بواسطة:",

          //favorites button
          //favorite addition snackbar
          "favoriteAdditionSnackbarMessage": "تمت إضافتها إلى المفضلات",
          //favorite removal snackbar
          "favoriteRemovalSnackbarMessage": "تمت إزالتها من المفضلات",

          //download button
          //download started
          "downloadStartedSnackbarMessage": "جاري تحميل الصورة...",
          //download finished success
          "downloadedSuccessfullySnackbarMessage": "تم التحميل بنجاح",
          //download failed
          "downloadFailedSnackbarMessage": "فشل التحميل، حاول مجدداً",

          //set wallpaper button
          //dialog
          "dialogTitle": "اختر شاشة الخلفية:",
          "homeScreenChoice": "الشاشة الرئيسية",
          "lockScreenChoice": "شاشة القفل",
          "bothScreensChoice": "الشاشتين معاً",
          "cancelCTA": "إلغاء الأمر",
          "saveCTA": "حفظ",
          //wallpaper application message
          "appliedWallpaperSnackbarMessage": "تم تعيين الخلفية",

          //errors:
          "connectionError": "خطأ في الشبكة، يرجى المحاولة مجدداً",
          "connectionTimedOut": "انتهت مدة الاتصال، حاول مجدداً",
          "unkownError": "خطأ غير معروف، حاول مجدداً",
        },
        "en": {
          //Loading Page
          "waitingMessage": "Just a moment please",

          //Navigation Bar
          "homePageNavBarTab": "Home",
          "searchPageNavBarTab": "Search",
          "favoritesPageNavBarTab": "Favorites",
          "settingsPageNavBarTab": "Settings",

          //home page

          //error message
          "errorMessage": "No internet connection",

          //retry button
          "retryCTA": "Retry",

          "loadMoreCTA": "Load more",

          //Search Page
          "inputFieldHint": "Search anything",

          //Category Cards
          //categories
          "youMightLikeHeading": "You might like",
          "animalsCategoryCard": "Animals",
          "natureCategoryCard": "Nature",
          "foodCategoryCard": "Food",
          "architectureCategoryCard": "Architecture",
          "minimalCategoryCard": "Minimal",
          "spaceCategoryCard": "Space",
          //colors
          "searchByColorsHeading": "Search by colors",
          "blueCategoryCard": "Blue",
          "redCategoryCard": "Red",
          "greenCategoryCard": "Green",
          "brownCategoryCard": "Brown",
          "blackCategoryCard": "Black",
          "whiteCategoryCard": "White",

          //Results Page
          "noResultsFound": "No results found for",
          "resultHeaderTitle": "Showing results for ",

          //Favorites Page
          "emptyPageLabel": "Nothing here",

          //Settings Page
          "settingsHeading": "Settings",
          //dark mode switch
          "darkModeSwitchTitle": "Dark mode",
          //languages list
          "languageListLabel": "Language",
          //languages
          "arabic": "العربية",
          "english": "English",
          //my credits
          "myName": "Made by Talal Alghazal",
          "copyrights": "Copyrights reserved",
          //pexels credits
          "poweredBy": "Powered by",

          //Preview Page

          //error fetching photo
          "errorFetchingPhotoMessage": "Could not load photo",

          //taken by
          "takenBy": "Taken by:",

          //favorites button
          //favorite addition snackbar
          "favoriteAdditionSnackbarMessage": "Added to favorites",
          //favorite removal snackbar
          "favoriteRemovalSnackbarMessage": "Removed from favorites",

          //download button
          //download started
          "downloadStartedSnackbarMessage": "Downloading photo...",
          //download finished success
          "downloadedSuccessfullySnackbarMessage": "Downloaded successfully",
          //download failed
          "downloadFailedSnackbarMessage": "Download failed, try again",

          //set wallpaper button
          //dialog
          "dialogTitle": "Choose where to apply",
          "homeScreenChoice": "Home screen",
          "lockScreenChoice": "Lock screen",
          "bothScreensChoice": "Both screens",
          "cancelCTA": "Cancel",
          "saveCTA": "Save",
          //wallpaper application message
          "appliedWallpaperSnackbarMessage": "Applied wallpaper",

          //errors:
          "connectionError": "Connection error, please retry again",
          "connectionTimedOut": "Connection timed out, please retry again",
          "unkownError": "Unkown error occured, please retry again",
        },
      };
}
