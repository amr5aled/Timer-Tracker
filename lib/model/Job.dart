class job {
  job( {
    this.idDocument,
    this.name,
    this.rateperhour,
  });
  final String name;
  final int rateperhour;
  final String idDocument;
  factory job.fromMap(Map<String, dynamic> data, String id) {// read
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    final int rateperhour = data['rateperhour'];
    return job(
      idDocument:id,
      name: name,
      rateperhour: rateperhour,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'rateperhour': rateperhour,
    };
  }
}
