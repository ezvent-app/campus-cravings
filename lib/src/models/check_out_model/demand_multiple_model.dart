class DemandDataModel {
  final DemandData? data;

  DemandDataModel({this.data});

  factory DemandDataModel.fromJson(Map<String, dynamic> json) {
    return DemandDataModel(
      data: json['data'] != null ? DemandData.fromJson(json['data']) : null,
    );
  }
}

class DemandData {
  final int unassignedOrders;
  final int availableRiders;
  final double getDemandMultiple;

  DemandData({
    required this.unassignedOrders,
    required this.availableRiders,
    required this.getDemandMultiple,
  });

  factory DemandData.fromJson(Map<String, dynamic> json) {
    return DemandData(
      unassignedOrders: json['unassignedOrders'],
      availableRiders: json['availableRiders'],
      getDemandMultiple: (json['getDemandMultiple'] as num).toDouble(),
    );
  }
}
