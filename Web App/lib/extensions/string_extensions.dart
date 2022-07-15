import '../datamodels/routing_data.dart';

// displays the route of the page and the queryParameters.
// query parameters are not in use, because I hadn't enough time to insert videos in the website (so always empty)
extension StringExtension on String {
  RoutingData get getRoutingData {
    var uriData = Uri.parse(this);
    print('queryParameters: ${uriData.queryParameters} path: ${uriData.path}');
    return RoutingData(
      //queryParameters: uriData.queryParameters,
      route: uriData.path,
    );
  }
}
