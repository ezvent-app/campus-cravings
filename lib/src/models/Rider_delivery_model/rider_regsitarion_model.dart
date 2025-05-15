class RiderStatusResponse {
  final String message;
  final RiderStatusData data;

  RiderStatusResponse({required this.message, required this.data});

  factory RiderStatusResponse.fromJson(Map<String, dynamic> json) {
    return RiderStatusResponse(
      message: json['message'],
      data: RiderStatusData.fromJson(json['data']),
    );
  }
}

class RiderStatusData {
  final String status;
  final String id;

  RiderStatusData({required this.status, required this.id});

  factory RiderStatusData.fromJson(Map<String, dynamic> json) {
    return RiderStatusData(status: json['status'], id: json['user']);
  }
}
