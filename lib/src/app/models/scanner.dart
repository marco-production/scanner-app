import 'dart:convert';

class Scanner {

  int? id = 0;
  String? type = '';
  String value;

  Scanner({
    this.id,
    this.type,
    required this.value
  }){
    if(value.contains('http')){
      this.type = 'url';
    }else{
      this.type = 'location';
    }
  }

  factory Scanner.fromJson( String jsonString ) => Scanner.fromMap(json.decode(jsonString));

  factory Scanner.fromMap( Map<String, dynamic> json ) => Scanner(
      id: json["id"],
      type: json["type"],
      value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "value": value
  };

}