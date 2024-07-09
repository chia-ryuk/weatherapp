class PreferredLocationResponse {
  String? data;

  PreferredLocationResponse({this.data});

  /// Creates a [PreferredLocationResponse] instance from a JSON object.
  /// The [json] parameter is a map representing the JSON object.

  PreferredLocationResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'];
  }

  /// Converts the [PreferredLocationResponse] instance to a JSON object.
  /// Returns a map representing the JSON object.

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data;
    }
    return data;
  }
}
