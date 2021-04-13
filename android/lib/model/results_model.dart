class Results {
  int id;
  int digitalId;
  String title;
  int issueNumber;
  String variantDescription;
  String description;
  String modified;
  String isbn;
  String upc;
  String diamondCode;
  String ean;
  String issn;
  String format;
  int pageCount;
  List<dynamic> textObjects;
  String resourceURI;
  List<dynamic> urls;
  dynamic series;
  List<dynamic> variants;
  List<dynamic> collections;
  List<dynamic> collectedIssues;
  List<dynamic> dates;
  List<dynamic> prices;
  dynamic thumbnail;
  List<dynamic> images;
  dynamic creators;
  dynamic characters;
  dynamic stories;
  dynamic events;

  Results(
      {this.id,
      this.digitalId,
      this.title,
      this.issueNumber,
      this.variantDescription,
      this.description,
      this.modified,
      this.isbn,
      this.upc,
      this.diamondCode,
      this.ean,
      this.issn,
      this.format,
      this.pageCount,
      this.textObjects,
      this.resourceURI,
      this.urls,
      this.series,
      this.variants,
      this.collections,
      this.collectedIssues,
      this.dates,
      this.prices,
      this.thumbnail,
      this.images,
      this.creators,
      this.characters,
      this.stories,
      this.events});

  Results.fromJson(dynamic json) {
    id = json['id'];
    digitalId = json['digitalId'];
    title = json['title'];
    issueNumber = json['issueNumber'];
    variantDescription = json['variantDescription'];
    description = json['description'];
    modified = json['modified'];
    isbn = json['isbn'];
    upc = json['upc'];
    diamondCode = json['diamondCode'];
    ean = json['ean'];
    issn = json['issn'];
    format = json['format'];
    pageCount = json['pageCount'];
    if(json['textObjects'] != null)
    resourceURI = json['resourceURI'];
    if(json['urls'] != null)
      urls = json['urls'];
    if(json['series'] != null)
      series = json['series'];
    if(json['variants'] != null)
      variants = json['variants'];
    if(json['collections'] != null)
      collections = json['collections'];
    if(json['collectedIssues'] != null)
      collectedIssues = json['collectedIssues'];
    if (json['dates'] != null) {
      dates = json['dates'];
    }
    if (json['prices'] != null) {
      prices = json['prices'];
    }
    thumbnail = json['thumbnail'] != null
        ? json['thumbnail']
        : null;
    if (json['images'] != null) {
      images = json['images'];
    }
    creators = json['creators'] != null
        ? json['creators']
        : null;
    characters = json['characters'] != null
        ? json['characters']
        : null;
    stories =
        json['stories'] != null ? json['stories'] : null;
    events =
        json['events'] != null ? json['events'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['digitalId'] = this.digitalId;
    data['title'] = this.title;
    data['issueNumber'] = this.issueNumber;
    data['variantDescription'] = this.variantDescription;
    data['description'] = this.description;
    data['modified'] = this.modified;
    data['isbn'] = this.isbn;
    data['upc'] = this.upc;
    data['diamondCode'] = this.diamondCode;
    data['ean'] = this.ean;
    data['issn'] = this.issn;
    data['format'] = this.format;
    data['pageCount'] = this.pageCount;
    if (this.textObjects != null) {
      data['textObjects'] = textObjects;
    }
    data['resourceURI'] = this.resourceURI;
    if (this.urls != null) {
      data['urls'] = this.urls.map((v) => v.toJson()).toList();
    }
    if (this.series != null) {
      data['series'] = this.series.toJson();
    }
    if (this.variants != null) {
      data['variants'] = this.variants.map((v) => v.toJson()).toList();
    }
    if (this.collections != null) {
      data['collections'] = this.collections.map((v) => v.toJson()).toList();
    }
    if (this.collectedIssues != null) {
      data['collectedIssues'] =
          this.collectedIssues.map((v) => v.toJson()).toList();
    }
    if (this.dates != null) {
      data['dates'] = this.dates.map((v) => v.toJson()).toList();
    }
    if (this.prices != null) {
      data['prices'] = this.prices.map((v) => v.toJson()).toList();
    }
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    if (this.creators != null) {
      data['creators'] = this.creators.toJson();
    }
    if (this.characters != null) {
      data['characters'] = this.characters.toJson();
    }
    if (this.stories != null) {
      data['stories'] = this.stories.toJson();
    }
    if (this.events != null) {
      data['events'] = this.events.toJson();
    }
    return data;
  }
}