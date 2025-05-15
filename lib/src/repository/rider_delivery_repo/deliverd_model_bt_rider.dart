class DeliveryStatusResponse {
  final String message;
  final String status;

  DeliveryStatusResponse({required this.message, required this.status});

  factory DeliveryStatusResponse.fromJson(Map<String, dynamic> json) {
    return DeliveryStatusResponse(
      message: json['message'] ?? '',
      status: json['data']?['order']?['status'] ?? '',
    );
  }
}
