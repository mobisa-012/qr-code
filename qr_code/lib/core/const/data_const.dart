import 'package:qr_code/core/const/path_const.dart';
import 'package:qr_code/core/const/text_const.dart';
import 'package:qr_code/screens/onboarding/widget/onboarding_tile.dart';

class DataConstants {
  static final onboardingTiles =[
    const OnboardingTile(
      title: TextConstants.getStarted,
      description: TextConstants.codes,
      image: PathConstants.code,
    ),
    const OnboardingTile(
      title: TextConstants.getStarted,
      description: TextConstants.isometric,
      image: PathConstants.scan,
    ),
  ];
}