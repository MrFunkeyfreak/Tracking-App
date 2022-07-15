// data-model for the routing data - get used in string_extension to display the route and queryParameters
// query parameters are not in use, because I hadn't enough time to insert videos in the website (so always empty)
class RoutingData {
  final String? route;
  final Map<String, String>? _queryParameters;

  RoutingData({
    this.route,
    Map<String, String>? queryParameters,
  }) : _queryParameters = queryParameters;

  operator [](String key) => _queryParameters![key];
}
