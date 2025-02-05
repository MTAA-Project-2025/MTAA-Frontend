import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';

final specialTextButtonThemeData = TextButtonThemeData(
  style: TextButton.styleFrom(
    foregroundColor: whiteColor,
    backgroundColor: third1InvincibleColor,
    minimumSize: Size(100,57),
    textStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    disabledBackgroundColor: primarily0InvincibleColor
  )
);

final lightTextButtonThemeData = TextButtonThemeData(
  style: TextButton.styleFrom(
    foregroundColor: whiteColor,
    backgroundColor: secondary1InvincibleColor,
    minimumSize: Size(100,57),
    textStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    disabledBackgroundColor: primarily0InvincibleColor
  )
);

final darkTextButtonThemeData = TextButtonThemeData(
  style: TextButton.styleFrom(
    foregroundColor: whiteColor,
    backgroundColor: secondary1InvincibleColor,
    minimumSize: Size(100,57),
    textStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    disabledBackgroundColor: primarily0InvincibleColor
  )
);


final lightIconButtonThemeData = IconButtonThemeData(
  style: IconButton.styleFrom(
    foregroundColor: whiteColor,
  )
);

final darkIconButtonThemeData = IconButtonThemeData(
  style: IconButton.styleFrom(
    foregroundColor: whiteColor,
  )
);
