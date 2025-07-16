class PaginatedResponse<T> {
  final List<T> data;
  final Links links;
  final Meta meta;

  PaginatedResponse({
    required this.data,
    required this.links,
    required this.meta,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PaginatedResponse(
      data: List<T>.from(
        json['data'].map((item) => fromJsonT(item as Map<String, dynamic>)),
      ),
      links: Links.fromJson(json['links']),
      meta: Meta.fromJson(json['meta']),
    );
  }
}

class Links {
  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  Links({this.first, this.last, this.prev, this.next});

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      first: json['first'],
      last: json['last'],
      prev: json['prev'],
      next: json['next'],
    );
  }
}

class Meta {
  final int currentPage;
  final int from;
  final int lastPage;
  final List<Link> links;
  final String path;
  final int perPage;
  final int to;
  final int total;

  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json['current_page'],
      from: json['from'],
      lastPage: json['last_page'],
      links: List<Link>.from(json['links'].map((x) => Link.fromJson(x))),
      path: json['path'],
      perPage: json['per_page'],
      to: json['to'],
      total: json['total'],
    );
  }
}

class Link {
  final String? url;
  final String label;
  final bool active;

  Link({this.url, required this.label, required this.active});

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(url: json['url'], label: json['label'], active: json['active']);
  }
}
