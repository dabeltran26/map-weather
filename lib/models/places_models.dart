
class ResponseSearch {

    ResponseSearch({
        required this.type,
        required this.query,
        required this.features,
        required this.attribution,
    });

    String type;
    List<String> query;
    List<Feature> features;
    String attribution;

    factory ResponseSearch.fromJson(Map<String, dynamic> json) => ResponseSearch(
        type: json["type"],
        query: List<String>.from(json["query"].map((x) => x)),
        features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
        attribution: json["attribution"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "query": List<dynamic>.from(query.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "attribution": attribution,
    };
}

class Feature {
    Feature({
        required this.id,
        required this.type,
        required this.placeType,
        required this.relevance,
        required this.properties,
        required this.text,
        required this.placeName,
        required this.matchingText,
        required this.matchingPlaceName,
        required this.center,
        required this.geometry,
        required this.address,
        required this.context,
    });

    String id;
    String type;
    List<String> placeType;
    double relevance;
    Properties properties;
    String text;
    String placeName;
    String matchingText;
    String matchingPlaceName;
    List<double> center;
    Geometry geometry;
    String address;
    List<Context> context;

    factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        relevance: json["relevance"].toDouble(),
        properties: Properties.fromJson(json["properties"]),
        text: json["text"],
        placeName: json["place_name"],
        matchingText: json["matching_text"] ?? '',
        matchingPlaceName: json["matching_place_name"]  ?? '',
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
        geometry: Geometry.fromJson(json["geometry"]),
        address: json["address"] ??  '',
        context: List<Context>.from(json["context"].map((x) => Context.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType.map((x) => x)),
        "relevance": relevance,
        "properties": properties.toJson(),
        "text": text,
        "place_name": placeName,
        "matching_text": matchingText,
        "matching_place_name": matchingPlaceName,
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toJson(),
        "address": address,
        "context": List<dynamic>.from(context.map((x) => x.toJson())),
    };
}

class Context {
    Context({
        required this.id,
        required this.text,
        required this.wikidata,
        required this.shortCode,
    });

    String id;
    String text;
    String wikidata;
    String shortCode;

    factory Context.fromJson(Map<String, dynamic> json) => Context(
        id: json["id"]?? '',
        text: json["text"]?? '',
        wikidata: json["wikidata"] ?? '',
        shortCode: json["short_code"]?? '',
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "wikidata": wikidata,
        "short_code": shortCode,
    };
}

enum ShortCode { US_IL, US }

class Geometry {
    Geometry({
        required this.type,
        required this.coordinates,
        required this.interpolated,
        required this.omitted,
    });

    String type;
    List<double> coordinates;
    bool interpolated;
    bool omitted;

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        interpolated: json["interpolated"] ??  false,
        omitted: json["omitted"] ?? false,
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "interpolated": interpolated == null ? null : interpolated,
        "omitted": omitted == null ? null : omitted,
    };
}

class Properties {
    Properties();

    factory Properties.fromJson(Map<String, dynamic> json) => Properties(
    );

    Map<String, dynamic> toJson() => {
    };
}
